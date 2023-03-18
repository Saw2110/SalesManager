import 'package:sqflite/sqflite.dart';

import 'database_const.dart';

class CreateTable {
  Database db;
  CreateTable(this.db);

  // Product Table
  productTable() async {
    await db
        .execute(''' CREATE TABLE if not exists ${DatabaseDetails.productTable}(
                                                ${DatabaseDetails.productId} TEXT Primary Key,
                                                ${DatabaseDetails.productName} TEXT,
                                                ${DatabaseDetails.productDescription} TEXT,
                                                ${DatabaseDetails.productPrice} TEXT,
                                                ${DatabaseDetails.productQuantity} TEXT) ''');
  }

  // Customer Table
  customerTable() async {
    await db.execute(
        ''' CREATE TABLE if not exists ${DatabaseDetails.customerTable}(
                                                ${DatabaseDetails.customerId} TEXT Primary Key,
                                                ${DatabaseDetails.customerName} TEXT,
                                                [${DatabaseDetails.address}] TEXT,
                                                ${DatabaseDetails.phoneNumber} TEXT,
                                                ${DatabaseDetails.emailAddress} TEXT) ''');
  }

  // Sales Transaction Table
  salesTransactionTable() async {
    await db.execute(
        ''' CREATE TABLE if not exists ${DatabaseDetails.salesTransactionTable} (  
                                                ${DatabaseDetails.transactionId} TEXT Primary Key,   
                                                ${DatabaseDetails.invoiceId} TEXT,      
                                                ${DatabaseDetails.customerId} TEXT,      
                                                ${DatabaseDetails.customerName} TEXT,      
                                                ${DatabaseDetails.productId} TEXT,      
                                                ${DatabaseDetails.productName} TEXT,      
                                                ${DatabaseDetails.productPrice} TEXT,      
                                                ${DatabaseDetails.productQuantity} TEXT,      
                                                ${DatabaseDetails.transactionDate} TEXT,      
                                                ${DatabaseDetails.totalAmount} TEXT,      
                                                ${DatabaseDetails.paymentMethod} TEXT,      
                                                ${DatabaseDetails.remarks} TEXT) ''');
  }

  // Invoice Table
  invoiceTable() async {
    await db.execute(
        ''' CREATE TABLE if not exists ${DatabaseDetails.invoiceTable} (  
                                                ${DatabaseDetails.invoiceId} TEXT PrimaryKey,      
                                                ${DatabaseDetails.transactionId} TEXT,    
                                                ${DatabaseDetails.customerId} TEXT,      
                                                ${DatabaseDetails.customerName} TEXT,   
                                                ${DatabaseDetails.invoiceDate} TEXT,      
                                                ${DatabaseDetails.invoiceDueDate} TEXT,      
                                                ${DatabaseDetails.totalAmount} TEXT,      
                                                ${DatabaseDetails.remarks} TEXT) ''');
  }
}
