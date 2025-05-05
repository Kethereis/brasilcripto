import 'package:brasilcripto/model/details_model.dart';
import 'package:brasilcripto/viewmodel/details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../core/app_constants.dart';
import '../repository/crypto_repository.dart';


class DetailsView extends StatelessWidget {
  final String symbol;
  final String id;
  const DetailsView({required this.symbol,required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final vm = DetailsViewModel(
          repository: CryptoRepository(),
          symbol: symbol,
          id: id
        );
        vm.init();
        return vm;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.black,
          title: Text('Detalhes: $symbol', style: TextStyle(color: ColorsConstants.whiteColor),)),
        body: Consumer<DetailsViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.hasError) {
              return Center(child: Text(viewModel.errorMessage ?? 'Erro ao carregar dados'));
            }

            if (viewModel.candles.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }


            final visibleCandles = viewModel.candles.length >= 15
                ? viewModel.candles.sublist(viewModel.candles.length - 15)
                : viewModel.candles;

            Color priceColor = Colors.green;
            if (viewModel.latest != null && viewModel.candles.length >= 2) {
              final previousCandle = viewModel.candles[viewModel.candles.length - 2];
              if (viewModel.latest!.close < previousCandle.close) {
                priceColor = Colors.red;
              } else {
                priceColor = Colors.green;
              }
            }


            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: SfCartesianChart(
                      plotAreaBorderWidth: 0,
                      primaryXAxis: DateTimeAxis(
                        axisLine: AxisLine(width: 0),
                        majorGridLines: MajorGridLines(width: 0),
                      ),
                      primaryYAxis: NumericAxis(
                        axisLine: AxisLine(width: 0),
                        majorGridLines: MajorGridLines(width: 0),
                      ),
                      zoomPanBehavior: ZoomPanBehavior(
                        enablePanning: true,
                        zoomMode: ZoomMode.x,
                      ),
                      trackballBehavior: TrackballBehavior(
                        enable: true,
                        activationMode: ActivationMode.singleTap,
                        tooltipSettings: const InteractiveTooltip(enable: true),
                      ),
                      series: <CandleSeries>[
                        CandleSeries<DetailsModel, DateTime>(
                          dataSource: visibleCandles,
                          xValueMapper: (DetailsModel data, _) => data.time,
                          lowValueMapper: (DetailsModel data, _) => data.low,
                          highValueMapper: (DetailsModel data, _) => data.high,
                          openValueMapper: (DetailsModel data, _) => data.open,
                          closeValueMapper: (DetailsModel data, _) => data.close,
                          enableTooltip: true,
                          enableSolidCandles: true,
                          animationDuration: 0,
                          bearColor: Colors.red,
                          bullColor: Colors.green,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (viewModel.latest != null)
                    Row(children: [
                    Text(
                      'Preço atual:',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                      SizedBox(width: 3,),
                      Text(
                        '\$${viewModel.latest!.close}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: priceColor),
                      ),
                    ],),
                  const SizedBox(height: 16),

                  if (viewModel.marketCap != null)
                    Text('Market Cap: \$${viewModel.marketCap!.toStringAsFixed(2)}'),
                  if (viewModel.volume != null)
                    Text('Volume 24h: \$${viewModel.volume!.toStringAsFixed(2)}'),
                  const SizedBox(height: 16),
                  if (viewModel.description != null)
                    Text(
                      viewModel.description!,
                      style: const TextStyle(fontSize: 14),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
