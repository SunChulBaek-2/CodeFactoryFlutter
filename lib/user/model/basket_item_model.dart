import 'package:codefactory_flutter/product/model/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'basket_item_model.g.dart';

@JsonSerializable()
class BasketItemModel {
  BasketItemModel({
    required this.product,
    required this.count
  });

  final ProductModel product;
  final int count;

  factory BasketItemModel.fromJson(Map<String, dynamic> json) => _$BasketItemModelFromJson(json);

  BasketItemModel copyWith({
    ProductModel? product,
    int? count
  }) => BasketItemModel(
    product: product ?? this.product,
    count: count ?? this.count,
  );
}