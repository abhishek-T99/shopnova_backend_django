import pytest
from django.contrib.auth import get_user_model
from rest_framework.test import APIClient

from userauths.models import Profile

User = get_user_model()


@pytest.fixture
def api_client():
    return APIClient()


@pytest.fixture
def create_user():
    def _create_user(email="test@example.com", password="testpass123", username="testuser"):
        return User.objects.create_user(email=email, password=password, username=username)

    return _create_user


@pytest.fixture
def create_profile(create_user):
    def _create_profile(user=None):
        if not user:
            user = create_user()
        return Profile.objects.create(user=user, full_name="Test User", bio="Test Bio")

    return _create_profile
