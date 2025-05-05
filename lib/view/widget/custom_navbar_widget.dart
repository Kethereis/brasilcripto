import 'package:brasilcripto/core/app_constants.dart';
import 'package:flutter/material.dart';
import '../../viewmodel/navbar_viewmodel.dart';


class CustomNavbarWidget extends StatelessWidget {
  final String currentRoute;

  const CustomNavbarWidget({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    final viewModel = NavBarViewModel(context, currentRoute);
    final Color _iconColors = ColorsConstants.greenColor;

    return NavigationBar(
      height: 70,
      backgroundColor: ColorsConstants.primaryColor,
      indicatorColor: _iconColors.withOpacity(0.2),
      selectedIndex: viewModel.currentIndex,
      onDestinationSelected: viewModel.onItemTapped,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home, color: _iconColors),
          label: '',
        ),
        NavigationDestination(
          icon: Icon(Icons.search),
          selectedIcon: Icon(Icons.search, color: _iconColors),
          label: '',
        ),
        NavigationDestination(
          icon: Icon(Icons.star_border),
          selectedIcon: Icon(Icons.star, color: _iconColors),
          label: '',
        ),
      ],
    );
  }
}
