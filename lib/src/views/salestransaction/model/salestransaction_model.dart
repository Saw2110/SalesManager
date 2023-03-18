class SalesTransactionModel {
  SalesTransactionModel({
    required this.transactionId,
    required this.customerId,
    required this.customerName,
    required this.transactionDate,
    required this.totalAmount,
    required this.paymentMethod,
    required this.remarks,
    required this.invoiceId,
    required this.productId,
    required this.productQuantity,
    required this.productName,
    required this.productPrice,
  });

  final String transactionId;
  final String invoiceId;
  final String customerId;
  final String customerName;
  final String productId;
  final String productName;
  final String productPrice;
  final String productQuantity;
  final String transactionDate;
  final String totalAmount;
  final String paymentMethod;
  final String remarks;

  factory SalesTransactionModel.fromJson(Map<String, dynamic> json) {
    return SalesTransactionModel(
      transactionId: json["transactionId"] ?? "",
      invoiceId: json["invoiceId"] ?? "",
      customerId: json["customerId"] ?? "",
      customerName: json["customerName"] ?? "",
      productId: json["productId"] ?? "",
      productName: json["productName"] ?? "",
      productPrice: json["productPrice"] ?? "",
      productQuantity: json["productQuantity"] ?? "",
      transactionDate: json["transactionDate"] ?? "",
      totalAmount: json["totalAmount"] ?? "",
      paymentMethod: json["paymentMethod"] ?? "",
      remarks: json["remarks"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "customerId": customerId,
        "customerName": customerName,
        "transactionDate": transactionDate,
        "totalAmount": totalAmount,
        "paymentMethod": paymentMethod,
        "remarks": remarks,
        "productId": productId,
        "productPrice": productPrice,
        "productName": productName,
        "invoiceId": invoiceId,
        "productQuantity": productQuantity,
      };
}

/*
{
	"transactionId": "123",
	"customerId": "123",
	"transactionDate": "2022",
	"totalAmount": "ds",
	"paymentMethod": "Credit Card",
	"remarks": "Transaction completed successfully."
}*/