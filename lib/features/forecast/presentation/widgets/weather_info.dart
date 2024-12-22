import 'package:flutter/material.dart';

class WeatherInfo extends StatelessWidget {
  final IconData icon;
  final String label;

  const WeatherInfo({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 24,
          color: Colors.white, // Change this to your desired color
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white, // Change this to match your desired color
          ),
        ),
      ],
    );
  }
}
