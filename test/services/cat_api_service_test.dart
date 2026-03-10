import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pragma_exercise_catbreeds_app/services/cat_api_service.dart';

void main() {
  test(
    'fetchBreeds returns mapped breeds when the response is successful',
    () async {
      final service = CatApiService(
        client: MockClient((request) async {
          expect(request.url.path, '/v1/breeds');
          expect(request.headers['x-api-key'], isNotEmpty);

          return http.Response('''
          [
            {
              "weight": {"metric": "3 - 5"},
              "id": "abys",
              "name": "Abyssinian",
              "description": "Active and curious",
              "temperament": "Active, Energetic, Intelligent",
              "origin": "Egypt",
              "intelligence": 5,
              "adaptability": 4,
              "affection_level": 5,
              "child_friendly": 3,
              "dog_friendly": 4,
              "energy_level": 5,
              "grooming": 1,
              "health_issues": 2,
              "shedding_level": 2,
              "social_needs": 5,
              "stranger_friendly": 5,
              "life_span": "14 - 15",
              "image": {"url": "https://example.com/abys.jpg"}
            }
          ]
          ''', 200);
        }),
      );

      final breeds = await service.fetchBreeds();

      expect(breeds, hasLength(1));
      expect(breeds.single.name, 'Abyssinian');
      expect(breeds.single.energyLevel, 5);
      expect(breeds.single.imageUrl, 'https://example.com/abys.jpg');
    },
  );

  test(
    'fetchBreeds throws when the response status code is not successful',
    () async {
      final service = CatApiService(
        client: MockClient((_) async => http.Response('Server error', 500)),
      );

      await expectLater(service.fetchBreeds(), throwsA(isA<CatApiException>()));
    },
  );
}
