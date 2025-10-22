import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fruit.dart';
import 'favorites_provider.dart';
import 'favorites_page.dart';

class GridPage extends StatelessWidget {
  GridPage({super.key});

  final List<Fruit> fruits = [
    Fruit(
      title: 'Apfel',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Red_Apple.jpg/960px-Red_Apple.jpg',
    ),
    Fruit(
      title: 'Banane',
      image:
          'https://www.kochschule.de/sites/default/files/images/kochwissen/440/banane.jpg',
    ),
    Fruit(
      title: 'Kirsche',
      image:
          'https://www.iva.de/sites/default/files/styles/16x9_840/public/benutzer/%25uid/magazinbilder/kirschen_181099124m_istock.jpg?h=140710cd&itok=5tdt5boy',
    ),
    Fruit(
      title: 'Traube',
      image:
          'https://www.fruiton.de/media/pages/ueber-uns/fruchtlexikon/traube-thompson-seedless/modules/text/adab766cf0-1709567713/traube-thompson-seedless-680x510-crop-q85.webp',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Obst Grid'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Favoriten ansehen',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FavoritesPage()),
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Makes grid responsive on tablets/desktops
          final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemCount: fruits.length,
            itemBuilder: (context, index) {
              final fruit = fruits[index];
              return Consumer<FavoritesProvider>(
                builder: (context, provider, _) {
                  final isFav = provider.isFavorite(fruit);

                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${fruit.title} geöffnet'),
                          duration: const Duration(milliseconds: 800),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              fruit.image,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              errorBuilder: (context, error, stack) => const Center(
                                child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                              ),
                            ),
                          ),
                          // Gradient overlay for better text contrast
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.5),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Favorite button
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav ? Colors.redAccent : Colors.white,
                              ),
                              onPressed: () => provider.toggleFavorite(fruit),
                            ),
                          ),
                          // Fruit title at bottom
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Text(
                              fruit.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(blurRadius: 6, color: Colors.black45),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
