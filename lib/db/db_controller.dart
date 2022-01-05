import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBController extends GetxController {
  Database? db;

  @override
  void onInit() async {
    super.onInit();
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "banksathi.db");
    var exists = await databaseExists(path);
    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      ByteData data = await rootBundle.load('assets/db/pincode_data.db');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }
    db = await openDatabase(path, readOnly: true);
  }

  Future<PinCodeRow> getPinCodesById(int id) async {
    List<Map<String, Object?>> map = await db!.query(PinCodeTable.NAME,
        columns: [
          PinCodeTable.COLUMN_ID,
          PinCodeTable.COLUMN_PINCODE,
          PinCodeTable.COLUMN_CITY_ID
        ],
        where: '${PinCodeTable.COLUMN_ID} = ?',
        whereArgs: ["$id"]);
    PinCodeRow pinCodeRow = PinCodeRow.fromMap(map.first);
    return pinCodeRow;
  }

  Future<List<PinCodeRow>> getPinCodes(String char) async {
    List<PinCodeRow> list = [];
    List<Map<String, Object?>> map = await db!.query(PinCodeTable.NAME,
        columns: [
          PinCodeTable.COLUMN_ID,
          PinCodeTable.COLUMN_PINCODE,
          PinCodeTable.COLUMN_CITY_ID
        ],
        where: '${PinCodeTable.COLUMN_PINCODE} like ?',
        whereArgs: ["$char%"]);
    list.addAll(map.map((e) => PinCodeRow.fromMap(e)).toList());
    return list;
  }

  Future<CityRow> getCityByCityId(int cityId) async {
    List<Map<String, Object?>> map = await db!.query(CityTable.NAME,
        columns: [
          CityTable.COLUMN_ID,
          CityTable.COLUMN_STATE_ID,
          CityTable.COLUMN_CITY_NAME
        ],
        where: '${CityTable.COLUMN_ID} = ?',
        whereArgs: ["$cityId"]);
    CityRow city = CityRow.fromMap(map.first);
    return city;
  }

  Future<StateRow> getStateById(int stateId) async {
    List<Map<String, Object?>> map = await db!.query(StateTable.NAME,
        columns: [
          StateTable.COLUMN_ID,
          StateTable.COLUMN_STATE_NAME,
          StateTable.COLUMN_STATE_CODE
        ],
        where: '${StateTable.COLUMN_ID} = ?',
        whereArgs: ["$stateId"]);
    StateRow state = StateRow.fromMap(map.first);
    return state;
  }

  Future<List<StateRow>> getAllState() async {
    List<Map<String, Object?>> map = await db!.query(StateTable.NAME, columns: [
      StateTable.COLUMN_ID,
      StateTable.COLUMN_STATE_NAME,
      StateTable.COLUMN_STATE_CODE
    ]);
    List<StateRow> stateList = map.map((e) => StateRow.fromMap(e)).toList();
    return stateList;
  }

  Future<List<CityRow>> getCitiesByState(int stateId) async {
    List<Map<String, Object?>> map = await db!.query(CityTable.NAME,
        columns: [
          CityTable.COLUMN_ID,
          CityTable.COLUMN_STATE_ID,
          CityTable.COLUMN_CITY_NAME
        ],
        where: '${CityTable.COLUMN_STATE_ID} = ?',
        whereArgs: ["$stateId"]);
    List<CityRow> cities = map.map((e) => CityRow.fromMap(e)).toList();
    return cities;
  }
}

class PinCodeTable {
  static const String NAME = "pincodes";
  static const String COLUMN_CITY_ID = "city_id";
  static const String COLUMN_ID = "id";
  static const String COLUMN_PINCODE = "pincode";
}

class PinCodeRow {
  int? city_id;
  int? id;
  int? pincode;

  PinCodeRow({this.city_id, this.id, this.pincode});

  factory PinCodeRow.fromMap(Map<String, dynamic> map) {
    return PinCodeRow(
      id: map[PinCodeTable.COLUMN_ID],
      pincode: map[PinCodeTable.COLUMN_PINCODE],
      city_id: map[PinCodeTable.COLUMN_CITY_ID],
    );
  }
}

class CityTable {
  static const String NAME = "cities";
  static const String COLUMN_CITY_NAME = "city_name";
  static const String COLUMN_ID = "id";
  static const String COLUMN_STATE_ID = "state_id";
}

class CityRow {
  int? state_id;
  int? id;
  String? city_name;

  CityRow({this.state_id, this.id, this.city_name});

  factory CityRow.fromMap(Map<String, dynamic> map) {
    return CityRow(
      id: map[CityTable.COLUMN_ID],
      city_name: map[CityTable.COLUMN_CITY_NAME],
      state_id: map[CityTable.COLUMN_STATE_ID],
    );
  }

  @override
  String toString() {
    return city_name ?? "NULL";
  }
}

class StateTable {
  static const String NAME = "states";
  static const String COLUMN_STATE_NAME = "state_name";
  static const String COLUMN_ID = "id";
  static const String COLUMN_STATE_CODE = "state_code";
}

class StateRow {
  String? state_name;
  int? id;
  String? state_code;

  StateRow({this.state_name, this.id, this.state_code});

  factory StateRow.fromMap(Map<String, dynamic> map) {
    return StateRow(
      id: map[StateTable.COLUMN_ID],
      state_name: map[StateTable.COLUMN_STATE_NAME],
      state_code: map[StateTable.COLUMN_STATE_CODE],
    );
  }
}
