import 'package:ricky_and_morty/services/http_client/data/client_service.dart';
import 'package:ricky_and_morty/services/http_client/data/dio_client_service.dart';
import 'package:ricky_and_morty/services/http_client/domain/models/custom_request.dart';
import 'package:ricky_and_morty/services/http_client/domain/models/custom_response.dart';

abstract class HttpClient {
  Future<CustomResponse> get(CustomRequest request);
}

class HttpClietImp implements HttpClient {
  late ClientService _source;

  HttpClietImp([ClientService? source]) {
    _source = source ?? DioClientServiceImp();
  }

  @override
  Future<CustomResponse> get(CustomRequest request) async {
    try {
      return await _source.get(request);
    } catch (e) {
      throw Exception();
    }
  }
}
