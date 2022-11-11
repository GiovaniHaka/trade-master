class CustomRequest {
  final String path;
  final Map<String, dynamic>? queryParameters;

  CustomRequest(
    this.path, {
    this.queryParameters,
  });
}
