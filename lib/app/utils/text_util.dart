class TextUtil {
  static String getInitialsFromFullname(String fullname) {
    String initials = "";
    String firstName;
    String lastName;
    if (fullname.isEmpty) return "";
    List<String> names = fullname.split(" ");
    if (names.isNotEmpty) {
      firstName = names[0];
      initials += firstName.substring(0, 1);
    }
    if (names.length > 1) {
      if (names[1].trim().isNotEmpty) {
        lastName = names[1];
        initials += lastName.substring(0, 1);
      }
    }

    return initials.toUpperCase();
  }
}
