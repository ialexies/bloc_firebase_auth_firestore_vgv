class AuthFailure implements Exception {
  String code = '';
  String? message;
  String plugin = '';
  AuthFailure({
    required this.code,
    this.message,
    required this.plugin,
  });

  factory AuthFailure.initial() {
    return AuthFailure(
      code: '',
      message: 'An unknown auth error found ',
      plugin: '',
    );
  }
}
