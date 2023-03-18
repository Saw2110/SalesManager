class CustomerModel {
  CustomerModel({
    required this.customerId,
    required this.customerName,
    required this.address,
    required this.phoneNumber,
    required this.emailAddress,
  });

  final String customerId;
  final String customerName;
  final String address;
  final String phoneNumber;
  final String emailAddress;

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      customerId: json["customerId"] ?? "",
      customerName: json["customerName"] ?? "",
      address: json["address"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      emailAddress: json["emailAddress"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "customerId": customerId,
        "customerName": customerName,
        "address": address,
        "phoneNumber": phoneNumber,
        "emailAddress": emailAddress,
      };
}

/*
{
	"customerId": "123",
	"customerName": "Example Customer",
	"address": "123 Main St",
	"phoneNumber": "555-555-5555",
	"emailAddress": "example@example.com"
}*/