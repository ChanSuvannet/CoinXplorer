class Coin {
  final int rank;
  final String symbol;
  final String image;
  final double price;
  final double change;
  final double marketCap;

  Coin({
    required this.rank,
    required this.symbol,
    required this.image,
    required this.price,
    required this.change,
    required this.marketCap,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      rank: json['market_cap_rank'] ?? 0,
      symbol: (json['symbol'] ?? '').toUpperCase(),
      image: json['image'] ?? '',
      price: (json['current_price'] ?? 0).toDouble(),
      change: (json['price_change_percentage_1h'] ?? 0).toDouble(),
      marketCap: (json['market_cap'] ?? 0).toDouble(),
    );
  }
}
