import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../domain/models/campaign.dart';
import '/core/config/api_config.dart';

class CampaignRepository {
  final String baseUrl = ApiConfig.baseUrl;

  Future<List<Campaign>> getCampaigns() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/campaigns'));
      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> campaignsJson = json.decode(response.body);
        return campaignsJson.map((json) => Campaign.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load campaigns: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
}
