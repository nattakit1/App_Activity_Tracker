import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/activity_provider.dart';
import 'add_edit_activity_screen.dart';
import 'detail_screen.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  Color getStatusColor(String status) {
    if (status == "Joined") {
      return Colors.green;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActivityProvider>(context);
    final activities = provider.filteredActivities;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity List"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 195, 125, 72),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6B3F1D),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEditActivityScreen(),
            ),
          );
        },
      ),

      body: Column(
        children: [

          /// SEARCH
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Activity",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                provider.searchText = value;
                provider.notifyListeners();
              },
            ),
          ),

          /// FILTER TYPE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonFormField<String>(
              value: provider.selectedType,
              items: const [
                DropdownMenuItem(
                    value: "All",
                    child: Text("All Types")),

                DropdownMenuItem(
                    value: "Academic",
                    child: Text("Academic")),

                DropdownMenuItem(
                    value: "Volunteer",
                    child: Text("Volunteer")),

                DropdownMenuItem(
                    value: "Sport",
                    child: Text("Sport")),

                DropdownMenuItem(
                    value: "Other",
                    child: Text("Other")),
              ],
              onChanged: (value) {
                provider.selectedType = value!;
                provider.notifyListeners();
              },
              decoration: InputDecoration(
                labelText: "Filter by Type",
                prefixIcon: const Icon(Icons.filter_list),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// ACTIVITY LIST
          Expanded(
            child: activities.isEmpty
                ? const Center(
                    child: Text(
                      "No activities found",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      final activity = activities[index];

                      return Card(
                        color: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),

                        child: ListTile(

                          title: Text(
                            activity.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold),
                          ),

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              const SizedBox(height: 5),

                              Text(
                                "${activity.hours} hours • ${activity.location}",
                              ),

                              const SizedBox(height: 5),

                              Row(
                                children: [

                                  /// TYPE CHIP
                                  Chip(
                                    label: Text(activity.type),
                                    backgroundColor:
                                        Colors.blue.shade100,
                                  ),

                                  const SizedBox(width: 8),

                                  /// STATUS CHIP
                                  Chip(
                                    label: Text(activity.status),
                                    backgroundColor:
                                        const Color(0xFFD4AF37)
                                            .withOpacity(0.2),
                                    labelStyle: TextStyle(
                                      color:
                                          getStatusColor(activity.status),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              /// EDIT
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          AddEditActivityScreen(
                                              activity: activity),
                                    ),
                                  );
                                },
                              ),

                              /// DELETE
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.red),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title:
                                          const Text("Delete Activity"),
                                      content: const Text(
                                          "Are you sure you want to delete this activity?"),
                                      actions: [

                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Cancel"),
                                        ),

                                        TextButton(
                                          onPressed: () {

                                            provider.deleteActivity(
                                                activity.id!);

                                            Navigator.pop(context);

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Activity deleted"),
                                                backgroundColor:
                                                    Color(0xFF6B3F1D),
                                              ),
                                            );
                                          },
                                          child: const Text("Delete"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            ],
                          ),

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    DetailScreen(activity: activity),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}