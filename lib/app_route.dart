import 'package:brasilcripto/view/favorite_view.dart';
import 'package:brasilcripto/view/home_view.dart';
import 'package:brasilcripto/view/search_view.dart';
import 'package:brasilcripto/view/widget/route_wrapper_widget.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) =>  RouteWrapper(
        currentRoute: state.uri.toString(),
        child: HomeView()),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) =>  RouteWrapper(
          currentRoute: state.uri.toString(),
          child: HomeView()),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) =>  RouteWrapper(
          title: 'Pesquisar',
        currentRoute: state.uri.toString(),
        child: SearchView()),
    ),
    GoRoute(
      path: '/favorite',
      builder: (context, state) =>  RouteWrapper(
          title: 'Favoritos',
          currentRoute: state.uri.toString(),
          child: FavoritesView()),
    ),
  ],
);
