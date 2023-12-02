import 'dart:io'; // -> Directory object
import 'dart:async';

import 'package:sqflite/sqflite.dart'; // -> Database object
import 'package:path_provider/path_provider.dart'; // -> getApplicationDocumentsDirectory() method
import 'package:path/path.dart'; // -> join() method

import '../models/item_model.dart';
import 'repository.dart';

final newsDbProvider = NewsDbProvider();

class NewsDbProvider implements Source, Cache {
  NewsDbProvider() {
    init();
  }

  late Database db;

  // Todo - store and fetch top ids
  @override
  Future<List<int>>? fetchTopIds() {
    return null;
  }

  // do initial database setup
  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // to reset current databse we have to change the name of database, e.g. "items.db" to -> "items1.db" - it'll recreate database from scratch
    final path = join(documentsDirectory.path, "items1.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        // remember that SQL types are not always the same as Dart types, so we have to do some conversions
        newDb.execute("""
          CREATE TABLE Items
            (
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INTEGER,
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
        """);
      },
    );
  }

  // given an ID, return an individual item
  @override
  Future<ItemModel?> fetchItem(int id) async {
    final maps = await db.query(
      "Items",
      columns:
          null, // could be e.g. ["title"], but here we want to fetch only an Item. Null returns all columns
      where: "id = ?", // '?' will be replaced with 'id' from [whereArgs]
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  // insert an item into the database
  @override
  Future<int> addItem(ItemModel item) {
    return db.insert(
      "Items",
      item.toMap(),
      // this method tells databse what to do if there's a conflict where it's trying to insert an item with an ID that already exists inside the database:
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  @override
  Future<int> clear() {
    return db.delete("Items");
  }
}
