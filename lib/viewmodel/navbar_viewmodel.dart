import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBarViewModel {
  final BuildContext context;
  final String currentRoute;

  NavBarViewModel(this.context, this.currentRoute);

  int get currentIndex {
    switch (currentRoute) {
      case '/':
        return 0;
      case '/search':
        return 1;
      case '/favorite':
        return 2;
      default:
        return 0;
    }
  }

  void onItemTapped(int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/search');
        break;
      case 2:
        context.go('/favorite');
        break;
    }
  }
}
