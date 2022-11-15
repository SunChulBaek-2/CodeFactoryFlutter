import 'package:codefactory_flutter/common/layout/default_layout.dart';
import 'package:codefactory_flutter/product/component/product_card.dart';
import 'package:codefactory_flutter/restaurant/component/restaurant_card.dart';
import 'package:codefactory_flutter/restaurant/model/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key, required this.item});

  final RestaurantModel item;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: CustomScrollView(
        slivers: [
          renderTop(),
          renderLabel(),
          renderProducts()
        ],
      )
    );
  }

  SliverToBoxAdapter renderTop() {
    return SliverToBoxAdapter(
        child : RestaurantCard.fromModel(model: item, isDetail: true, detail: '맛있는 덖복이')
    );
  }

  SliverPadding renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text('메뉴', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18))
      )
    );
  }

  renderProducts() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 16),
              child: ProductCard()
            );
          },
          childCount: 10
        )
    )
    );
  }
}