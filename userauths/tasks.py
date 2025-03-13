# core/tasks.py
from celery import shared_task
from django.core.mail import EmailMultiAlternatives
from django.template.loader import render_to_string
from django.conf import settings
from .models import User


@shared_task
def send_password_reset_email(user_id, otp, uidb64, reset_token):
    try:
        # Retrieve the user from the database
        user = User.objects.get(id=user_id)

        # Create the password reset link
        link = f"{settings.SITE_URL}/create-new-password?otp={otp}&uidb64={uidb64}&reset_token={reset_token}"

        # Prepare email content
        merge_data = {
            "link": link,
            "username": user.username,
        }
        subject = "Password Reset Request"
        text_body = render_to_string("email/password_reset.txt", merge_data)
        html_body = render_to_string("email/password_reset.html", merge_data)

        # Send the email
        msg = EmailMultiAlternatives(subject=subject, from_email=settings.SENDER_EMAIL, to=[user.email], body=text_body)
        msg.attach_alternative(html_body, "text/html")
        msg.send()

    except User.DoesNotExist:
        pass
