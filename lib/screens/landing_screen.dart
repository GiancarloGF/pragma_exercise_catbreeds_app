import 'package:flutter/material.dart';

import '../models/cat_breed.dart';
import '../services/cat_api_service.dart';
import '../widgets/breed_list_item.dart';
import 'breed_detail_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key, required this.apiService});

  final CatApiService apiService;

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late final Future<List<CatBreed>> _breedsFuture;
  String _query = '';

  @override
  void initState() {
    super.initState();
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
      appBar: AppBar(title: const Text('Catbreeds')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              key: const Key('breedSearchField'),
              decoration: const InputDecoration(
                labelText: 'Search breed',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<CatBreed>>(
                future: _breedsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Failed to load breeds: ${snapshot.error}'),
                    );
                  }

                  final breeds = _filterBreeds(snapshot.data ?? const []);

                  if (breeds.isEmpty) {
                    return Center(
                      child: Text(
                        _query.isEmpty
                            ? 'No breeds available.'
                            : 'No breeds found for "$_query".',
                      ),
                    );
                  }

                  return ListView.builder(
                    key: const Key('breedList'),
                    itemCount: breeds.length,
                    itemBuilder: (context, index) {
                      final breed = breeds[index];
                      return BreedListItem(
                        breed: breed,
                        onTap: () => _openBreedDetail(breed),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
