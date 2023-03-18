import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../../services/services.dart';
import '../salestransaction.dart';

class SalesTransactionDatabase {
  Database? db;

  SalesTransactionDatabase._privateConstructor();

  static final SalesTransactionDatabase instance =
      SalesTransactionDatabase._privateConstructor();

  Future<int> insertData(SalesTransactionModel data) async {
    db = await DatabaseHelper.instance.database;
    debugPrint("INSERT DATA => $data");
    return await db!.insert(
      DatabaseDetails.salesTransactionTable,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateData(SalesTransactionModel data) async {
    db = await DatabaseHelper.instance.database;
    debugPrint("UPDATE DATA => ${jsonEncode(data)}");
    return await db!.insert(
      DatabaseDetails.salesTransactionTable,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future deleteData() async {
    db = await DatabaseHelper.instance.database;
    return await db!
        .rawQuery(''' DELETE FROM ${DatabaseDetails.salesTransactionTable} ''');
  }

  Future<RxList<SalesTransactionModel>> getTransactionListBytransId(
      {required String transId}) async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT * FROM ${DatabaseDetails.salesTransactionTable} WHERE ${DatabaseDetails.transactionId} = "$transId" ''');

    debugPrint("MapData => $mapData");

    return RxList.generate(mapData.length, (i) {
      return SalesTransactionModel.fromJson(mapData[i]);
    });
  }

  Future<RxList<SalesTransactionModel>> getCustomerList() async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        '''SELECT DISTINCT ${DatabaseDetails.customerId},${DatabaseDetails.customerName} FROM ${DatabaseDetails.salesTransactionTable}''');

    return RxList.generate(mapData.length, (i) {
      return SalesTransactionModel.fromJson(mapData[i]);
    });
  }

  Future<RxList<SalesTransactionModel>> getTransactionListBytransCustomerId(
      customerId) async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        '''SELECT  * FROM ${DatabaseDetails.salesTransactionTable}  WHERE ${DatabaseDetails.customerId} = "$customerId" AND ${DatabaseDetails.invoiceId} = "0"  ''');

    debugPrint("Transaction List => $mapData");

    return RxList.generate(mapData.length, (i) {
      return SalesTransactionModel.fromJson(mapData[i]);
    });
  }

  Future<RxList<SalesTransactionModel>> updateForInvoiceGeneration(
      {required String invoiceId,
      required String transId,
      required String customerId}) async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        '''UPDATE ${DatabaseDetails.salesTransactionTable} SET ${DatabaseDetails.invoiceId} = "$invoiceId"  WHERE ${DatabaseDetails.transactionId} = "$transId" AND ${DatabaseDetails.customerId} = "$customerId"  ''');

    debugPrint("Transaction List => $mapData");
    debugPrint(
        " \n\n  '''UPDATE ${DatabaseDetails.salesTransactionTable} SET ${DatabaseDetails.invoiceId} = \"$invoiceId\"  WHERE ${DatabaseDetails.transactionId} = \"$transId\" AND ${DatabaseDetails.customerId} = \"$customerId\"  '''  \n\n ");
    return RxList.generate(mapData.length, (i) {
      return SalesTransactionModel.fromJson(mapData[i]);
    });
  }

  Future<RxList<SalesTransactionModel>> getInvoiceFromInvoiceId(
      invoiceId) async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        '''SELECT  * FROM ${DatabaseDetails.salesTransactionTable} WHERE ${DatabaseDetails.invoiceId} = "$invoiceId" ''');

    debugPrint("Transaction List => $mapData");

    return RxList.generate(mapData.length, (i) {
      return SalesTransactionModel.fromJson(mapData[i]);
    });
  }
}
