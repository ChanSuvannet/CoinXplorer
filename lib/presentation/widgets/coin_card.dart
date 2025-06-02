// coin_card.dart

import 'package:coinxplorer/data/models/coin_model.dart';
import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  final CoinModel coin;

  const CoinCard({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Text(coin.name),
        subtitle: Text(coin.symbol.toUpperCase()),
        trailing: Text(Formatters.formatCurrency(coin.currentPrice)),
      ),
    );
  }
}

class Formatters {
  static String formatCurrency(double value) {
    return '\$${value.toStringAsFixed(2)}';
  }
}
