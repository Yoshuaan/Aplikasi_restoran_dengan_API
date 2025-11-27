import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const String _keyFavorites = 'favorite_restaurants';

  // Mendapatkan semua ID restoran favorit
  Future<List<String>> getFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyFavorites) ?? [];
  }

  // Cek apakah restoran sudah difavoritkan
  Future<bool> isFavorite(String restaurantId) async {
    final favorites = await getFavoriteIds();
    return favorites.contains(restaurantId);
  }

  // Tambah restoran ke favorit
  Future<bool> addFavorite(String restaurantId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = await getFavoriteIds();

      if (!favorites.contains(restaurantId)) {
        favorites.add(restaurantId);
        await prefs.setStringList(_keyFavorites, favorites);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  // Hapus restoran dari favorit
  Future<bool> removeFavorite(String restaurantId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = await getFavoriteIds();

      favorites.remove(restaurantId);
      await prefs.setStringList(_keyFavorites, favorites);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Toggle favorit (tambah jika belum ada, hapus jika sudah ada)
  Future<bool> toggleFavorite(String restaurantId) async {
    final isFav = await isFavorite(restaurantId);
    if (isFav) {
      return await removeFavorite(restaurantId);
    } else {
      return await addFavorite(restaurantId);
    }
  }
}
