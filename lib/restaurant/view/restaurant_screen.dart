import 'package:codefactory_flutter/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutter/restaurant/component/restaurant_card.dart';
import 'package:codefactory_flutter/restaurant/model/restaurant_model.dart';
import 'package:codefactory_flutter/restaurant/provider/restaurant_provider.dart';
import 'package:codefactory_flutter/restaurant/repository/restaurant_repository.dart';
import 'package:codefactory_flutter/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(restaurantProvider);
    if (data is CursorPaginationLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.separated(
            itemCount: data.length,
            itemBuilder: (_, index) {
              final item = data.elementAt(index);
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    RestaurantDetailScreen.routeName,
                    arguments: RestaurantDetailParam(
                      id: item.id,
                      item: item
                    )
                  );
                },
                child: RestaurantCard.fromModel(model: item)
              );
            },
            separatorBuilder: (_, index) {
              return SizedBox(height: 16);
            },
          )
        )
      )
    );
  }
}