class ProductModel {
  ProductModel({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productQuantity,
  });

  final String productId;
  final String productName;
  final String productDescription;
  final String productPrice;
  final String productQuantity;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json["productId"] ?? "",
      productName: json["productName"] ?? "",
      productDescription: json["productDescription"] ?? "",
      productPrice: json["productPrice"] ?? "",
      productQuantity: json["productQuantity"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "productDescription": productDescription,
        "productPrice": productPrice,
        "productQuantity": productQuantity,
      };
}

/*
{
	"productId": "123",
	"productName": "Example Product",
	"productDescription": "This is an example product.",
	"productPrice": "19.99",
	"productQuantity": "10"
}*/