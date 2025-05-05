import 'package:brasilcripto/app_route.dart';
import 'package:brasilcripto/model/home_model.dart';
import 'package:flutter/foundation.dart';
import '../repository/crypto_repository.dart';

import 'package:brasilcripto/model/home_model.dart';
import 'package:flutter/material.dart';
import '../repository/crypto_repository.dart';
import '../view/search_view.dart';

class HomeViewModel extends ChangeNotifier {
  final CryptoRepository _repository;

  HomeViewModel(this._repository);

  List<HomeModel> topGainers = [];
  bool isLoading = false;
  String? error;

  Future<void> loadTopGainers() async {
    isLoading = true;
    notifyListeners();

    try {
      topGainers = await _repository.getTopGainers();
    } catch (e) {
      error = "Erro ao carregar dados. Tente novamente.\n\nMotivo: $e";
    }

    isLoading = false;
    notifyListeners();
  }

  void navigateToSearch(BuildContext context) {
    appRouter.go('/search');
  }
}
