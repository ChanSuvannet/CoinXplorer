import 'dart:async';
import 'dart:convert';

import 'package:coinxplorer/core/config/config.dart';
import 'package:coinxplorer/data/models/coin_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = Config.baseUrl;

  Future<List<CoinModel>> fetchCoins() async {
    try {
      final response = await http
          .get(Uri.parse("${baseUrl}coins/markets?vs_currency=usd"))
          .timeout(Duration(seconds: 10)); // Timeout added

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((e) => CoinModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load coins, status code: ${response.statusCode}');
      }
    } on TimeoutException catch (_) {
      throw Exception('Request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to load coins: $e');
    }
  }
}
