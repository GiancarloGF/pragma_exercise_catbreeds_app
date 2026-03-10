import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/cat_breed.dart';

class CatApiService {
  CatApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<List<CatBreed>> fetchBreeds() async {
    final uri = Uri.parse(
      '${AppConfig.baseUrl}/breeds?api_key=${AppConfig.apiKey}',
    );
    final response = await _client.get(
      uri,
      headers: const {'x-api-key': AppConfig.apiKey},
    );

    if (response.statusCode != 200) {
      throw CatApiException(
        'Request failed with status ${response.statusCode}.',
      );
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! List) {
      throw const CatApiException('Unexpected response format.');
    }

    return decoded
        .whereType<Map<String, dynamic>>()
        .map(CatBreed.fromJson)
        .toList();
  }
}

class CatApiException implements Exception {
  const CatApiException(this.message);

  final String message;

  @override
  String toString() => message;
}
