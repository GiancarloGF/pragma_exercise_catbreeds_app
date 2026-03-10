import 'package:flutter/material.dart';

import '../models/cat_breed.dart';
import '../services/cat_api_service.dart';
import '../theme/app_theme.dart';
import '../widgets/breed_list_item.dart';
import '../widgets/brutalist_card.dart';
import '../widgets/info_pill.dart';
import 'breed_detail_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key, required this.apiService});

  final CatApiService apiService;

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late Future<List<CatBreed>> _breedsFuture;
  late final TextEditingController _searchController;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _loadBreeds();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadBreeds() {
    _breedsFuture = widget.apiService.fetchBreeds();
  }

  List<CatBreed> _filterBreeds(List<CatBreed> breeds) {
    final normalizedQuery = _query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return breeds;
    }

    return breeds
        .where((breed) => breed.name.toLowerCase().contains(normalizedQuery))
        .toList();
  }

  void _openBreedDetail(CatBreed breed) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => BreedDetailScreen(breed: breed)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Razas de gatos')),
      body: FutureBuilder<List<CatBreed>>(
        future: _breedsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: BrutalistCard(
                  backgroundColor: AppPalette.surface,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No fue posible cargar las razas',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ocurrió un error al consultar la API: ${snapshot.error}',
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(_loadBreeds);
                        },
                        child: const Text('Intentar de nuevo'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          final allBreeds = snapshot.data ?? const [];
          final breeds = _filterBreeds(allBreeds);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LandingHero(
                      totalBreeds: allBreeds.length,
                      searchController: _searchController,
                      query: _query,
                      onQueryChanged: (value) {
                        setState(() {
                          _query = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Resultados',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        Text(
                          '${breeds.length} visibles',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: breeds.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: BrutalistCard(
                            backgroundColor: AppPalette.surface,
                            child: Text(
                              _query.isEmpty
                                  ? 'No hay razas disponibles.'
                                  : 'No se encontraron razas para "$_query".',
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        key: const Key('breedList'),
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                        cacheExtent: 880,
                        itemCount: breeds.length,
                        itemBuilder: (context, index) {
                          final breed = breeds[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: BreedListItem(
                              breed: breed,
                              onTap: () => _openBreedDetail(breed),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LandingHero extends StatelessWidget {
  const _LandingHero({
    required this.totalBreeds,
    required this.searchController,
    required this.query,
    required this.onQueryChanged,
  });

  final int totalBreeds;
  final TextEditingController searchController;
  final String query;
  final ValueChanged<String> onQueryChanged;

  @override
  Widget build(BuildContext context) {
    return BrutalistCard(
      backgroundColor: AppPalette.surface,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  InfoPill(
                    label: '$totalBreeds razas totales',
                    backgroundColor: AppPalette.sand,
                    icon: Icons.pets_outlined,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                'Explora razas felinas.',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                'Busca por nombre en inglés, revisa sus datos principales y abre una vista detallada con sus características.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 18),
              TextField(
                key: const Key('breedSearchField'),
                controller: searchController,
                decoration: const InputDecoration(
                  labelText: 'Buscar raza',
                  hintText: 'Ejemplo: Abyssinian o Bengal',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: _ClearSearchButton(),
                ),
                onChanged: onQueryChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ClearSearchButton extends StatelessWidget {
  const _ClearSearchButton();

  @override
  Widget build(BuildContext context) {
    final hero = context.findAncestorWidgetOfExactType<_LandingHero>();

    if (hero == null || hero.query.isEmpty) {
      return const SizedBox.shrink();
    }

    return IconButton(
      onPressed: () {
        hero.searchController.clear();
        hero.onQueryChanged('');
      },
      tooltip: 'Limpiar búsqueda',
      icon: const Icon(Icons.close_rounded),
    );
  }
}
