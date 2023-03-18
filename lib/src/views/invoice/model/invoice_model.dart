class InvoiceModel {
  InvoiceModel({
    required this.invoiceId,
    required this.transactionId,
    required this.customerId,
    required this.customerName,
    required this.invoiceDate,
    required this.invoiceDueDate,
    required this.totalAmount,
    required this.remarks,
  });

  final String invoiceId;
  final String transactionId;
  final String customerId;
  final String customerName;
  final String invoiceDate;
  final String invoiceDueDate;
  final String totalAmount;
  final String remarks;

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      invoiceId: json["invoiceId"] ?? "",
      transactionId: json["transactionId"] ?? "",
      customerId: json["customerId"] ?? "",
      customerName: json["customerName"] ?? "",
      invoiceDate: json["invoiceDate"] ?? "",
      invoiceDueDate: json["invoiceDueDate"] ?? "",
      totalAmount: json["totalAmount"] ?? "",
      remarks: json["remarks"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "invoiceId": invoiceId,
        "transactionId": transactionId,
        "customerId": customerId,
        "customerName": customerName,
        "invoiceDate": invoiceDate,
        "invoiceDueDate": invoiceDueDate,
        "totalAmount": totalAmount,
        "remarks": remarks,
      };
}

/*
{
	"invoiceId": "123",
	"transactionId": "456",
	"invoiceDate": "20226",
	"invoiceDueDate": "2022",
	"totalAmount": "100.5",
	"remarks": "Please make payment promptly."
}*/
