import 'package:codefactory_flutter/common/layout/default_layout.dart';
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
      child: Column(
        children: [
          RestaurantCard.fromModel(model: item, isDetail: true, detail: '맛있는 덖복이')
        ],
      )
    );
  }
}