import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrreader/models/scan_model.dart';
export 'package:qrreader/models/scan_model.dart';

import 'package:sqflite/sqflite.dart';

class DBProvider{
  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async{
    if(_database != null){ 
      return _database; 
    }else{
      return _database  = await initDB(); 
    }    
  }

  Future<Database> initDB() async {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, 'ScansDB.db');
      print(path);
      return await openDatabase(
        path, 
        version: 1, 
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
        await db.execute('''
                        CREATE TABLE Scans(
                        id INTEGER PRIMARY KEY,
                        tipo TEXT,
                        valor TEXT
                        ) 
                        ''');
      });
    }

//  Future<int> nuevoScan(ScanModel scanModel) async{
    
  //   final db = await database;

  //   final res = await db.rawInsert('''
  //     INSERT INTO SCANS(ID, TIPO, VALOR)
  //     VALUES
  //   ''');

  //   return res;
  // }

  Future<int> nuevoScan(ScanModel nuevoScan) async{
    final db = await database;
    var res = await db!.insert('Scans', nuevoScan.toJson());
    return res;
  }

  Future<ScanModel> getScanById(int id) async{
    final db = await database;
    final res = await db!.query('Scans',where: 'id=?', whereArgs: [id]);
    if(res.isNotEmpty){
     return ScanModel.fromJson(res.first);
    }else{
      return ScanModel.fromJson(res.first); 
    }
  }

Future<List<ScanModel>> getScans() async {
    final db = await database;
    final res = await db!.query('Scans');
    if (res.isNotEmpty) {
      return res.map((e) => ScanModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async {
      final db = await database;
      final res = await db!.rawQuery('''
                                      select * from scans where tipo = '$tipo'
                                      ''');

      if (res.isNotEmpty) {
        return res.map((e) => ScanModel.fromJson(e)).toList();
      } else {
        return [];
      }
    }

  Future<int> updateScan(ScanModel nuevoScan) async{
    final db = await database;
    final res = await db!.update('scans', nuevoScan.toJson(), where: 'id=?', whereArgs: [nuevoScan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async{
    final db = await database;
    final res = await db!.delete('scans',  where: 'id=?', whereArgs: [id]);
    return res;
  }
  Future<int> deleteAllScan() async {
    final db = await database;
    final res = await db!.delete('scans');
    return res;
  }


}