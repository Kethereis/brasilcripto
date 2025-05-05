import 'package:brasilcripto/view/widget/custom_dialog_widget.dart';
import 'package:brasilcripto/view/widget/input_text_widget.dart';
import 'package:brasilcripto/viewmodel/search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_constants.dart';
import 'details_view.dart';


class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchViewModel(),
      child: Consumer<SearchViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              InputTextWidget(
                hintText: "Pesquisar... Ex: BTC ou Bitcoin",
                icon: Icons.search,
                elevation: 3,
                controller: _controller,
                focusNode: _focusNode,
                onChanged: (value) {
                  if (value.length >= 2) {
                    viewModel.search(value);
                  }
                },
              ),
              if (viewModel.isLoading)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
              ...viewModel.coins.map((coin) => GestureDetector(
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
                title: Text(coin.name, style: TextStyle(color: ColorsConstants.whiteColor)),
                subtitle: Text(coin.symbol),
                trailing: IconButton(
                  icon: Icon(
                    coin.isFavorite ? Icons.star : Icons.star_border,
                    color: coin.isFavorite ? Colors.amber : Colors.grey,
                  ),
                  onPressed: () async {
                    if (coin.isFavorite) {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => CustomDialogWidget(
                          title: 'Remover favorito',
                          content: 'Tem certeza que deseja remover ${coin.name} dos favoritos?',
                        ),
                      );

                      if (confirm == true) {
                        viewModel.toggleFavorite(coin);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${coin.name} removida dos favoritos')),
                        );
                      }
                    } else {
                      viewModel.toggleFavorite(coin);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${coin.name} adicionada aos favoritos')),
                      );
                    }
                  },

                ),
              ))),
            ],
          );
        },
      ),
    );
  }
}
