import 'package:codefactory_flutter/common/const/colors.dart';
import 'package:codefactory_flutter/common/const/data.dart';
import 'package:codefactory_flutter/product/model/product_model.dart';
import 'package:codefactory_flutter/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
    Key? key
  }) : super(key: key);

  final Image image;
  final String name;
  final String detail;
  final int price;

  factory ProductCard.fromProductModel({
    required ProductModel model,
  }) => ProductCard(
      image: Image.network(
          model.imgUrl,
          width: 110,
          height: 110,
          fit: BoxFit.cover
      ),
      name: model.name,
      detail: model.detail,
      price: model.price
  );

  factory ProductCard.fromRestaurantProductModel({
    required RestaurantProductModel model
  }) => ProductCard(
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover
      ),
      name: model.name,
      detail: model.detail,
      price: model.price
  );

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: image
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
                Text(detail, style: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14)),
                Text(price.toString(), maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.right, style: TextStyle(color: PRIMARY_COLOR, fontSize: 12))
              ],
            )
          )
        ],
      )
    );
  }

}