import 'package:brasilcripto/model/favorite_model.dart';
import 'package:flutter/material.dart';

import '../repository/crypto_repository.dart';
import '../service/favorite_service.dart';

class FavoritesViewModel extends ChangeNotifier {
  final _repository = CryptoRepository();
  final _favoriteService = FavoriteService();

  List<FavoriteModel> _favorites = [];
  List<FavoriteModel> get favorites => _favorites;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadFavorites() async {
    _isLoading = true;
    notifyListeners();

    final ids = await _favoriteService.getFavorites();
    final coins = <FavoriteModel>[];

    for (String id in ids) {
      try {
        final coinJson = await _repository.fetchCoinDetails(id);
        final coin = FavoriteModel.fromJson(coinJson);
        coins.add(coin);
      } catch (_) {
      }
    }

    _favorites = coins;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> removeFavorite(FavoriteModel coin) async {
    await _favoriteService.removeFavorite(coin.id);
    _favorites.removeWhere((c) => c.id == coin.id);
    notifyListeners();
  }
}