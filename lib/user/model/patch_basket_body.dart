import 'package:json_annotation/json_annotation.dart';

part 'patch_basket_body.g.dart';

@JsonSerializable()
class PatchBasketBody {
  PatchBasketBody({
    required this.productId,
    required this.count,
  });

  final String productId;
  final int count;

  Map<String, dynamic> toJson() => _$PatchBasketBodyToJson(this);
}