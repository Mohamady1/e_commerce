class Utils {
  static bool loginValidation(String email, String pass) {
    if (email.isEmpty || pass.isEmpty) {
      throw "Fill All Fields";
    } else if (!email.contains("@")) {
      throw "Email is Wrong";
    } else {
      return true;
    }
  }

  static minimizeWord(String word) {
    return word.length > 30 ? word.substring(0, 27) + "..." : word;
  }
}
