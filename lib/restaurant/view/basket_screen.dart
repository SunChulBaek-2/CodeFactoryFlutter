import 'package:codefactory_flutter/common/const/colors.dart';
import 'package:codefactory_flutter/common/layout/default_layout.dart';
import 'package:codefactory_flutter/order/provider/order_provider.dart';
import 'package:codefactory_flutter/order/view/order_done_screen.dart';
import 'package:codefactory_flutter/product/component/product_card.dart';
import 'package:codefactory_flutter/user/provider/basket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BasketScreen extends ConsumerWidget {
  static String get routeName => 'basket';

  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);
    final productsTotal = basket.fold(0, (p, n) => p + n.product.price * n.count);
    final deliveryFee = basket.isNotEmpty ? basket.first.product.restaurant.deliveryFee : 0;

    if (basket.isEmpty) {
      return const DefaultLayout(
        child: Center(
          child: Text('장바구니가 비어있네요')
        )
      );
    }

    return DefaultLayout(
      title: '장바구니',
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, index) {
                    return const Divider(height: 32);
                  },
                  itemBuilder: (_, index) {
                    final model = basket[index];
                    return ProductCard.fromProductModel(
                      model: model.product,
                      onSubtract: () {
                        ref.read(basketProvider.notifier).removeFromBasket(product: model.product);
                      },
                      onAdd: () {
                        ref.read(basketProvider.notifier).addToBasket(product: model.product);
                      }
                    );
                  },
                itemCount: basket.length
                )
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('장바구니 금액', style: TextStyle(color: BODY_TEXT_COLOR)),
                      Text('$productsTotal원')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('배달비', style: TextStyle(color: BODY_TEXT_COLOR)),
                      if (basket.isNotEmpty)
                        Text('$deliveryFee원')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('총액', style: TextStyle(fontWeight: FontWeight.w500)),
                      Text('${productsTotal + deliveryFee}원')
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final resp = await ref.read(orderProvider.notifier).postOrder();
                        if (resp) {
                          context.goNamed(OrderDoneScreen.routeName);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('결제 실패')));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: PRIMARY_COLOR
                      ),
                      child: const Text('결제하기')
                    )
                  )
                ]
              )
            ],
        ))
    ));
  }
}