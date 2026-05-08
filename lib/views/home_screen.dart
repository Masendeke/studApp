import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),

                  Text(
                    'Manage your applications easily.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
