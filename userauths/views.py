from rest_framework_simplejwt.views import TokenObtainPairView

from userauths.models import Profile, User
from userauths.serializers import MyTokenObtainPairSerializer, RegisterSerializer


class MyTokenObtainPairView(TokenObtainPairView):
    serializer_class = MyTokenObtainPairSerializer
