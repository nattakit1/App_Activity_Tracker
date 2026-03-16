import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/activity.dart';
import '../providers/activity_provider.dart';

class AddEditActivityScreen extends StatefulWidget {

  final Activity? activity;

  const AddEditActivityScreen({super.key, this.activity});

  @override
  State<AddEditActivityScreen> createState() => _AddEditActivityScreenState();
}

class _AddEditActivityScreenState extends State<AddEditActivityScreen> {

  final nameController = TextEditingController();
  final hoursController = TextEditingController();
  final locationController = TextEditingController();
  final dateController = TextEditingController();

  String type = "Academic";
  String status = "Joined";

  bool isEdit = false;

  @override
  void initState() {
    super.initState();

    if (widget.activity != null) {
      isEdit = true;

      nameController.text = widget.activity!.name;
      hoursController.text = widget.activity!.hours.toString();
      locationController.text = widget.activity!.location;
      dateController.text = widget.activity!.date;
      type = widget.activity!.type;
      status = widget.activity!.status;
    }
  }

  Future pickDate() async {

    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));

    if (picked != null) {
      dateController.text =
          "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ActivityProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text(isEdit ? "Edit Activity" : "Add Activity")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: ListView(
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Activity Name"),
            ),

            TextField(
              controller: hoursController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Hours"),
            ),

            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: "Location"),
            ),

            TextField(
              controller: dateController,
              readOnly: true,
              onTap: pickDate,
              decoration: const InputDecoration(
                  labelText: "Date",
                  suffixIcon: Icon(Icons.calendar_today)),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField(
              value: type,
              items: const [
                DropdownMenuItem(value: "Academic", child: Text("Academic")),
                DropdownMenuItem(value: "Volunteer", child: Text("Volunteer")),
                DropdownMenuItem(value: "Sport", child: Text("Sport")),
                DropdownMenuItem(value: "Other", child: Text("Other")),
              ],
              onChanged: (value) {
                setState(() {
                  type = value.toString();
                });
              },
              decoration: const InputDecoration(labelText: "Activity Type"),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField(
              value: status,
              items: const [
                DropdownMenuItem(value: "Joined", child: Text("Joined")),
                DropdownMenuItem(value: "Not Joined", child: Text("Not Joined")),
              ],
              onChanged: (value) {
                setState(() {
                  status = value.toString();
                });
              },
              decoration: const InputDecoration(labelText: "Status"),
            ),

            const SizedBox(height: 25),

            ElevatedButton(

              child: Text(isEdit ? "Update Activity" : "Save Activity"),

              onPressed: () {

                if (nameController.text.isEmpty ||
                    hoursController.text.isEmpty ||
                    dateController.text.isEmpty) {

                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all fields")));
                  return;
                }

                final activity = Activity(
                  id: widget.activity?.id,
                  name: nameController.text,
                  type: type,
                  hours: int.parse(hoursController.text),
                  status: status,
                  location: locationController.text,
                  date: dateController.text,
                );

                if (isEdit) {
                  provider.updateActivity(activity);
                } else {
                  provider.addActivity(activity);
                }

                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Saved successfully")));

                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}