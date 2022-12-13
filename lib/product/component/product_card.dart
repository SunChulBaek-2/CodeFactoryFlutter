import 'package:codefactory_flutter/common/const/colors.dart';
import 'package:codefactory_flutter/common/const/data.dart';
import 'package:codefactory_flutter/product/model/product_model.dart';
import 'package:codefactory_flutter/restaurant/model/restaurant_detail_model.dart';
import 'package:codefactory_flutter/user/provider/basket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
    required this.id,
    this.onSubtract,
    this.onAdd,
    Key? key
  }) : super(key: key);

  final Image image;
  final String name;
  final String detail;
  final int price;
  final String id;
  final VoidCallback? onSubtract;
  final VoidCallback? onAdd;

  factory ProductCard.fromProductModel({
    required ProductModel model,
    VoidCallback? onSubtract,
    VoidCallback? onAdd,
  }) => ProductCard(
      image: Image.network(
          model.imgUrl,
          width: 110,
          height: 110,
          fit: BoxFit.cover
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
      id: model.id,
      onSubtract: onSubtract,
      onAdd: onAdd,
  );

  factory ProductCard.fromRestaurantProductModel({
    required RestaurantProductModel model,
    VoidCallback? onSubtract,
    VoidCallback? onAdd,
  }) => ProductCard(
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
      id: model.id,
      onSubtract: onSubtract,
      onAdd: onAdd,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);
    return Column(
      children:[
        IntrinsicHeight(
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
        ),
        if (onSubtract != null && onAdd != null)
          _Footer(
            total: (basket.firstWhere((e) => e.product.id == id).count * basket.firstWhere((e) => e.product.id == id).product.price).toString(),
            count: basket.firstWhere((e) => e.product.id == id).count,
            onSubtract: onSubtract!,
            onAdd: onAdd!
          )
      ]
    );
  }

}

class _Footer extends StatelessWidget {
  const _Footer({
    required this.total,
    required this.count,
    required this.onSubtract,
    required this.onAdd,
    Key? key,
  }) : super(key: key);

  final String total;
  final int count;
  final VoidCallback onSubtract;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          '총액 $total원',
          style: const TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w500
          )
        )
      ),
      Row(
        children: [
          renderButton(icon: Icons.remove, onTap:onSubtract),
          Text(
            count.toString(),
            style: const TextStyle(
                color: PRIMARY_COLOR,
                fontWeight: FontWeight.w500
            )
          ),
          renderButton(icon: Icons.add, onTap: onAdd)
        ],
      )
    ],
  );

  Widget renderButton({
    required IconData icon,
    required VoidCallback onTap,
  }) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: PRIMARY_COLOR,
        width: 1,
      )
    ),
    child:InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        color: PRIMARY_COLOR,
      )
    )
  );
}