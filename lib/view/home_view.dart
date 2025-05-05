import 'package:brasilcripto/app_route.dart';
import 'package:brasilcripto/view/widget/popular_coin_widget.dart';
import 'package:brasilcripto/view/widget/input_text_widget.dart';
import 'package:brasilcripto/view/widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repository/crypto_repository.dart';
import '../viewmodel/home_viewmodel.dart';
import 'details_view.dart';

class HomeView extends StatelessWidget {
   HomeView({super.key});

   @override
   Widget build(BuildContext context) {
     return MultiProvider(
       providers: [
         ChangeNotifierProvider(create: (_) => HomeViewModel(CryptoRepository())..loadTopGainers()),
       ],
       child: Consumer<HomeViewModel>(
         builder: (context, cryptoVm, _) {
           return Column(
             children: [
               Align(
                 alignment: Alignment.topLeft,
                 child: Text("Pesquisar", style: TextStyle(fontSize: 22)),
               ),
               SizedBox(height: 10),
               InputTextWidget(
                 hintText: "Pesquisar...",
                 icon: Icons.search,
                 elevation: 3,
                 onTap: () => cryptoVm.navigateToSearch(context),
               ),

               SizedBox(height: 20),
               Align(
                 alignment: Alignment.topLeft,
                 child: Text("Populares", style: TextStyle(fontSize: 22)),
               ),
               SizedBox(height: 10),
               if (cryptoVm.isLoading)
                 ListView.separated(
                   shrinkWrap: true,
                   physics: NeverScrollableScrollPhysics(),
                   itemCount: 10,
                   itemBuilder: (_, __) => const ShimmerWidget(),
                   separatorBuilder: (_, __) => SizedBox(height: 30),
                 )

               else if (cryptoVm.error != null)
                 Text('${cryptoVm.error}',
                 textAlign: TextAlign.center,)
               else
                 ListView.separated(
                   shrinkWrap: true,
                   physics: NeverScrollableScrollPhysics(),
                   itemCount: cryptoVm.topGainers.length,
                   itemBuilder: (context, index) {
                     final coin = cryptoVm.topGainers[index];
                     return GestureDetector(
                         onTap: (){
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (_) => DetailsView(symbol: coin.symbol, id: coin.id,),
                         ),
                       );
                     },
                     child: PopularCoinWidget(
                       name: coin.name,
                       amountBRL: '\$${coin.currentPrice.toStringAsFixed(2)}',
                       symbol: coin.symbol.toUpperCase(),
                       iconPath: coin.image,
                     ));
                   },
                   separatorBuilder: (context, index) => SizedBox(height: 30),
                 ),
             ],
           );
         },
       ),
     );
   }

}