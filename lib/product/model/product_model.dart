import 'package:codefactory_flutter/common/model/model_with_id.dart';
import 'package:codefactory_flutter/common/utils/data_utils.dart';
import 'package:codefactory_flutter/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel implements IModelWithId {
  ProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
    required this.restaurant,
  });

  final String id;
  final String name;
  final String detail;
  @JsonKey(fromJson: DataUtils.pathToUrl) final String imgUrl;
  final int price;
  final RestaurantModel restaurant;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
    _$ProductModelFromJson(json);
}