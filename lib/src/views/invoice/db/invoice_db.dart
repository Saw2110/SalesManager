import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../../services/services.dart';
import '../model/invoice_model.dart';

class InvoiceDatabase {
  Database? db;

  InvoiceDatabase._privateConstructor();

  static final InvoiceDatabase instance = InvoiceDatabase._privateConstructor();

  Future<int> insertData(InvoiceModel data) async {
    db = await DatabaseHelper.instance.database;
    debugPrint("INSERT DATA => ${jsonEncode(data)}");
    return await db!.insert(
      DatabaseDetails.invoiceTable,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateData(InvoiceModel data) async {
    db = await DatabaseHelper.instance.database;
    debugPrint("UPDATE DATA => ${jsonEncode(data)}");
    return await db!.insert(
      DatabaseDetails.invoiceTable,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future deleteData() async {
    db = await DatabaseHelper.instance.database;
    return await db!
        .rawQuery(''' DELETE FROM ${DatabaseDetails.invoiceTable} ''');
  }

  Future<RxList<InvoiceModel>> getInvoiceFromDueDate(
      {required String dueDate}) async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT * FROM ${DatabaseDetails.invoiceTable} WHERE ${DatabaseDetails.invoiceDueDate} = "$dueDate" ''');

    debugPrint("MapData => $mapData");

    return RxList.generate(mapData.length, (i) {
      return InvoiceModel.fromJson(mapData[i]);
    });
  }

  Future<RxList<InvoiceModel>> getInvoiceDateList() async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT DISTINCT ${DatabaseDetails.invoiceId},${DatabaseDetails.invoiceDueDate},${DatabaseDetails.customerName}  FROM ${DatabaseDetails.invoiceTable} ''');

    debugPrint("MapData => $mapData");

    return RxList.generate(mapData.length, (i) {
      return InvoiceModel.fromJson(mapData[i]);
    });
  }
}
