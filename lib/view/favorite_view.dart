import 'package:brasilcripto/core/app_constants.dart';
import 'package:brasilcripto/view/widget/custom_dialog_widget.dart';
import 'package:brasilcripto/view/widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/favorite_viewmodel.dart';
import 'details_view.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoritesViewModel()..loadFavorites(),
      child: Consumer<FavoritesViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.isLoading) {
            return  ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (_, __) => const ShimmerWidget(),
              separatorBuilder: (_, __) => SizedBox(height: 30),
            );
          }

          final favorites = viewModel.favorites;

          if (favorites.isEmpty) {
            return const Center(child: Text('Nenhum favorito salvo.'));
          }

          return  ListView.builder(
            shrinkWrap: true,
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final coin = favorites[index];
              return GestureDetector(
                  onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailsView(symbol: coin.symbol, id: coin.id,),
                  ),
                );
              },
              child:ListTile(
                leading: Image.network(coin.thumb),
                title: Text(coin.name, style: TextStyle(color: ColorsConstants.whiteColor),),
                subtitle: Text(coin.symbol),
                trailing: IconButton(
                  icon: const Icon(Icons.star, color: Colors.amber),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => CustomDialogWidget(
                        title: 'Remover favorito',
                        content: 'Tem certeza que deseja remover ${coin.name} dos favoritos?',
                      ),
                    );

                    if (confirm == true) {
                      viewModel.removeFavorite(coin);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${coin.name} removida dos favoritos')),
                      );
                    }
                  },

                ),

              ));
            },
          );
        },
      ),
    );
  }
}
