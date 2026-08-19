class Validator {
  static String? validateUsernameOrEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Username or Email is required";
    }

    if (value.contains("@")) {
      if (!RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$').hasMatch(value.trim())) {
        return "Enter a valid Gmail address";
      }
    } else {
      if (value.contains(" ")) {
        return "Username cannot contain spaces";
      }
      if (value.trim().length < 3) {
        return "Username is too short";
      }
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$').hasMatch(value.trim())) {
      return "Enter a valid Gmail address";
    }

    return null;
  }

  static String? validateOptionalEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$').hasMatch(value.trim())) {
      return "Enter a valid Gmail address";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return "Enter a valid 10-digit phone number";
    }

    return null;
  }

  static String? validateShopName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Shop name is required";
    }

    if (value.trim().length < 3) {
      return "Shop name is too short";
    }

    return null;
  }

  static String? validateName(String? value, {required String fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }

    if (value.trim().length < 2) {
      return "$fieldName is too short";
    }

    return null;
  }

  static String? validateDescription(
    String? value, {
    required String fieldName,
  }) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }

    if (value.trim().length < 10) {
      return "$fieldName must be at least 10 characters";
    }

    return null;
  }

  // Validate Price
  static String? validatePrice(String? value, {required String fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }

    final price = double.tryParse(value);

    if (price == null) {
      return "Enter a valid $fieldName";
    }

    if (price < 0) {
      return "$fieldName cannot be negative";
    }

    return null;
  }

  // Validate Stock
  static String? validateStock(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Stock quantity is required";
    }

    final stock = int.tryParse(value);

    if (stock == null) {
      return "Enter a valid stock quantity";
    }

    if (stock < 0) {
      return "Stock cannot be negative";
    }

    return null;
  }

  // Validate Dropdown
  static String? validateDropdown(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "Please select $fieldName";
    }

    return null;
  }

  static String? validateBarcode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Barcode is optional
    }

    value = value.trim();

    // Only letters and numbers
    if (!RegExp(r'^[A-Za-z0-9]+$').hasMatch(value)) {
      return "Barcode can contain only letters and numbers";
    }

    // Length check
    if (value.length < 4 || value.length > 30) {
      return "Barcode must be between 4 and 30 characters";
    }

    return null;
  }
}
