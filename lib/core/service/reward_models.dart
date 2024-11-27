import 'dart:convert';

import 'package:learn_lingo/core/models/reward_api.dart';
import 'package:learn_lingo/core/utils/localhost.dart';
import 'package:http/http.dart' as http;

class RewardModels {
  Future<RewardApi?> rewardModels(String token) async {
    final response = await http.get(
        Uri.parse('http://${Localhost.localhost}/gamification/reward-items'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return RewardApi.fromJson(jsonData);
    } else {
      return null;
    }
  }
}
