import 'package:codefactory_flutter/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutter/restaurant/model/restaurant_detail_model.dart';
import 'package:codefactory_flutter/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl})
    = _RestaurantRepository;

  @GET('/restaurant')
  @Headers({ 'accessToken': 'true' })
  Future<CursorPagination<RestaurantModel>> paginate();

  @GET('/restaurant/{id}')
  @Headers({ 'accessToken': 'true' })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path('id') required String id
  });
}