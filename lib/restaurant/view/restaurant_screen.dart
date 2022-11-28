import 'package:codefactory_flutter/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutter/restaurant/component/restaurant_card.dart';
import 'package:codefactory_flutter/restaurant/model/restaurant_model.dart';
import 'package:codefactory_flutter/restaurant/repository/restaurant_repository.dart';
import 'package:codefactory_flutter/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder<CursorPagination<RestaurantModel>>(
            future: ref.watch(restaurantRepositoryProvider).paginate(),
            builder: (context, AsyncSnapshot<CursorPagination<RestaurantModel>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator()
                );
              }

              return ListView.separated(
                itemCount: snapshot.data!.data.length,
                itemBuilder: (_, index) {
                  final item = snapshot.data!.data.elementAt(index);
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
              );
            },
          )
        )
      )
    );
  }

}