import 'package:flutter/material.dart';
import 'restaurant_menu_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RestaurantListScreen extends StatefulWidget {
  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  List<Map<String, dynamic>> restaurants = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRestaurants();
  }

  Future<void> fetchRestaurants() async {
    final response = await http.get(
      Uri.parse('https://api.foursquare.com/v3/places/search?query=restaurant&near=seoul'),
      headers: {
        'Authorization': 'fsq3eMY/zcQrBJYjeejUVDidxz/2d/gNTdYsov43L+tEqXY='
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        restaurants = List<Map<String, dynamic>>.from(data['results']);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(restaurants[index]['name']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestaurantMenuScreen(
                    restaurant: restaurants[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
