import 'package:codefactory_flutter/common/const/data.dart';
import 'package:codefactory_flutter/common/dio/dio.dart';
import 'package:codefactory_flutter/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutter/common/model/pagination_params.dart';
import 'package:codefactory_flutter/rating/model/rating_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

part 'restaurant_rating_repository.g.dart';

final restaurantRatingRepositoryProvider = Provider.family<RestaurantRatingRepository, String>((ref, id) {
  final dio = ref.watch(dioProvider);
  return RestaurantRatingRepository(dio, baseUrl: 'http://$ip/restaurant/$id/rating');
});

@RestApi()
abstract class RestaurantRatingRepository {
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) =
    _RestaurantRatingRepository;

  @GET('/')
  @Headers({'accessToken':'true'})
  Future<CursorPagination<RatingModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}