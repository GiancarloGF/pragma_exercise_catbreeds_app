import 'package:flutter/material.dart';

import '../models/cat_breed.dart';

class BreedListItem extends StatelessWidget {
  const BreedListItem({super.key, required this.breed, required this.onTap});

  final CatBreed breed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: SizedBox(
          width: 56,
          height: 56,
          child: breed.imageUrl == null || breed.imageUrl!.isEmpty
              ? const Center(child: Text('No image'))
              : Image.network(
                  breed.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      const Center(child: Text('No image')),
                ),
        ),
        title: Text(breed.name),
        subtitle: Text(
          'Origin: ${breed.origin}\nIntelligence: ${breed.intelligence}',
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
