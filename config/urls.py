from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import include, path
from drf_yasg import openapi
from drf_yasg.views import get_schema_view
from environs import Env
from rest_framework import permissions

env = Env()
env.read_env()

schema_view = get_schema_view(
    openapi.Info(
        title="ShopNova APIs",
        default_version="v1",
        description="This is the API documentation for ShopNova APIs",
        terms_of_service="https://www.google.com/policies/terms/",
        contact=openapi.Contact(email=env("SENDER_EMAIL")),
        license=openapi.License(name="BSD License"),
    ),
    public=True,
    permission_classes=(permissions.AllowAny,),
)

urlpatterns = [
    # Swagger URLs
    path("swagger<format>/", schema_view.without_ui(cache_timeout=0), name="schema-json"),
    path("", schema_view.with_ui("swagger", cache_timeout=0), name="schema-swagger-ui"),
    path("redoc/", schema_view.with_ui("redoc", cache_timeout=0), name="schema-redoc"),
    # API V1 URLs
    path("api/v1/", include("api.urls")),
    # Admin URLs
    path("admin/", admin.site.urls),
]


urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
