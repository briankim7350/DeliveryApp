import 'dart:convert';
import 'package:http/http.dart' as http;

class FoursquareApiService {
  final String apiKey = 'fsq3eMY/zcQrBJYjeejUVDidxz/2d/gNTdYsov43L+tEqXY=';

  Future<List<Map<String, dynamic>>> fetchRestaurants() async {
    final response = await http.get(
      Uri.parse('https://api.foursquare.com/v3/places/search?near=San+Francisco&categories=13065'),
      headers: {
        'Authorization': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Restaurant List Response: $data');
      return List<Map<String, dynamic>>.from(data['results']);
    } else {
      print('Error fetching restaurant list: ${response.statusCode} ${response.body}');
      throw Exception('Failed to load restaurants');
    }
  }

  Future<Map<String, dynamic>> fetchRestaurantDetails(String fsqId) async {
    final response = await http.get(
      Uri.parse('https://api.foursquare.com/v3/places/$fsqId'),
      headers: {
        'Authorization': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Restaurant Details Response: $data');


      data['menu'] = [
        {'name': 'Menu 1', 'price': 10},
        {'name': 'Menu 2', 'price': 15},
        {'name': 'Menu 3', 'price': 20},
      ];

      return Map<String, dynamic>.from(data);
    } else {
      print('Error fetching restaurant details: ${response.statusCode} ${response.body}');
      throw Exception('Failed to load restaurant details');
    }
  }
}
