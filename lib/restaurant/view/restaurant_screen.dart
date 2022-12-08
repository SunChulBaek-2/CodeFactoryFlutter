import 'package:codefactory_flutter/common/component/pagination_list_view.dart';
import 'package:codefactory_flutter/restaurant/component/restaurant_card.dart';
import 'package:codefactory_flutter/restaurant/provider/restaurant_provider.dart';
import 'package:codefactory_flutter/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      provider: restaurantProvider,
      itemBuilder: <RestaurantModel>(context, index, model) => GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            RestaurantDetailScreen.routeName,
            arguments: RestaurantDetailParam(
              id: model.id,
              item: model
            )
          );
        },
        child: RestaurantCard.fromModel(model: model)
      )
    );
  }
}