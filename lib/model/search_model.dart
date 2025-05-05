class SearchModel {
  final String id;
  final String name;
  final String symbol;
  final String thumb;
  bool isFavorite;


  SearchModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.thumb,
    this.isFavorite = false,

  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      thumb: json['thumb'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'thumb': thumb,
    };
  }

}
