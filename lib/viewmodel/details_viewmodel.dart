import 'dart:convert';
import 'package:brasilcripto/model/details_model.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../repository/crypto_repository.dart';

class DetailsViewModel extends ChangeNotifier {
  final CryptoRepository repository;
  final String symbol;
  final String id;

  List<DetailsModel> _candles = [];
  late WebSocketChannel _channel;

  bool hasError = false;

  String? errorMessage;
  String? description;
  double? marketCap;
  double? volume;

  List<DetailsModel> get candles => _candles;
  DetailsModel? get latest => _candles.isNotEmpty ? _candles.last : null;

  DetailsViewModel({required this.repository, required this.symbol, required this.id});

  Future<void> init() async {
    try {
      _candles = await repository.fetchInitialCandles(symbol);
    } catch (e) {
      hasError = true;
      errorMessage = e.toString();
    }    await fetchDetails();
    notifyListeners();
    _channel = repository.connectToWebSocket(symbol);
    _channel.stream.listen(_handleWebSocketMessage);
  }

  Future<void> fetchDetails() async {
    final data = await repository.fetchCoinDetails(id.toLowerCase());
    description = data['description']['en'];
    marketCap = data['market_data']['market_cap']['usd']?.toDouble();
    volume = data['market_data']['total_volume']['usd']?.toDouble();
    notifyListeners();
  }

  void _handleWebSocketMessage(dynamic message) {
    final data = jsonDecode(message);
    final k = data['k'];

    final newCandle = DetailsModel(
      DateTime.fromMillisecondsSinceEpoch(k['t']),
      double.parse(k['o']),
      double.parse(k['h']),
      double.parse(k['l']),
      double.parse(k['c']),
    );

    if (_candles.isNotEmpty && _candles.last.time == newCandle.time) {
      _candles[_candles.length - 1] = newCandle;
    } else {
      _candles.add(newCandle);
      if (_candles.length > 100) {
        _candles.removeAt(0);
      }
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
