class CatBreed {
  const CatBreed({
    required this.id,
    required this.name,
    required this.description,
    required this.temperament,
    required this.origin,
    required this.weightMetric,
    required this.intelligence,
    required this.adaptability,
    required this.affectionLevel,
    required this.childFriendly,
    required this.dogFriendly,
    required this.energyLevel,
    required this.grooming,
    required this.healthIssues,
    required this.sheddingLevel,
    required this.socialNeeds,
    required this.strangerFriendly,
    required this.lifeSpan,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String description;
  final String temperament;
  final String origin;
  final String weightMetric;
  final int intelligence;
  final int adaptability;
  final int affectionLevel;
  final int childFriendly;
  final int dogFriendly;
  final int energyLevel;
  final int grooming;
  final int healthIssues;
  final int sheddingLevel;
  final int socialNeeds;
  final int strangerFriendly;
  final String lifeSpan;
  final String? imageUrl;

  List<BreedCharacteristic> get characteristics => [
    BreedCharacteristic(label: 'Adaptabilidad', value: adaptability),
    BreedCharacteristic(label: 'Nivel de afecto', value: affectionLevel),
    BreedCharacteristic(label: 'Amigable con niños', value: childFriendly),
    BreedCharacteristic(label: 'Amigable con perros', value: dogFriendly),
    BreedCharacteristic(label: 'Nivel de energía', value: energyLevel),
    BreedCharacteristic(label: 'Aseo', value: grooming),
    BreedCharacteristic(label: 'Problemas de salud', value: healthIssues),
    BreedCharacteristic(label: 'Inteligencia', value: intelligence),
    BreedCharacteristic(label: 'Nivel de muda', value: sheddingLevel),
    BreedCharacteristic(label: 'Necesidades sociales', value: socialNeeds),
    BreedCharacteristic(
      label: 'Amigable con extraños',
      value: strangerFriendly,
    ),
  ];

  factory CatBreed.fromJson(Map<String, dynamic> json) {
    final image = json['image'];
    final imageUrl = image is Map<String, dynamic>
        ? image['url'] as String?
        : null;
    final weight = json['weight'];
    final weightMetric = weight is Map<String, dynamic>
        ? weight['metric'] as String? ?? ''
        : '';

    return CatBreed(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      temperament: json['temperament'] as String? ?? '',
      origin: json['origin'] as String? ?? '',
      weightMetric: weightMetric,
      intelligence: json['intelligence'] as int? ?? 0,
      adaptability: json['adaptability'] as int? ?? 0,
      affectionLevel: json['affection_level'] as int? ?? 0,
      childFriendly: json['child_friendly'] as int? ?? 0,
      dogFriendly: json['dog_friendly'] as int? ?? 0,
      energyLevel: json['energy_level'] as int? ?? 0,
      grooming: json['grooming'] as int? ?? 0,
      healthIssues: json['health_issues'] as int? ?? 0,
      sheddingLevel: json['shedding_level'] as int? ?? 0,
      socialNeeds: json['social_needs'] as int? ?? 0,
      strangerFriendly: json['stranger_friendly'] as int? ?? 0,
      lifeSpan: json['life_span'] as String? ?? '',
      imageUrl: imageUrl,
    );
  }
}

class BreedCharacteristic {
  const BreedCharacteristic({required this.label, required this.value});

  final String label;
  final int value;
}
