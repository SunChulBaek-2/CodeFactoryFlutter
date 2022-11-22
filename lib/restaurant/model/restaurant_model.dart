import 'package:codefactory_flutter/common/const/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap
}

@JsonSerializable()
class RestaurantModel {
  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryFee,
    required this.deliveryTime
  });

  final String id;
  final String name;
  @JsonKey(fromJson: pathToUrl) final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  factory RestaurantModel.fromJson(Map<String, dynamic> json)
    => _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  static String pathToUrl(String value) => 'http://$ip$value';
}