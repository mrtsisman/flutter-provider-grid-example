import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorites_provider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('Meine Favoriten')),
      body: favorites.isEmpty
          ? const Center(child: Text('Keine Favoriten ausgewählt'))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final fruit = favorites[index];
                return Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      Expanded(child: Image.network(fruit.image, fit: BoxFit.cover)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(fruit.title, style: const TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

