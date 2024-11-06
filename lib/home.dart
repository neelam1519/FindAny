import 'package:findany/busbooking/busbookinghome.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Directly navigate to the bus booking home page after build is complete
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BusBookingHome()),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('FindAny'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Text('Redirecting to Bus Booking Home Page...'),
      ),
    );
  }
}
