import 'package:machine_test_norq/app/data/db/app_db.dart';

class ProductListModel {
  final List<ProductModel>? productList;

  ProductListModel({this.productList});

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    final List<ProductModel>? productList = (json['data'] as List?)?.map((e) {
      return ProductModel.fromJson(e as Map<String, dynamic>);
    }).toList();

    return ProductListModel(productList: productList);
  }

  static Future<void> fromJsonWithDatabaseInsert(
      ProductListModel productListModel) async {
    final cartProvider = CartDatabaseProvider();

    if (productListModel.productList != null) {
      for (final product in productListModel.productList!) {
        await cartProvider.addToCart(product);
      }
    }
  }
}

class ProductModel {
  final int? id;
  final String? title;
  final num? price;
  final String? description;
  final String? category;
  final String? image;
  // final Rating? rating;
  final num? ratingRate;
  final int? ratingCount;
  int? quantity;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    // this.rating,
    this.ratingRate,
    this.ratingCount,
    this.quantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
        category: json["category"],
        image: json["image"],
        // rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
        // ratingRate: json["rating"]
        //     ?["rate"], // Access rate property from rating object
        // ratingCount: json["rating"]
        //     ?["count"], // Access count property from rating object
        ratingRate: (json["rating"] as Map<String, dynamic>?)?[
            "rate"], // Extract rate property from rating object
        ratingCount: (json["rating"] as Map<String, dynamic>?)?[
            "count"], // Extract count property from rating object
        quantity: 0, // Default quantity
      );

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
        id: map['id'],
        title: map['title'],
        price: map['price'],
        description: map['description'],
        category: map['category'],
        image: map['image'],
        // rating:
        //     Rating(rate: map['rating']['rate'], count: map['rating']['count']),
        ratingRate: map["ratingRate"],
        ratingCount: map["ratingCount"],
        quantity: map['quantity'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        // "rating": rating?.toJson(),
        "ratingRate": ratingRate,
        "ratingCount": ratingCount,
        "quantity": quantity,
      };
}

class Rating {
  final num? rate;
  final int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}
