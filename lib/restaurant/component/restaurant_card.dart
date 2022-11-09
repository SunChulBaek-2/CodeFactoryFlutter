import 'package:codefactory_flutter/common/const/colors.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  // 이미지
  final Widget image;
  // 레스토랑 이름
  final String name;
  // 레스토랑 태그
  final List<String> tags;
  // 평점 갯수
  final int ratingCount;
  // 배송걸리는 시간
  final int deliveryTime;
  // 배송 비용
  final int deliveryFee;
  // 평균 평점
  final double rating;

  const RestaurantCard({
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.rating,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: image
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Text(tags.join(' · '), style: const TextStyle(color: BODY_TEXT_COLOR, fontSize: 14)),
            Row(
              children: [
                _IconText(icon: Icons.star, label: rating.toString()),
                renderDot(),
                _IconText(icon: Icons.receipt, label: ratingCount.toString()),
                renderDot(),
                _IconText(icon: Icons.timelapse_outlined, label: '$deliveryTime분'),
                renderDot(),
                _IconText(icon: Icons.monetization_on, label: deliveryFee == 0 ? '무료' : deliveryFee.toString()),
              ],
            )
          ],
        )
      ],
    );
  }

  renderDot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        '·',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500
        )
      )
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({required this.icon, required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: PRIMARY_COLOR, size: 14),
        const SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
      ],
    );
  }


}