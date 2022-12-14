import 'package:codefactory_flutter/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutter/common/provider/pagination_provider.dart';
import 'package:codefactory_flutter/order/model/order_model.dart';
import 'package:codefactory_flutter/order/model/post_order_body.dart';
import 'package:codefactory_flutter/order/repository/order_repository.dart';
import 'package:codefactory_flutter/user/provider/basket_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final orderProvider = StateNotifierProvider<OrderStateNotifier, CursorPaginationBase>((ref) {
  final repo = ref.watch(orderRepositoryProvider);
  return OrderStateNotifier(ref: ref, repository: repo);
});

class OrderStateNotifier extends PaginationProvider<OrderModel, OrderRepository> {
  OrderStateNotifier({
    required this.ref,
    required super.repository,
  });

  final Ref ref;

  Future<bool> postOrder() async {
    try {
      final uuid = Uuid();
      final id = uuid.v4();
      final state = ref.read(basketProvider);

      await repository.postOrder(body: PostOrderBody(
          id: id,
          products: state.map((e) =>
              PostOrderBodyProduct(
                  productId: e.product.id,
                  count: e.count
              )).toList(),
          totalPrice: state.fold(0, (p, n) => p + (n.count * n.product.price)),
          createAt: DateTime.now().toString()
      ));
      return true;
    } catch (e, stack) {
      print(e);
      print(stack);
      return false;
    }
  }
}