import secrets


def generate_numeric_otp(length=6):
    """Generate a secure random numeric OTP."""
    return "".join(str(secrets.randbelow(10)) for _ in range(length))
