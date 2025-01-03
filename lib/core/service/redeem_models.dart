import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn_lingo/core/models/redeem_api.dart';
import 'package:learn_lingo/core/utils/localhost.dart';

class RedeemModels {
  Future<RedeemApi?> redeemReward(String token, String jenisReward) async {
    final response = await http.post(
      Uri.parse(
          'http://${Localhost.localhost}/gamification/redeem/$jenisReward'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return RedeemApi.fromJson(jsonData);
    } else {
      final jsonData = jsonDecode(response.body);
      throw Exception(jsonData['message'] ?? 'Redeem failed');
    }
  }
}
