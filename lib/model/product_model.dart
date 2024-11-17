class Product {
  final String?id;
  final String?productCode;
  final String?productName;
  final String?productDescription;
  final double?productPrice;
  final String?category;
  final String?imagePath;

  Product({
     this.id,
     this.productCode,
     this.productName,
     this.productDescription,
     this.productPrice,
     this.category,
     this.imagePath,
  });

  factory Product.fromFirestore(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      productCode: data['productCode'] ?? '',
      productName: data['productName'] ?? '',
      productDescription: data['productDescription'] ?? '',
      productPrice: (data['productPrice'] as num?)?.toDouble() ?? 0.0,
      category: data['category'] ?? '',
      imagePath: data['imagePath'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'productCode': productCode,
      'productName': productName,
      'productDescription': productDescription,
      'productPrice': productPrice,
      'category': category,
      'imagePath': imagePath,
    };
  }
}
