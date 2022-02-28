extension StringX on String {
  String? isValidInput(String target) {
    if (isEmpty) {
      return target + ' cannot be empty';
    } else if (length < 5) {
      return target + ' must contain 5 or more characters';
    } else {
      return null;
    }
  }

  String capitalise() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}
