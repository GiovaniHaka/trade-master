import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';
import 'package:ricky_and_morty/services/http_client/domain/models/custom_request.dart';
import 'package:ricky_and_morty/services/http_client/domain/models/custom_response.dart';
import 'package:ricky_and_morty/services/http_client/domain/usecases/http_client.dart';

abstract class EpisodeSource {
  Future<Either<Failure, Map<String, dynamic>>> getSingle(String url);
}

class EpisodeSourceImp implements EpisodeSource {
  late HttpClient _httpClient;

  EpisodeSourceImp([HttpClient? httpClient]) {
    _httpClient = httpClient ?? HttpClietImp();
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getSingle(String url) async {
    try {
      final request = CustomRequest(url);

      final response = await _httpClient.get(request);
      final status = response.status;
      final data = response.data;

      switch (status) {
        case ResponseStatus.success:
          return Right(data!);
        case ResponseStatus.unknown:
          return Left(Failure('Não conseguimos encontrar o episódio'));
        case ResponseStatus.error:
          return Left(Failure('Erro ao encontrar episódio'));
        default:
          throw UnimplementedError();
      }
    } catch (e) {
      throw Exception();
    }
  }
}
