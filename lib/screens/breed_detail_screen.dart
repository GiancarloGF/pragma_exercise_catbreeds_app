import 'package:flutter/material.dart';

import '../models/cat_breed.dart';

class BreedDetailScreen extends StatelessWidget {
  const BreedDetailScreen({super.key, required this.breed});

  final CatBreed breed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(breed.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 4, child: _BreedHeaderImage(imageUrl: breed.imageUrl)),
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(breed.name),
                  const SizedBox(height: 12),
                  Text(breed.description),
                  const SizedBox(height: 12),
                  Text('Origin: ${breed.origin}'),
                  const SizedBox(height: 8),
                  Text('Intelligence: ${breed.intelligence}'),
                  const SizedBox(height: 8),
                  Text('Adaptability: ${breed.adaptability}'),
                  const SizedBox(height: 8),
                  Text('Life span: ${breed.lifeSpan} years'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BreedHeaderImage extends StatelessWidget {
  const _BreedHeaderImage({required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return const Center(child: Text('No image available'));
    }

    return Image.network(
      imageUrl!,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) {
        return const Center(child: Text('No image available'));
      },
    );
  }
}
