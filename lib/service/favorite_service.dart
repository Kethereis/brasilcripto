import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const String key = 'favorite_coins';

  Future<void> saveFavorites(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, ids);
  }

  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  Future<void> addFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getStringList(key) ?? [];

    if (!current.contains(id)) {
      current.add(id);
      await prefs.setStringList(key, current);
    }
  }

  Future<void> removeFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getStringList(key) ?? [];

    if (current.contains(id)) {
      current.remove(id);
      await prefs.setStringList(key, current);
    }
  }
}
