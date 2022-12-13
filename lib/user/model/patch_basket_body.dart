import 'package:json_annotation/json_annotation.dart';

part 'patch_basket_body.g.dart';

@JsonSerializable()
class PatchBasketBody {
  PatchBasketBody({
    required this.basket,
  });

  final List<PatchBasketBodyBasket> basket;

  Map<String, dynamic> toJson() => _$PatchBasketBodyToJson(this);
}

@JsonSerializable()
class PatchBasketBodyBasket {
  PatchBasketBodyBasket({
    required this.productId,
    required this.count,
  });

  final String productId;
  final int count;

  factory PatchBasketBodyBasket.fromJson(Map<String, dynamic> json) => _$PatchBasketBodyBasketFromJson(json);

  Map<String, dynamic> toJson() => _$PatchBasketBodyBasketToJson(this);
}