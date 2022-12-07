import 'package:codefactory_flutter/common/const/colors.dart';
import 'package:flutter/material.dart';

class RatingCard extends StatelessWidget {
  const RatingCard({
    required this.avatarImage,
    required this.images,
    required this.rating,
    required this.email,
    required this.content,
    super.key
  });

  final ImageProvider avatarImage;
  final List<Image> images;
  final int rating;
  final String email;
  final String content;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _Header(avatarImage: avatarImage, rating: rating, email: email),
      const SizedBox(height: 8),
      _Body(content: '맛있습니다.'),
      _Images(),
    ],
  );
}

class _Header extends StatelessWidget {
  const _Header({required this.avatarImage, required this.rating, required this.email, super.key});

  final ImageProvider avatarImage;
  final int rating;
  final String email;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      CircleAvatar(radius: 12, backgroundImage: avatarImage),
      const SizedBox(width: 8),
      Expanded(
        child: Text(email,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w500
          )
        )
      ),
      ...List.generate(5, (index) => Icon(
          index < rating ? Icons.star : Icons.star_border_outlined,
          color: PRIMARY_COLOR
      ))
    ],
  );
}

class _Body extends StatelessWidget {
  const _Body({required this.content, super.key});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            content,
            style: const TextStyle(
              color: BODY_TEXT_COLOR,
              fontSize: 14,
            )
          )
        )
      ]
    );
  }
}

class _Images extends StatelessWidget {
  const _Images({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}