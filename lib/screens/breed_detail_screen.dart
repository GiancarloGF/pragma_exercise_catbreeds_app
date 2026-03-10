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
                  Text('Temperament: ${breed.temperament}'),
                  const SizedBox(height: 8),
                  Text('Weight: ${breed.weightMetric} kg'),
                  const SizedBox(height: 8),
                  Text('Life span: ${breed.lifeSpan} years'),
                  const SizedBox(height: 16),
                  const Text('Breed Characteristics'),
                  const SizedBox(height: 12),
                  ...breed.characteristics.map(
                    (characteristic) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _BreedCharacteristicRow(
                        characteristic: characteristic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BreedCharacteristicRow extends StatelessWidget {
  const _BreedCharacteristicRow({required this.characteristic});

  final BreedCharacteristic characteristic;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(characteristic.label)),
        const SizedBox(width: 16),
        _BreedCharacteristicScale(value: characteristic.value),
      ],
    );
  }
}

class _BreedCharacteristicScale extends StatelessWidget {
  const _BreedCharacteristicScale({required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    final normalizedValue = value.clamp(0, 5);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(5, (index) {
        final isActive = index < normalizedValue;

        return Padding(
          padding: EdgeInsets.only(right: index == 4 ? 0 : 4),
          child: Icon(
            Icons.circle,
            size: 14,
            color: isActive ? Colors.green : Colors.grey.shade300,
          ),
        );
      }),
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
