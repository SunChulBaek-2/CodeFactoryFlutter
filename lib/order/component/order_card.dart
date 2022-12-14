import 'package:codefactory_flutter/common/const/colors.dart';
import 'package:codefactory_flutter/order/model/order_model.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    required this.orderDate,
    required this.image,
    required this.name,
    required this.productsDetail,
    required this.price,
    Key? key,
  }) : super(key: key);

  factory OrderCard.fromModel({
    required OrderModel model
  }) {
    final productsDetail = model.products.length < 2
      ? model.products.first.product.name
      : '${model.products.first.product.name} 외 ${model.products.length - 1}개';
    return OrderCard(
    orderDate: model.createdAt,
    image: Image.network(model.restaurant.thumbUrl, height: 50, width: 50, fit: BoxFit.cover),
    name: model.restaurant.name,
    productsDetail: productsDetail,
    price: model.totalPrice,
  );
  }

  final DateTime orderDate;
  final Image image;
  final String name;
  final String productsDetail;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${orderDate.year}.${orderDate.month.toString().padLeft(2, '0')}.${orderDate.day.toString().padLeft(2, '0')} 주문완료'),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: image,
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                Text(name, style: const TextStyle(fontSize: 14)),
                Text('$productsDetail $price원', style: TextStyle(color: BODY_TEXT_COLOR, fontWeight: FontWeight.w300),)
              ],
            )
          ],
        )
      ],
    );
  }
}