class HomeModel {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final int marketCapRank;
  final double currentPrice;
  final double totalVolume;
  final double priceChangePercentage24h;

  HomeModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.marketCapRank,
    required this.currentPrice,
    required this.totalVolume,
    required this.priceChangePercentage24h,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      image: json['image'],
      marketCapRank: json['market_cap_rank'],
      currentPrice: (json['current_price'] as num).toDouble(),
      totalVolume: (json['total_volume'] as num).toDouble(),
      priceChangePercentage24h: (json['price_change_percentage_24h'] as num).toDouble(),
    );
  }
}
