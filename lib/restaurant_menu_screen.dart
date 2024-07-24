import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'auth_service.dart';
import 'package:provider/provider.dart';

class RestaurantMenuScreen extends StatefulWidget {
  final Map<String, dynamic> restaurant;

  RestaurantMenuScreen({required this.restaurant});

  @override
  _RestaurantMenuScreenState createState() => _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {
  List<Map<String, dynamic>> cartItems = [];
  final List<Map<String, dynamic>> menu = [
    {'name': 'Menu 1', 'price': 10},
    {'name': 'Menu 2', 'price': 15},
    {'name': 'Menu 3', 'price': 20},
  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.restaurant['name']} Menu'),
        actions: [
          if (authService.isLoggedIn)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text('Hello, ${authService.name}!')),
            )
        ],
      ),
      body: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(menu[index]['name']),
            subtitle: Text('\$${menu[index]['price']}'),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  cartItems.add(menu[index]);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartScreen(cartItems: cartItems),
            ),
          );
        },
      ),
    );
  }
}
