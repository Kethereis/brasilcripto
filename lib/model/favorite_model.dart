class FavoriteModel {
  final String id;
  final String name;
  final String symbol;
  final String thumb;

  FavoriteModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.thumb,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      thumb: json['image']?['thumb'] ?? '',
    );
  }
}
