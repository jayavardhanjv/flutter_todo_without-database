String? vEmail(value) {
  if (value!.isEmpty ||
      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
    return 'Enter a valid email!';
  }
  return null;
}

String? vPassword(value) {
  if (value!.isEmpty || value.length < 6) {
    return 'Enter a valid password!';
  }
  return null;
}

String? vDescription(value) {
  if (value!.isEmpty) {
    return "Description Doesn't have to be empty";
  }
  return null;
}

String? vDate(value) {
  if (value!.isEmpty) {
    return "Date Doesn't have to be empty";
  }
  return null;
}
