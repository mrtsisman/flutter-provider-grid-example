import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorites_provider.dart';
import 'grid_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final provider = FavoritesProvider();
  await provider.loadFavorites();

  runApp(
    ChangeNotifierProvider.value(
      value: provider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Obst Grid mit Provider',
      home: GridPage(),
    );
  }
}