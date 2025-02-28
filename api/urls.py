from django.urls import path
from rest_framework_simplejwt.views import TokenRefreshView

from store import views as store_views
from userauths import views as userauths_views

urlpatterns = [
    # User auth views
    path("user/token/", userauths_views.MyTokenObtainPairView.as_view(), name="token_obtain_pair"),
    path("user/token/refresh/", TokenRefreshView.as_view(), name="token"),
    path("user/register/", userauths_views.RegisterView.as_view(), name="auth_register"),
    path("user/password-reset/<str:email>/", userauths_views.PasswordEmailVerify.as_view(), name="password_reset"),
    path("user/password-change/", userauths_views.PasswordChangeView.as_view(), name="password_change"),
    # Store views
    path("category/", store_views.CategoryListView.as_view(), name="category"),
    path("brand/", store_views.BrandListView.as_view(), name="brand"),
    path("products/", store_views.ProductListView.as_view(), name="products"),
    path("featured-products/", store_views.FeaturedProductListView.as_view(), name="featured-products"),
    path("products/<slug:slug>/", store_views.ProductDetailView.as_view(), name="brand"),
    path("cart-view/", store_views.CartApiView.as_view(), name="cart-view"),
    path("cart-list/<str:cart_id>/", store_views.CartListView.as_view(), name="cart-list"),
    path("cart-list/<str:cart_id>/<int:user_id>/", store_views.CartListView.as_view(), name="cart-list-with-user"),
    path("cart-detail/<str:cart_id>/", store_views.CartDetailView.as_view(), name="cart-detail"),
    path("cart-detail/<str:cart_id>/<int:user_id>/", store_views.CartDetailView.as_view(), name="cart-detail"),
    path("cart-delete/<str:cart_id>/<int:item_id>/", store_views.CartItemDeleteView.as_view(), name="cart-delete"),
    path(
        "cart-delete/<str:cart_id>/<int:item_id>/<int:user_id>/",
        store_views.CartItemDeleteView.as_view(),
        name="cart-delete",
    ),
    path("create-order/", store_views.CreateOrderView.as_view(), name="cart-delete"),
    path("checkout/<order_oid>/", store_views.CheckoutView.as_view(), name="checkout"),
    path("coupon/", store_views.CouponApiView.as_view(), name="coupon"),
    path("create-review/", store_views.ReviewRatingAPIView.as_view(), name="create-review"),
    path("reviews/<product_id>/", store_views.ReviewListView.as_view(), name="create-review"),
    path("search/", store_views.SearchProductsAPIView.as_view(), name="search"),
]
