// coin_card.dart

import 'package:coinxplorer/core/utils/formatters.dart';
import 'package:coinxplorer/data/models/coin_model.dart';
import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  final CoinModel coin;

  CoinCard({required this.coin});

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
