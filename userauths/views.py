from django.conf import settings
from django.core.exceptions import ObjectDoesNotExist
from django.core.mail import EmailMultiAlternatives
from django.template.loader import render_to_string
from rest_framework import generics, status
from rest_framework.decorators import api_view
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework_simplejwt.views import TokenObtainPairView

from userauths.helpers import generate_numeric_otp
from userauths.models import Profile, User
from userauths.serializers import MyTokenObtainPairSerializer, ProfileSerializer, RegisterSerializer, UserSerializer
from .tasks import send_password_reset_email


@api_view(["GET"])
def getRoutes(request):
    routes = ["/api/token/", "/api/register/", "/api/token/refresh/", "/api/test/"]
    return Response(routes)


class ProfileView(generics.RetrieveAPIView):
    permission_classes = (AllowAny,)
    serializer_class = ProfileSerializer

    def get_object(self):
        user_id = self.kwargs["user_id"]

        user = User.objects.get(id=user_id)
        profile = Profile.objects.get(user=user)
        return profile


class MyTokenObtainPairView(TokenObtainPairView):
    serializer_class = MyTokenObtainPairSerializer


class RegisterView(generics.CreateAPIView):
    queryset = User.objects.all()
    permission_classes = (AllowAny,)

    serializer_class = RegisterSerializer


class PasswordEmailVerify(generics.RetrieveAPIView):
    permission_classes = (AllowAny,)
    serializer_class = UserSerializer

    def get_object(self):
        email = self.kwargs["email"]
        user = User.objects.get(email=email)

        if user:
            user.otp = generate_numeric_otp()
            uidb64 = user.pk

            refresh = RefreshToken.for_user(user)
            reset_token = str(refresh.access_token)

            user.reset_token = reset_token
            user.save()

            send_password_reset_email.apply_async(args=[user.id, user.otp, uidb64, reset_token])

        return user


class PasswordChangeView(generics.CreateAPIView):
    permission_classes = (AllowAny,)
    serializer_class = UserSerializer

    def create(self, request, *args, **kwargs):
        payload = request.data

        try:
            otp = payload.get("otp")
            uidb64 = payload.get("uidb64")
            reset_token = payload.get("reset_token")
            password = payload.get("password")

            if not all([otp, uidb64, reset_token, password]):
                return Response(
                    {"error": "All fields (otp, uidb64, reset_token, password) are required."},
                    status=status.HTTP_400_BAD_REQUEST,
                )

            try:
                uidb64 = int(uidb64)
            except ValueError:
                return Response({"error": "Invalid user ID."}, status=status.HTTP_400_BAD_REQUEST)

            try:
                user = User.objects.get(id=uidb64, otp=otp)
            except ObjectDoesNotExist:
                return Response({"error": "Invalid OTP or User ID."}, status=status.HTTP_400_BAD_REQUEST)
            if user.reset_token != reset_token:
                return Response({"error": "Invalid reset token."}, status=status.HTTP_400_BAD_REQUEST)

            user.set_password(password)
            user.otp = ""
            user.reset_token = ""
            user.save()

            return Response({"message": "Password changed successfully."}, status=status.HTTP_200_OK)

        except Exception as e:
            return Response(
                {"error": "An unexpected error occurred.", "details": str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
