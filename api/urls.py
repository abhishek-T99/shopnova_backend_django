from django.urls import path
from rest_framework_simplejwt.views import TokenRefreshView

from userauths import views as userauths_views

urlpatterns = [
    path("user/token/", userauths_views.MyTokenObtainPairView.as_view(), name="token_obtain_pair"),
    path("user/token/refresh/", TokenRefreshView.as_view(), name="token"),
    path("user/register/", userauths_views.RegisterView.as_view(), name="auth_register"),
    path("user/password-reset/<str:email>/", userauths_views.PasswordEmailVerify.as_view(), name="password_reset"),
]
