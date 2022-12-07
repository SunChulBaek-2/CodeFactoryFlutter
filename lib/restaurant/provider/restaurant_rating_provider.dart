import 'package:codefactory_flutter/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutter/restaurant/repository/restaurant_rating_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantRatingStateNotifier extends StateNotifier<CursorPaginationBase> {
  RestaurantRatingStateNotifier({
    required this.repository,
  }) : super(CursorPaginationLoading());

  final RestaurantRatingRepository repository;
}