import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';


class DBProvider {

  static final DBProvider _instance = new DBProvider.internal();
  factory DBProvider() => _instance;

  static Database _db; 

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  } 
  
  DBProvider.internal();

  initDb() async {
    
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,"data_agua.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){
      // Load database from asset and copy
      ByteData data = await rootBundle.load(join('data', 'agua.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await new File(path).writeAsBytes(bytes);
    }

    var ourDb = await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
    );

    return ourDb;
  }

  
  }