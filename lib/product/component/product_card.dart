import 'package:codefactory_flutter/common/const/colors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
                'asset/img/food/ddeok_bok_gi.jpg',
                width: 110,
                height: 110,
                fit: BoxFit.cover
            )
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('떡볶이', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
                Text('전통 떡볶이의 정식\n맛있습니다.', style: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14)),
                Text('10000', maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.right, style: TextStyle(color: PRIMARY_COLOR, fontSize: 12))
              ],
            )
          )
        ],
      )
    );
  }

}