import 'package:flutter/material.dart';
import '../models/activity.dart';

class DetailScreen extends StatelessWidget {

  final Activity activity;

  const DetailScreen({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Activity Detail")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(activity.name,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),

            Text("Type: ${activity.type}"),
            Text("Hours: ${activity.hours}"),
            Text("Location: ${activity.location}"),
            Text("Date: ${activity.date}"),
            Text("Status: ${activity.status}"),
          ],
        ),
      ),
    );
  }
}