// coin_provider.dart

import 'package:coinxplorer/data/models/coin_model.dart';
import 'package:coinxplorer/data/repositories/coin_repository.dart';
import 'package:flutter/material.dart';

class CoinProvider with ChangeNotifier {
  final CoinRepository coinRepository;
  List<CoinModel> _coins = [];
  bool _loading = false;

  CoinProvider({required this.coinRepository});

  List<CoinModel> get coins => _coins;
  bool get loading => _loading;

  Future<void> fetchCoins() async {
    _loading = true;
    notifyListeners();
    try {
      _coins = await coinRepository.getCoins();
    } catch (e) {
      print("Error fetching coins: $e");
    }
    _loading = false;
    notifyListeners();
  }
}
