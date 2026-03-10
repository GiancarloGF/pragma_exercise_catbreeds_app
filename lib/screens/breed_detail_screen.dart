import 'package:flutter/material.dart';

import '../models/cat_breed.dart';
import '../theme/app_theme.dart';
import '../widgets/brutalist_card.dart';

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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: SizedBox(
              height: 300,
              child: BrutalistCard(
                backgroundColor: AppPalette.surface,
                padding: EdgeInsets.zero,
                child: _BreedHeaderImage(imageUrl: breed.imageUrl),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrutalistCard(
                    backgroundColor: AppPalette.surface,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Principales características',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _SummaryMetricCard(
                                tooltip: 'País de origen',
                                value: breed.origin,
                                icon: Icons.place_outlined,
                                backgroundColor: AppPalette.peach,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _SummaryMetricCard(
                                tooltip: 'Vida promedio',
                                value: '${breed.lifeSpan} años',
                                icon: Icons.timelapse_rounded,
                                backgroundColor: AppPalette.sky,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _SummaryMetricCard(
                                tooltip: 'Peso',
                                value: '${breed.weightMetric} kg',
                                icon: Icons.monitor_weight_outlined,
                                backgroundColor: AppPalette.lavender,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _SummaryMetricCard(
                                tooltip: 'Inteligencia',
                                value: '${breed.intelligence}/5',
                                icon: Icons.psychology_alt_rounded,
                                backgroundColor: AppPalette.sand,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  BrutalistCard(
                    backgroundColor: AppPalette.surface,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detalle',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        Text(breed.description),
                        const SizedBox(height: 16),
                        _DetailLabel(
                          title: 'Temperamento',
                          content: breed.temperament,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  BrutalistCard(
                    backgroundColor: AppPalette.surface,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Características de la raza',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        ...breed.characteristics.map(
                          (characteristic) => Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: _BreedCharacteristicRow(
                              characteristic: characteristic,
                            ),
                          ),
                        ),
                      ],
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

class _SummaryMetricCard extends StatelessWidget {
  const _SummaryMetricCard({
    required this.tooltip,
    required this.value,
    required this.icon,
    required this.backgroundColor,
  });

  final String tooltip;
  final String value;
  final IconData icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      triggerMode: TooltipTriggerMode.tap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppPalette.ink, width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 20, color: AppPalette.ink),
              const SizedBox(height: 10),
              Text(
                value,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            characteristic.label,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
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
            color: isActive ? AppPalette.orange : AppPalette.peach,
          ),
        );
      }),
    );
  }
}

class _DetailLabel extends StatelessWidget {
  const _DetailLabel({required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(content),
      ],
    );
  }
}

class _BreedHeaderImage extends StatelessWidget {
  const _BreedHeaderImage({required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: AppPalette.peach,
          borderRadius: BorderRadius.circular(26),
        ),
        alignment: Alignment.center,
        child: const Text('No hay imagen disponible'),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) {
          return Container(
            decoration: BoxDecoration(
              color: AppPalette.peach,
              borderRadius: BorderRadius.circular(26),
            ),
            alignment: Alignment.center,
            child: const Text('No hay imagen disponible'),
          );
        },
      ),
    );
  }
}
