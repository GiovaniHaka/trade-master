import 'package:ricky_and_morty/services/http_client/domain/models/custom_request.dart';
import 'package:ricky_and_morty/services/http_client/domain/models/custom_response.dart';

abstract class ClientService {
  Future<CustomResponse> get(CustomRequest request);
}
