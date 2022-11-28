import 'package:codefactory_flutter/common/layout/default_layout.dart';
import 'package:codefactory_flutter/product/component/product_card.dart';
import 'package:codefactory_flutter/restaurant/component/restaurant_card.dart';
import 'package:codefactory_flutter/restaurant/model/restaurant_detail_model.dart';
import 'package:codefactory_flutter/restaurant/model/restaurant_model.dart';
import 'package:codefactory_flutter/restaurant/repository/restaurant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantDetailParam {
  RestaurantDetailParam({required this.id, required this.item});

  final String id;
  final RestaurantModel item;
}

class RestaurantDetailScreen extends ConsumerWidget {
  static const routeName = "/restaurantDetail";

  const RestaurantDetailScreen({super.key, required this.param});

  final RestaurantDetailParam param;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: FutureBuilder<RestaurantDetailModel>(
        future: ref.watch(restaurantRepositoryProvider).getRestaurantDetail(id: param.id),
        builder: (context, AsyncSnapshot<RestaurantDetailModel> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final item = snapshot.data!;
          
          return CustomScrollView(
            slivers: [
              renderTop(model: item),
              renderLabel(),
              renderProducts(products: item.products)
            ],
          );
        }
      )
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantDetailModel model
  }) {
    return SliverToBoxAdapter(
        child : RestaurantCard.fromModel(model: model)
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

  renderProducts({required List<RestaurantProductModel> products}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = products[index];
            return Padding(
              padding: EdgeInsets.only(top: 16),
              child: ProductCard.fromModel(model: model)
            );
          },
          childCount: products.length
        )
    )
    );
  }
}