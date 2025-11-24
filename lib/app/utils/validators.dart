class Validators {
  static String? name(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Please enter your full name';
    }

    // sirf letters + space allow
    final regex = RegExp(r"^[A-Za-z ]+$");
    if (!regex.hasMatch(text)) {
      return 'Name should contain only letters';
    }

    if (text.length < 3) {
      return 'Name must be at least 3 characters';
    }

    return null;
  }

  static String? email(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Please enter your email';
    }

    // normal email pattern
    final regex = RegExp(
      r"^[\w\.\-]+@[\w\-]+\.[A-Za-z]{2,}$",
    );
    if (!regex.hasMatch(text)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  static String? phone(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Please enter phone number';
    }

    // sirf digits aur length = 10
    final regex = RegExp(r"^[0-9]{10}$");
    if (!regex.hasMatch(text)) {
      return 'Phone number must be 10 digits';
    }

    return null;
  }
}
