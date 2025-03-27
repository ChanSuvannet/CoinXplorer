// coin_model.dart

class CoinModel {
  final String id;
  final String name;
  final String symbol;
  final double currentPrice;

  CoinModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.currentPrice,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      currentPrice: json['current_price'].toDouble(),
    );
  }
}
