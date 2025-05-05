import 'package:brasilcripto/model/search_model.dart';
import 'package:brasilcripto/repository/crypto_repository.dart';
import 'package:flutter/material.dart';

import '../service/favorite_service.dart';


class SearchViewModel with ChangeNotifier {
  final CryptoRepository _repository = CryptoRepository();
  final FavoriteService _favoriteService = FavoriteService();

  List<SearchModel> _coins = [];
  List<SearchModel> get coins => _coins;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _requestFocus = true;
  bool get requestFocus => _requestFocus;

  List<String> _favorites = [];

  void consumeFocusRequest() {
    _requestFocus = false;
    notifyListeners();
  }

  Future<void> search(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _coins = await _repository.searchCoins(query);
      await _loadFavorites();

      for (var coin in _coins) {
        coin.isFavorite = _favorites.contains(coin.id);
      }
    } catch (e) {
      _coins = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadFavorites() async {
    _favorites = await _favoriteService.getFavorites();
  }

  void toggleFavorite(SearchModel coin) async {
    coin.isFavorite = !coin.isFavorite;

    if (coin.isFavorite) {
      _favorites.add(coin.id);
    } else {
      _favorites.remove(coin.id);
    }

    await _favoriteService.saveFavorites(_favorites);
    notifyListeners();
  }
}
