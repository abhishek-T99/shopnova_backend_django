from rest_framework import generics
from rest_framework.exceptions import NotFound
from rest_framework.permissions import AllowAny
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework_simplejwt.views import TokenObtainPairView

from userauths.helpers import generate_numeric_otp
from userauths.models import Profile, User
from userauths.serializers import MyTokenObtainPairSerializer, RegisterSerializer, UserSerializer


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

        try:
            user = User.objects.get(email=email)
        except User.DoesNotExist:
            raise NotFound({"error": "User with this email does not exist."})

        if user:
            user.otp = generate_numeric_otp()
            uidb64 = user.pk

            refresh = RefreshToken.for_user(user)
            reset_token = str(refresh.access_token)

            user.reset_token = reset_token
            user.save()

            link = f"http://localhost:5173/create-new-password?otp={user.otp}&uidb64={uidb64}&reset_token={reset_token}"

            print(link)

            # send Email

        return user
