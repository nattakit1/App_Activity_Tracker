import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/activity_provider.dart';
import 'list_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget buildCard(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF6B3F1D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: const Color(0xFFD4AF37),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActivityProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity Dashboard"),
        backgroundColor: const Color(0xFF6B3F1D),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// 🔹 BANNER IMAGE
            Container(
              width: double.infinity,
              height: 160,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage("assets/banner.png"),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center,
              
            ),

            /// 🔹 CARD STATS
            Row(
              children: [
                Expanded(
                  child: buildCard(
                    "Activities",
                    provider.totalActivities.toString(),
                    Icons.list,
                  ),
                ),
                Expanded(
                  child: buildCard(
                    "Hours",
                    provider.totalHours.toString(),
                    Icons.access_time,
                  ),
                ),
                Expanded(
                  child: buildCard(
                    "Joined",
                    provider.joinedActivities.toString(),
                    Icons.check_circle,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// 🔹 BUTTON
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B3F1D),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              icon: const Icon(Icons.list),
              label: const Text("View Activity List"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ListScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}