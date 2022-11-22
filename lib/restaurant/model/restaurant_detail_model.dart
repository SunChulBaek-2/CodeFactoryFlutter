import 'package:codefactory_flutter/common/const/data.dart';
import 'package:codefactory_flutter/restaurant/model/restaurant_model.dart';

class RestaurantDetailModel extends RestaurantModel {
  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryFee,
    required super.deliveryTime,
    required this.detail,
    required this.products,
  });

  final String detail;
  final List<RestaurantProductModel> products;

  factory RestaurantDetailModel.fromJson({required Map<String, dynamic> json}) {
    return RestaurantDetailModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: json['thumbUrl'],
      tags: List<String>.from(json['tags']),
      priceRange: RestaurantPriceRange.values.firstWhere(
          (e) => e.name == json['priceRange']
      ),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryFee: json['deliveryFee'],
      deliveryTime: json['deliveryTime'],
      detail: json['detail'],
      products: json['products'].map<RestaurantProductModel>((e) =>
      RestaurantProductModel(
        id: e['id'],
        name: e['name'],
        imgUrl: e['imgUrl'],
        detail: e['detail'],
        price: e['price'],
      )
      ).toList(),
    );
  }
}

class RestaurantProductModel {
  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price
  });

  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;
}