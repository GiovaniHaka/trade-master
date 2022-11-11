enum ResponseStatus {
  success,
  unknown,
  badRequest,
  error,
}

class CustomResponse {
  ResponseStatus status;
  dynamic data;

  CustomResponse({
    required this.status,
    this.data,
  });
}
