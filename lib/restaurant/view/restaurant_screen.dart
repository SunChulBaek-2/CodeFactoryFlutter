import 'package:codefactory_flutter/common/const/data.dart';
import 'package:codefactory_flutter/common/dio/dio.dart';
import 'package:codefactory_flutter/restaurant/component/restaurant_card.dart';
import 'package:codefactory_flutter/restaurant/model/restaurant_model.dart';
import 'package:codefactory_flutter/restaurant/repository/restaurant_repository.dart';
import 'package:codefactory_flutter/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> paginateRestaurant(WidgetRef ref) async {
    final dio = ref.watch(dioProvider);
    final resp = await RestaurantRepository(dio, baseUrl: 'http://$ip').paginate();
    return resp.data;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder<List<RestaurantModel>>(
            future: paginateRestaurant(ref),
            builder: (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator()
                );
              }

              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  final item = snapshot.data!.elementAt(index);
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