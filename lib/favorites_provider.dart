import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fruit.dart';
import 'dart:convert';

class FavoritesProvider with ChangeNotifier {
  final List<Fruit> _favorites = [];

  List<Fruit> get favorites => _favorites;

  bool isFavorite(Fruit fruit) =>
      _favorites.any((f) => f.title == fruit.title && f.image == fruit.image);

  void toggleFavorite(Fruit fruit) async {
    if (isFavorite(fruit)) {
      _favorites.removeWhere((f) => f.title == fruit.title);
    } else {
      _favorites.add(fruit);
    }
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('favorites') ?? [];
    _favorites.clear();
    _favorites.addAll(data.map((json) {
      final map = jsonDecode(json);
      return Fruit.fromJson(map);
    }));
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _favorites.map((f) => jsonEncode(f.toJson())).toList();
    await prefs.setStringList('favorites', data);
  }
}

