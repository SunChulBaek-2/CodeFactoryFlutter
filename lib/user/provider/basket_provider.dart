import 'package:codefactory_flutter/product/model/product_model.dart';
import 'package:codefactory_flutter/user/model/basket_item_model.dart';
import 'package:codefactory_flutter/user/model/patch_basket_body.dart';
import 'package:codefactory_flutter/user/provider/user_me_provider.dart';
import 'package:codefactory_flutter/user/repository/user_me_repository.dart';
import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final basketProvider = StateNotifierProvider<BasketProvider, List<BasketItemModel>>(
  (ref) {
    final repository = ref.watch(userMeRepositoryProvider);
    return BasketProvider(repository: repository);
  }
);

class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  BasketProvider({
    required this.repository,
  }): super([]) {
    updateBasketDebounce.values.listen((event) {
      patchBasket();
    });
  }

  final UserMeRepository repository;
  final updateBasketDebounce = Debouncer(
    const Duration(seconds: 1),
    initialValue: null,
    checkEquality: false,
  );

  Future<void> patchBasket() async {
    await repository.patchBasket(body: PatchBasketBody(basket: state.map((e) =>
      PatchBasketBodyBasket(productId: e.product.id, count: e.count)
    ).toList()));
  }

  Future<void> addToBasket({
    required ProductModel product,
  }) async {
    final exists = state.firstWhereOrNull((element) => element.product.id == product.id) != null;
    if (exists) {
      state = state.map((e) => e.product.id == product.id ? e.copyWith(count: e.count + 1) : e).toList();
    } else {
      state = [
        ...state,
        BasketItemModel(product: product, count: 1),
      ];
    }
    updateBasketDebounce.setValue(null);
  }

  Future<void> removeFromBasket({
    required ProductModel product,
    bool isDelete = false,
  }) async {
    final exists = state.firstWhereOrNull((element) => element.product.id == product.id) != null;

    if (!exists) {
      return;
    }

    final existingProduct = state.firstWhere((element) => element.product.id == product.id);
    if (existingProduct.count == 1) {
      state = state.where((element) => element.product.id != product.id).toList();
    } else {
      state = state.map((e) => e.product.id == product.id
      ? e.copyWith(count: e.count - 1) : e).toList();
    }
    updateBasketDebounce.setValue(null);
  }
}