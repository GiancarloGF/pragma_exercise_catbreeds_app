import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_exercise_catbreeds_app/models/cat_breed.dart';

void main() {
  test(
    'CatBreed.fromJson maps required fields and tolerates missing image',
    () {
      final breed = CatBreed.fromJson({
        'weight': {'metric': '3 - 5'},
        'id': 'abys',
        'name': 'Abyssinian',
        'description': 'Active and curious',
        'temperament': 'Active, Energetic, Intelligent',
        'origin': 'Egypt',
        'intelligence': 5,
        'adaptability': 4,
        'affection_level': 5,
        'child_friendly': 3,
        'dog_friendly': 4,
        'energy_level': 5,
        'grooming': 1,
        'health_issues': 2,
        'shedding_level': 2,
        'social_needs': 5,
        'stranger_friendly': 5,
        'life_span': '14 - 15',
      });

      expect(breed.id, 'abys');
      expect(breed.name, 'Abyssinian');
      expect(breed.description, 'Active and curious');
      expect(breed.temperament, 'Active, Energetic, Intelligent');
      expect(breed.origin, 'Egypt');
      expect(breed.weightMetric, '3 - 5');
      expect(breed.intelligence, 5);
      expect(breed.adaptability, 4);
      expect(breed.energyLevel, 5);
      expect(breed.characteristics, hasLength(11));
      expect(breed.lifeSpan, '14 - 15');
      expect(breed.imageUrl, isNull);
    },
  );
}
