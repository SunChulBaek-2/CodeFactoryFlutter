import 'package:codefactory_flutter/common/const/colors.dart';
import 'package:codefactory_flutter/common/layout/default_layout.dart';
import 'package:codefactory_flutter/common/view/root_tab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderDoneScreen extends StatelessWidget {
  static String get routeName => '/orderDone';

  const OrderDoneScreen({super.key});

  @override
  Widget build(BuildContext context) => DefaultLayout(
    child: Padding(
      padding:const EdgeInsets.symmetric(horizontal: 16),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.thumb_up_alt_outlined, color: PRIMARY_COLOR, size: 50),
          const SizedBox(height: 32),
          const Text('결제가 완료되었습니다.', textAlign: TextAlign.center),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              context.goNamed(RootTab.routeName);
            },
            style: ElevatedButton.styleFrom(
              primary: PRIMARY_COLOR,
            ),
            child: Text('홈으로')
          ),
        ],
      )
    )
  );
}