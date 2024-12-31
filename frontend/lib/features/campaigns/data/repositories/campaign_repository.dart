import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../domain/models/campaign.dart';

class CampaignRepository {
  final String baseUrl = 'http://your-backend-url/api';  // Update this

  Future<List<Campaign>> getCampaigns() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/campaigns'));
      
      if (response.statusCode == 200) { 
        final List<dynamic> campaignsJson = json.decode(response.body);
        return campaignsJson.map((json) => Campaign.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load campaigns');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
} 