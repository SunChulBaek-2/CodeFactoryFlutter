import 'package:codefactory_flutter/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutter/common/utils/pagination_utils.dart';
import 'package:codefactory_flutter/restaurant/component/restaurant_card.dart';
import 'package:codefactory_flutter/restaurant/model/restaurant_model.dart';
import 'package:codefactory_flutter/restaurant/provider/restaurant_provider.dart';
import 'package:codefactory_flutter/restaurant/repository/restaurant_repository.dart';
import 'package:codefactory_flutter/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {

  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(scrollListener);
  }

  void scrollListener() {
    // 현재 위치가 최대 길이보다 조금 덜되는 위치까지 왔다면 추가 요청
    PaginationUtils.paginate(controller: controller, provider: ref.read(restaurantProvider.notifier));
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(restaurantProvider);
    // 완전 처음 로딩
    if (data is CursorPaginationLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    // 에러
    if (data is CursorPaginationError) {
      return Center(
        child: Text(data.message)
      );
    }

    // CursorPagination
    // CursorPaginationFetchingMore
    // CursorPaginationRefetching
    final cp = data as CursorPagination;
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.separated(
            controller: controller,
            itemCount: cp.data.length + 1,
            itemBuilder: (_, index) {
              if (index == cp.data.length) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                      child: data is CursorPaginationFetchingMore
                      ? const CircularProgressIndicator()
                      : const Text('마지막 데이터 입니다'))
                );
              }

              final item = cp.data.elementAt(index);
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