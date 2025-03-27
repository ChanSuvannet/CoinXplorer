// coin_repository.dart

import 'package:coinxplorer/data/models/coin_model.dart';
import 'package:coinxplorer/data/services/api_service.dart';

class CoinRepository {
  final ApiService apiService;

  CoinRepository({required this.apiService});

  Future<List<CoinModel>> getCoins() {
    return apiService.fetchCoins();
  }
}
