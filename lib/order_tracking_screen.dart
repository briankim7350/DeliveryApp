import 'package:flutter/material.dart';
import 'dart:async';

class OrderTrackingScreen extends StatefulWidget {
  final int deliveryTime;

  OrderTrackingScreen({required this.deliveryTime});

  @override
  _OrderTrackingScreenState createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  late Timer _timer;
  late int _timeRemaining;

  @override
  void initState() {
    super.initState();
    _timeRemaining = widget.deliveryTime;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Tracking'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _timeRemaining > 0
              ? Text('Time remaining: $_timeRemaining seconds')
              : Text('Your order has been delivered!'),
        ),
      ),
    );
  }
}
