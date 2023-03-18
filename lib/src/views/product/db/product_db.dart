import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../../services/services.dart';
import '../product.dart';

class ProductDatabase {
  Database? db;

  ProductDatabase._privateConstructor();

  static final ProductDatabase instance = ProductDatabase._privateConstructor();

  Future<int> insertData(ProductModel data) async {
    db = await DatabaseHelper.instance.database;
    debugPrint("INSERT DATA => ${jsonEncode(data)}");
    return await db!.insert(
      DatabaseDetails.productTable,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateData(ProductModel data) async {
    db = await DatabaseHelper.instance.database;
    debugPrint("UPDATE DATA => ${jsonEncode(data)}");
    return await db!.insert(
      DatabaseDetails.productTable,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future updateStockByProductId(
      {required String productId, required String updateQuantity}) async {
    db = await DatabaseHelper.instance.database;
    return await db!.rawQuery(
        ''' UPDATE ${DatabaseDetails.productTable} SET ${DatabaseDetails.productQuantity} = '$updateQuantity' WHERE  ${DatabaseDetails.productId} = "$productId" ''');
  }

  Future deleteData() async {
    db = await DatabaseHelper.instance.database;
    return await db!
        .rawQuery(''' DELETE FROM ${DatabaseDetails.productTable} ''');
  }

  Future<RxList<ProductModel>> getProductFromId(
      {required String productId}) async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT * FROM ${DatabaseDetails.productTable} WHERE ${DatabaseDetails.productId} = "$productId" ''');

    debugPrint("MapData => $mapData");

    return RxList.generate(mapData.length, (i) {
      return ProductModel.fromJson(mapData[i]);
    });
  }

  Future<RxList<ProductModel>> getProductList() async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT * FROM ${DatabaseDetails.productTable} ORDER BY ${DatabaseDetails.productId} ASC  ''');

    debugPrint("MapData => $mapData");

    return RxList.generate(mapData.length, (i) {
      return ProductModel.fromJson(mapData[i]);
    });
  }

  /// Check Product Exist Or Not
  Future<bool> isAlreadyExist({required String productId}) async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT * FROM ${DatabaseDetails.productTable} WHERE ${DatabaseDetails.productId} = "$productId" ''');

    if (mapData.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
