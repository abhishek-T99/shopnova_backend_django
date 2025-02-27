import random


def generate_numeric_otp(length=6):
    # Generate a random 6-digit OTP
    otp = "".join([str(random.randint(0, 9)) for _ in range(length)])
    return otp
