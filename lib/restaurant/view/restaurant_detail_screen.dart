import 'package:codefactory_flutter/common/const/data.dart';
import 'package:codefactory_flutter/common/layout/default_layout.dart';
import 'package:codefactory_flutter/main.dart';
import 'package:codefactory_flutter/product/component/product_card.dart';
import 'package:codefactory_flutter/restaurant/component/restaurant_card.dart';
import 'package:codefactory_flutter/restaurant/model/restaurant_detail_model.dart';
import 'package:codefactory_flutter/restaurant/model/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key, required this.id, required this.item});

  final String id;
  final RestaurantModel item;

  Future<Map<String, dynamic>> getRestaurantDetail() async {
    final resp = await dio.get("http://$ip/restaurant/$id");
    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: FutureBuilder<Map<String, dynamic>>(
        future: getRestaurantDetail(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final item = RestaurantDetailModel.fromJson(snapshot.data!);
          
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