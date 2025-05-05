import 'dart:convert';
import 'package:brasilcripto/core/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import '../model/details_model.dart';
import '../model/home_model.dart';
import '../model/search_model.dart';

class CryptoRepository {
  final String _baseUrl = ApiConstants.baseUrlGecko;
  final String _currency = ApiConstants.defaultCurrency;
  final Map<String, String> _header = {
    "accept": "application/json",
    "x-cg-demo-api-key": ApiConstants.apiKeyGecko,
  };

  Future<List<HomeModel>> getTopGainers() async {
    final url = Uri.parse("$_baseUrl/coins/markets?vs_currency=$_currency");

    final response = await http.get(url, headers: _header);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => HomeModel.fromJson(json)).toList();

    } else {
      throw Exception('Erro ao carregar moedas populares');
    }
  }

  Future<List<SearchModel>> searchCoins(String query) async {
    final url = Uri.parse("$_baseUrl/search?query=$query");

    final response = await http.get(url, headers: _header,);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final List coins = jsonBody['coins'];
      return coins.map((e) => SearchModel.fromJson(e)).toList();
    } else {
      throw Exception("Erro ao buscar moedas (pesquisa)");
    }
  }
  Future<SearchModel> getCoinById(String id) async {
    final url = Uri.parse('$_baseUrl/coins/$id');
    final response = await http.get(url, headers: _header);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return SearchModel.fromJson(data);
    }

    throw Exception('Erro ao buscar moedas (favoritos)');
  }

  Future<List<DetailsModel>> fetchInitialCandles(String symbol) async {
    final url = Uri.parse(
        'https://api.binance.com/api/v3/klines?symbol=${symbol.toUpperCase()}USDT&interval=1m&limit=15');
    final response = await http.get(url);

    final decoded = jsonDecode(response.body);

    if (decoded is Map<String, dynamic> && decoded.containsKey('code')) {
      throw Exception('Erro Binance: ${decoded['msg']}');
    }
    final List data = decoded;

    return data.map((k) {
      return DetailsModel(
        DateTime.fromMillisecondsSinceEpoch(k[0]),
        double.parse(k[1]),
        double.parse(k[2]),
        double.parse(k[3]),
        double.parse(k[4]),
      );
    }).toList();
  }


  WebSocketChannel connectToWebSocket(String symbol) {
    return WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/${symbol.toLowerCase()}usdt@kline_1m'),
    );
  }

  Future<Map<String, dynamic>> fetchCoinDetails(String id) async {
    final url = Uri.parse('$_baseUrl/coins/$id');
    final response = await http.get(url, headers: _header);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao carregar detalhes da moeda');
    }
  }

  Future<List<dynamic>> fetchOhlcData(String coinId, {int days = 7}) async {
    final url = Uri.parse('$_baseUrl/coins/$coinId/ohlc?vs_currency=$_currency&days=$days');
    final response = await http.get(url, headers: _header);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha ao carregar OHLC de $coinId');
    }
  }


}
