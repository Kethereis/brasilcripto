import 'package:brasilcripto/view/widget/custom_navbar_widget.dart';
import 'package:flutter/material.dart';

class RouteWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final String currentRoute;
  final String? title;

  const RouteWrapper({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    required this.currentRoute,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final showNavBar = currentRoute != '/login';

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: showNavBar ? CustomNavbarWidget(currentRoute: currentRoute) : null,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                padding: padding,
                physics: const BouncingScrollPhysics(),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
