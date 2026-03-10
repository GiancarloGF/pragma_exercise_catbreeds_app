import 'package:flutter/material.dart';

import '../models/cat_breed.dart';
import '../theme/app_theme.dart';
import 'brutalist_card.dart';

class BreedListItem extends StatelessWidget {
  const BreedListItem({super.key, required this.breed, required this.onTap});

  final CatBreed breed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: onTap,
        child: BrutalistCard(
          backgroundColor: AppPalette.surface,
          padding: EdgeInsets.zero,
          child: SizedBox(
            height: 220,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
                final cacheWidth = (constraints.maxWidth * devicePixelRatio)
                    .round();

                return ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      breed.imageUrl == null || breed.imageUrl!.isEmpty
                          ? Container(
                              color: AppPalette.peach,
                              alignment: Alignment.center,
                              child: const Text('No hay imagen disponible'),
                            )
                          : Image.network(
                              breed.imageUrl!,
                              fit: BoxFit.cover,
                              cacheWidth: cacheWidth,
                              filterQuality: FilterQuality.medium,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) {
                                  return child;
                                }

                                return Container(
                                  color: AppPalette.peach,
                                  alignment: Alignment.center,
                                  child: const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (_, _, _) {
                                return Container(
                                  color: AppPalette.peach,
                                  alignment: Alignment.center,
                                  child: const Text('No hay imagen disponible'),
                                );
                              },
                            ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0x14000000), Color(0xB3000000)],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        breed.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'País de origen: ${breed.origin}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.white),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Nivel de inteligencia: ${breed.intelligence}/5',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: AppPalette.orange,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppPalette.ink,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Icon(
                                      Icons.arrow_forward_rounded,
                                      color: AppPalette.ink,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
