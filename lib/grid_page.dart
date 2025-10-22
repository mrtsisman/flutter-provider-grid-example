import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fruit.dart';
import 'favorites_provider.dart';
import 'favorites_page.dart';

class GridPage extends StatelessWidget {
  final List<Fruit> fruits = [
    Fruit(title: 'Apfel', image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Red_Apple.jpg/960px-Red_Apple.jpg'),
    Fruit(title: 'Banane', image: 'https://www.kochschule.de/sites/default/files/images/kochwissen/440/banane.jpg'),
    Fruit(title: 'Kirsche', image: 'https://www.iva.de/sites/default/files/styles/16x9_840/public/benutzer/%25uid/magazinbilder/kirschen_181099124m_istock.jpg?h=140710cd&itok=5tdt5boy'),
    Fruit(title: 'Traube', image: 'https://www.fruiton.de/media/pages/ueber-uns/fruchtlexikon/traube-thompson-seedless/modules/text/adab766cf0-1709567713/traube-thompson-seedless-680x510-crop-q85.webp'),
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

