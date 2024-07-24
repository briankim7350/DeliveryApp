import 'package:flutter/material.dart';
import 'order_tracking_screen.dart';
import 'auth_service.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  CartScreen({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    double totalPrice = cartItems.fold(0, (sum, item) => sum + item['price']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          if (authService.isLoggedIn)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text('Hello, ${authService.name}!')),
            )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ...cartItems.map((item) => ListTile(
              title: Text(item['name']),
              subtitle: Text('\$${item['price']}'),
            )),
            Text('Total Price: \$${totalPrice.toStringAsFixed(2)}'),
            SizedBox(height: 20),
            if (authService.isLoggedIn) ...[
              Text('Name: ${authService.name ?? ''}'),
              Text('Address: ${authService.address ?? ''}'),
              Text('Phone Number: ${authService.phoneNumber ?? ''}'),
            ],
            ElevatedButton(
              onPressed: () {
                if (authService.isLoggedIn) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderTrackingScreen(deliveryTime: 10)),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              },
              child: Text('Proceed to Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
