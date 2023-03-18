import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../../services/services.dart';
import '../model/customer_model.dart';

class CustomerDatabase {
  Database? db;

  CustomerDatabase._privateConstructor();

  static final CustomerDatabase instance =
      CustomerDatabase._privateConstructor();

  Future<int> insertData(CustomerModel data) async {
    db = await DatabaseHelper.instance.database;
    debugPrint("INSERT DATA => ${jsonEncode(data)}");
    return await db!.insert(
      DatabaseDetails.customerTable,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateData(CustomerModel data) async {
    db = await DatabaseHelper.instance.database;
    debugPrint("UPDATE DATA => ${jsonEncode(data)}");
    return await db!.insert(
      DatabaseDetails.customerTable,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future deleteData() async {
    db = await DatabaseHelper.instance.database;
    return await db!
        .rawQuery(''' DELETE FROM ${DatabaseDetails.customerTable} ''');
  }

  Future<RxList<CustomerModel>> getCustomerFromId(
      {required String customerId}) async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT * FROM ${DatabaseDetails.customerTable} WHERE ${DatabaseDetails.customerId} = "$customerId" ''');

    debugPrint("MapData => $mapData");

    return RxList.generate(mapData.length, (i) {
      return CustomerModel.fromJson(mapData[i]);
    });
  }

  Future<RxList<CustomerModel>> getCustomerList() async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT * FROM ${DatabaseDetails.customerTable} ORDER BY ${DatabaseDetails.customerName} ASC  ''');

    debugPrint("MapData => $mapData");

    return RxList.generate(mapData.length, (i) {
      return CustomerModel.fromJson(mapData[i]);
    });
  }

  /// Check Product Exist Or Not
  Future<bool> isAlreadyExist({required String customerId}) async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT * FROM ${DatabaseDetails.customerTable} WHERE ${DatabaseDetails.customerId} = "$customerId" ''');

    if (mapData.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
