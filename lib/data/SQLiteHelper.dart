import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/Node.dart';

class SQLiteHelper {
  static const tableName_nodes = 'nodes';

  static Future<Database> getDatabase() async {
    // Open the database and store the reference.
    String path = await getDatabasesPath();
    Database database = await openDatabase(join(path, 'nodes_database.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE $tableName_nodes(id INTEGER PRIMARY KEY,"
        " avatarLarge TEXT,"
        " name TEXT,"
        " avatarNormal TEXT,"
        " title TEXT,"
        " url TEXT,"
        " footer TEXT,"
        " header TEXT,"
        " titleAlternative TEXT,"
        " avatarMini TEXT,"
        " parentNodeName TEXT,"
        " topics INTEGER,"
        " stars INTEGER,"
        " root INTEGER)",
      );
    }, version: 1);
    return database;
  }

  /// Define a function that inserts dogs into the database
  static Future<void> insertNode(Node node) async {
    // Get a reference to the database.
    final Database db = await getDatabase();

    // Insert the Node into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same node is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      tableName_nodes,
      node.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> insertNodes(List<Node> nodes) async{
    // Get a reference to the database.
    final Database db = await getDatabase();
    Batch batch = db.batch();
    nodes.forEach((node){
      batch.insert(tableName_nodes, node.toMap());
    });
    batch.commit();
  }

  /// A method that retrieves all the nodes from the nodes table.
  static Future<List<Node>> nodes() async {
    // Get a reference to the database.
    final Database db = await getDatabase();

    // Query the table for all The Nodes.
    final List<Map<String, dynamic>> maps = await db.query(tableName_nodes);

    // Convert the List<Map<String, dynamic> into a List<Node>.
    return List.generate(maps.length, (i) {
      return Node.fromMap(maps[i]);
    });
  }


}
