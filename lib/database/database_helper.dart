import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/activity.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {

    if (_database != null) return _database!;

    _database = await _initDB('activity.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {

    await db.execute('''
CREATE TABLE activities(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  type TEXT,
  hours INTEGER,
  status TEXT,
  location TEXT,
  date TEXT
)
''');
  }

  Future insertActivity(Activity activity) async {

    final db = await instance.database;

    await db.insert('activities', activity.toMap());
  }

  Future<List<Activity>> getActivities() async {

    final db = await instance.database;

    final result = await db.query('activities');

    return result.map((e) => Activity.fromMap(e)).toList();
  }

  Future updateActivity(Activity activity) async {

    final db = await instance.database;

    await db.update(
      'activities',
      activity.toMap(),
      where: 'id=?',
      whereArgs: [activity.id],
    );
  }

  Future deleteActivity(int id) async {

    final db = await instance.database;

    await db.delete(
      'activities',
      where: 'id=?',
      whereArgs: [id],
    );
  }
}