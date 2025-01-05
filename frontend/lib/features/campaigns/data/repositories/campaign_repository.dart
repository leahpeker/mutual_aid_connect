import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../domain/models/campaign.dart';
import '/core/config/api_config.dart';

class CampaignRepository {
  final String baseUrl = ApiConfig.baseUrl;

  /// Fetch all campaigns
  Future<List<Campaign>> getCampaigns() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/campaigns'));

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

    Future<Campaign> createCampaign({
    required String title,
    required String description,
    required double targetAmount,
    required double locationLat,
    required double locationLng,
    required DateTime endsAt,
    required String imageUrl,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/campaigns');


      final payload = {
        'title': title,
        'description': description,
        'target_amount': targetAmount,
        'location_lat': locationLat,
        'location_lng': locationLng,
        'ends_at': endsAt.toUtc().toIso8601String(),
        'image': imageUrl,
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final campaignJson = json.decode(response.body);
        return Campaign.fromJson(campaignJson);
      } else {
        throw Exception('Failed to create campaign: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }


  /// Fetch a campaign by ID
  Future<Campaign> getCampaignById(String campaignId) async {
    try {
      final url = Uri.parse('$baseUrl/campaigns/$campaignId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final campaignJson = json.decode(response.body);
        return Campaign.fromJson(campaignJson);
      } else if (response.statusCode == 404) {
        throw Exception('Campaign not found');
      } else {
        throw Exception('Failed to load campaign: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
}
