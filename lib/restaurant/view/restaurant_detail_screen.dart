import 'package:codefactory_flutter/common/layout/default_layout.dart';
import 'package:codefactory_flutter/product/component/product_card.dart';
import 'package:codefactory_flutter/restaurant/component/restaurant_card.dart';
import 'package:codefactory_flutter/restaurant/model/restaurant_detail_model.dart';
import 'package:codefactory_flutter/restaurant/model/restaurant_model.dart';
import 'package:codefactory_flutter/restaurant/provider/restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantDetailParam {
  RestaurantDetailParam({required this.id, required this.item});

  final String id;
  final RestaurantModel item;
}

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  static const routeName = "/restaurantDetail";

  const RestaurantDetailScreen({super.key, required this.param});

  final RestaurantDetailParam param;

  @override
  ConsumerState<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends ConsumerState<RestaurantDetailScreen> {

  @override
  void initState() {
    super.initState();
    ref.read(restaurantProvider.notifier).getDetail(id: widget.param.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.param.id));
    if (state == null) {
      return DefaultLayout(child: Center(child: CircularProgressIndicator()));
    }
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: CustomScrollView(
        slivers: [
          renderTop(model: state),
          if (state is RestaurantDetailModel)
            renderLabel(),
          if (state is RestaurantDetailModel)
            renderProducts(products: state.products)
        ],
      )
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantModel model
  }) {
    return SliverToBoxAdapter(
        child : RestaurantCard.fromModel(model: model, isDetail: true)
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