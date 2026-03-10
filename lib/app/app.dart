import 'package:flutter/material.dart';

import '../screens/landing_screen.dart';
import '../services/cat_api_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, CatApiService? apiService})
    : _apiService = apiService;

  final CatApiService? _apiService;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catbreeds App',
      home: LandingScreen(apiService: _apiService ?? CatApiService()),
    );
  }
}
