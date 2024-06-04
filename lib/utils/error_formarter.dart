String formatFirebaseError(String errorCode) {
  if (errorCode.contains('[firebase_auth/email-already-in-use]')) {
    return 'The email address is already in use by another account!.';
  }
  // Add more conditions as needed
  else if (errorCode.contains(
      '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.')) {
    return 'Network error has occured!.';
  } else if (errorCode.contains('The recipients address is empty') ||
      errorCode.contains('The recipients address is corrupted')) {
    return 'Invalid Email Address!';
  } else if (errorCode.contains(
      'The supplied auth credential is incorrect, malformed or has expired')) {
    return 'Invalid Email or Password!';
  }
  return 'Unknown Error has occured!.';
}
