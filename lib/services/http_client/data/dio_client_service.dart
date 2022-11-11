import 'package:dio/dio.dart';
import 'package:ricky_and_morty/services/http_client/data/client_service.dart';
import 'package:ricky_and_morty/services/http_client/domain/models/custom_request.dart';
import 'package:ricky_and_morty/services/http_client/domain/models/custom_response.dart';

class DioClientServiceImp implements ClientService {
  final _dio = Dio();

  @override
  Future<CustomResponse> get(CustomRequest request) async {
    try {
      final path = request.path;
      final queryParams = request.queryParameters;

      final response = await _dio.get(path, queryParameters: queryParams);
      final statusCode = response.statusCode;

      switch (statusCode) {
        case 200:
          return CustomResponse(
            status: ResponseStatus.success,
            data: response.data,
          );
        default:
          return CustomResponse(
            status: ResponseStatus.unknown,
            data: null,
          );
      }
    } catch (e) {
      if (e is DioError) {
        switch (e.response?.statusCode) {
          case null:
            break;
          case 404:
            return CustomResponse(
              status: ResponseStatus.badRequest,
              data: null,
            );
          default:
        }
      }
      return CustomResponse(
        status: ResponseStatus.error,
        data: null,
      );
    }
  }
}
