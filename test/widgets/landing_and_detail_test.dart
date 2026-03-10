import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pragma_exercise_catbreeds_app/app/app.dart';
import 'package:pragma_exercise_catbreeds_app/models/cat_breed.dart';
import 'package:pragma_exercise_catbreeds_app/screens/breed_detail_screen.dart';
import 'package:pragma_exercise_catbreeds_app/services/cat_api_service.dart';

void main() {
  testWidgets('landing shows loading and then renders fetched breeds', (
    tester,
  ) async {
    final completer = Completer<http.Response>();
    final service = CatApiService(client: MockClient((_) => completer.future));

    await tester.pumpWidget(MyApp(apiService: service));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    completer.complete(
      http.Response('''
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
            "life_span": "14 - 15"
          },
          {
            "weight": {"metric": "4 - 7"},
            "id": "beng",
            "name": "Bengal",
            "description": "Smart and playful",
            "temperament": "Alert, Agile, Energetic",
            "origin": "United States",
            "intelligence": 5,
            "adaptability": 5,
            "affection_level": 5,
            "child_friendly": 4,
            "dog_friendly": 5,
            "energy_level": 5,
            "grooming": 1,
            "health_issues": 2,
            "shedding_level": 3,
            "social_needs": 4,
            "stranger_friendly": 4,
            "life_span": "12 - 16"
          }
        ]
        ''', 200),
    );

    await tester.pumpAndSettle();

    expect(find.text('Abyssinian'), findsOneWidget);
    await tester.drag(
      find.byKey(const Key('breedList')),
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    expect(find.text('Bengal'), findsOneWidget);
  });

  testWidgets('landing filters breeds using the search field', (tester) async {
    final service = _buildServiceWithBreeds();

    await tester.pumpWidget(MyApp(apiService: service));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('breedSearchField')), 'beng');
    await tester.pumpAndSettle();

    expect(find.text('Bengal'), findsOneWidget);
    expect(find.text('Abyssinian'), findsNothing);
  });

  testWidgets('landing navigates to breed detail when a breed is tapped', (
    tester,
  ) async {
    final service = _buildServiceWithBreeds();
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(1200, 1600);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(MyApp(apiService: service));
    await tester.pumpAndSettle();

    final abyssinianCard = find.ancestor(
      of: find.text('Abyssinian'),
      matching: find.byType(GestureDetector),
    );

    await tester.tap(abyssinianCard.first);
    await tester.pumpAndSettle();

    expect(find.byType(BreedDetailScreen), findsOneWidget);
    expect(find.text('Egypt'), findsOneWidget);
  });

  testWidgets('detail shows fallback image text and scrollable content', (
    tester,
  ) async {
    const breed = CatBreed(
      id: 'abys',
      name: 'Abyssinian',
      description: 'Active and curious cat breed.',
      temperament: 'Active, Energetic, Intelligent',
      origin: 'Egypt',
      weightMetric: '3 - 5',
      intelligence: 5,
      adaptability: 4,
      affectionLevel: 5,
      childFriendly: 3,
      dogFriendly: 4,
      energyLevel: 5,
      grooming: 1,
      healthIssues: 2,
      sheddingLevel: 2,
      socialNeeds: 5,
      strangerFriendly: 5,
      lifeSpan: '14 - 15',
      imageUrl: null,
    );

    await tester.pumpWidget(
      const MaterialApp(home: BreedDetailScreen(breed: breed)),
    );

    expect(find.text('No hay imagen disponible'), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.text('14 - 15 años'), findsOneWidget);
    expect(find.text('Características de la raza'), findsOneWidget);
    expect(find.text('Nivel de energía'), findsOneWidget);
    expect(find.text('Amigable con extraños'), findsOneWidget);
  });
}

CatApiService _buildServiceWithBreeds() {
  return CatApiService(
    client: MockClient((_) async {
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
            "life_span": "14 - 15"
          },
          {
            "weight": {"metric": "4 - 7"},
            "id": "beng",
            "name": "Bengal",
            "description": "Smart and playful",
            "temperament": "Alert, Agile, Energetic",
            "origin": "United States",
            "intelligence": 5,
            "adaptability": 5,
            "affection_level": 5,
            "child_friendly": 4,
            "dog_friendly": 5,
            "energy_level": 5,
            "grooming": 1,
            "health_issues": 2,
            "shedding_level": 3,
            "social_needs": 4,
            "stranger_friendly": 4,
            "life_span": "12 - 16"
          }
        ]
        ''', 200);
    }),
  );
}
