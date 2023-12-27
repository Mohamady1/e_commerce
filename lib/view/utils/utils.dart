import 'dart:math';

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

  static String extractNumericPart(String input) {
    return input.replaceAll(RegExp(r'[^0-9]'), '');
  }

  static weightFromString(String weightString) {
    List<String> weights = weightString.split('-');
    return weights;
  }

  static equivalentWeights(String dataWeight, int userWeight) {
    List<String> weightRange = weightFromString(dataWeight);
    int minWeight;
    int maxWeight;
    if (weightRange.length == 2) {
      minWeight = int.parse(extractNumericPart(weightRange[0]));
      maxWeight = int.parse(extractNumericPart(weightRange[1]));
    } else {
      minWeight = 90;
      maxWeight = 9223372036854775807;
    }
    return userWeight >= minWeight && userWeight <= maxWeight;
  }
}
