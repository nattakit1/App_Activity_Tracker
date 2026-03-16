class Activity {

  int? id;
  String name;
  String type;
  int hours;
  String status;
  String location;
  String date;

  Activity({
    this.id,
    required this.name,
    required this.type,
    required this.hours,
    required this.status,
    required this.location,
    required this.date,
  });

  Map<String, dynamic> toMap() {

    return {
      'id': id,
      'name': name,
      'type': type,
      'hours': hours,
      'status': status,
      'location': location,
      'date': date,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {

    return Activity(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      hours: map['hours'],
      status: map['status'],
      location: map['location'],
      date: map['date'],
    );
  }
}