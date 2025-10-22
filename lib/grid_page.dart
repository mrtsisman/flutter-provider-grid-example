import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fruit.dart';
import 'favorites_provider.dart';
import 'favorites_page.dart';

class GridPage extends StatelessWidget {
  final List<Fruit> fruits = [
    Fruit(title: 'Apfel', image: 'https://via.placeholder.com/150?text=Apfel'),
    Fruit(title: 'Banane', image: 'https://via.placeholder.com/150?text=Banane'),
    Fruit(title: 'Kirsche', image: 'https://via.placeholder.com/150?text=Kirsche'),
    Fruit(title: 'Traube', image: 'https://via.placeholder.com/150?text=Traube'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Obst Grid'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => FavoritesPage(),
              ));
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: fruits.length,
        itemBuilder: (context, index) {
          final fruit = fruits[index];
          return Consumer<FavoritesProvider>(
            builder: (context, provider, _) {
              final isFav = provider.isFavorite(fruit);
              return Card(
                elevation: 4,
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Image.network(fruit.image, fit: BoxFit.cover),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav ? Colors.red : Colors.white,
                              ),
                              onPressed: () => provider.toggleFavorite(fruit),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(fruit.title, style: const TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

