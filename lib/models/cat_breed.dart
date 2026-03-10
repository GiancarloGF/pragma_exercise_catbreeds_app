class CatBreed {
  const CatBreed({
    required this.id,
    required this.name,
    required this.description,
    required this.origin,
    required this.intelligence,
    required this.adaptability,
    required this.lifeSpan,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String description;
  final String origin;
  final int intelligence;
  final int adaptability;
  final String lifeSpan;
  final String? imageUrl;

  factory CatBreed.fromJson(Map<String, dynamic> json) {
    final image = json['image'];
    final imageUrl = image is Map<String, dynamic>
        ? image['url'] as String?
        : null;

    return CatBreed(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      origin: json['origin'] as String? ?? '',
      intelligence: json['intelligence'] as int? ?? 0,
      adaptability: json['adaptability'] as int? ?? 0,
      lifeSpan: json['life_span'] as String? ?? '',
      imageUrl: imageUrl,
    );
  }
}
