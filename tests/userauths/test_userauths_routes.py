import pytest
from django.urls import reverse
from rest_framework import status
from rest_framework_simplejwt.tokens import RefreshToken

from userauths.models import User


@pytest.mark.django_db
def test_get_routes(api_client):
    url = reverse("get_routes")
    response = api_client.get(url)
    assert response.status_code == status.HTTP_200_OK
    assert isinstance(response.data, list)


@pytest.mark.django_db
def test_profile_view(api_client, create_profile):
    profile = create_profile()
    url = reverse("user_profile", kwargs={"user_id": profile.user.id})
    response = api_client.get(url)
    assert response.status_code == status.HTTP_200_OK
    assert response.data["full_name"] == profile.full_name


@pytest.mark.django_db
def test_register_view(api_client):
    url = reverse("auth_register")
    data = {
        "full_name": "Test User",
        "email": "newuser@example.com",
        "phone": "9841196929",
        "password": "newpass123",
        "password2": "newpass123",
    }
    response = api_client.post(url, data, format="json")
    assert response.status_code == status.HTTP_201_CREATED
    assert User.objects.filter(email="newuser@example.com").exists()


@pytest.mark.django_db
def test_token_obtain_pair_view(api_client, create_user):
    user = create_user()
    url = reverse("token_obtain_pair")
    data = {"email": user.email, "password": "testpass123"}
    response = api_client.post(url, data, format="json")
    assert response.status_code == status.HTTP_200_OK
    assert "access" in response.data
    assert "refresh" in response.data


@pytest.mark.django_db
def test_token_refresh_view(api_client, create_user):
    user = create_user()
    refresh = RefreshToken.for_user(user)
    url = reverse("token_refresh")
    data = {"refresh": str(refresh)}
    response = api_client.post(url, data, format="json")
    assert response.status_code == status.HTTP_200_OK
    assert "access" in response.data


@pytest.mark.django_db
def test_password_email_verify_view(api_client, create_user):
    user = create_user()
    url = reverse("password_reset", kwargs={"email": user.email})
    response = api_client.get(url)
    user.refresh_from_db()
    assert response.status_code == status.HTTP_200_OK
    assert user.otp is not None
    assert user.reset_token is not None


@pytest.mark.django_db
def test_password_change_view(api_client, create_user):
    user = create_user()
    refresh = RefreshToken.for_user(user)
    user.otp = "123456"
    user.reset_token = str(refresh.access_token)
    user.save()

    url = reverse("password_reset")
    data = {"otp": "123456", "uidb64": user.id, "reset_token": user.reset_token, "password": "newpassword123"}
    response = api_client.post(url, data, format="json")
    assert response.status_code == status.HTTP_200_OK
    assert response.data["message"] == "Password changed successfully."
    user.refresh_from_db()
    assert user.check_password("newpassword123")
