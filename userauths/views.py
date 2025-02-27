from django.core.exceptions import ObjectDoesNotExist
from rest_framework import generics, status
from rest_framework.exceptions import NotFound
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
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

            link = f"http://localhost:5000/create-new-password?otp={user.otp}&uidb64={uidb64}&reset_token={reset_token}"

            print(link)

            # send Email

        return user


# class PasswordChangeView(generics.CreateAPIView):
#     permission_classes = (AllowAny,)
#     serializer_class = UserSerializer

#     def create(self, request, *args, **kwargs):
#         payload = request.data

#         otp = payload['otp']
#         uidb64 = payload['uidb64']
#         reset_token = payload['reset_token']
#         password = payload['password']

#         print("otp ======", otp)
#         print("uidb64 ======", uidb64)
#         print("reset_token ======", reset_token)
#         print("password ======", password)

#         user = User.objects.get(id=uidb64, otp=otp)
#         if user:
#             user.set_password(password)
#             user.otp = ""
#             user.reset_token = ""
#             user.save()


#             return Response( {"message": "Password Changed Successfully"}, status=status.HTTP_201_CREATED)
#         else:
#             return Response( {"message": "An Error Occured"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


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

            # Validate if all required fields are present
            if not all([otp, uidb64, reset_token, password]):
                return Response(
                    {"error": "All fields (otp, uidb64, reset_token, password) are required."},
                    status=status.HTTP_400_BAD_REQUEST,
                )

            # Ensure uidb64 is an integer
            try:
                uidb64 = int(uidb64)
            except ValueError:
                return Response({"error": "Invalid user ID."}, status=status.HTTP_400_BAD_REQUEST)

            # Fetch user
            try:
                user = User.objects.get(id=uidb64, otp=otp)
            except ObjectDoesNotExist:
                return Response({"error": "Invalid OTP or User ID."}, status=status.HTTP_400_BAD_REQUEST)

            # Validate reset token
            if user.reset_token != reset_token:
                return Response({"error": "Invalid reset token."}, status=status.HTTP_400_BAD_REQUEST)

            # Update password
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
