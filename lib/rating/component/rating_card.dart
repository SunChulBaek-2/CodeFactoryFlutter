import 'package:codefactory_flutter/common/const/colors.dart';
import 'package:codefactory_flutter/rating/model/rating_model.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class RatingCard extends StatelessWidget {
  const RatingCard({
    required this.avatarImage,
    required this.images,
    required this.rating,
    required this.email,
    required this.content,
    super.key
  });

  factory RatingCard.fromModel({
    required RatingModel model
  }) {
    return RatingCard(
      avatarImage: NetworkImage(model.user.imageUrl),
      images: model.imgUrls.map((e) => Image.network(e)).toList(),
      rating: model.rating,
      email: model.user.username,
      content: model.content
    );
  }

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
      _Body(content: content),
      if (images.length > 0)
        Padding(
          padding: const EdgeIn,
          child: SizedBox(
            height: 100,
            child: _Images(images: images)
          )
        ),
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
  const _Images({required this.images, super.key});

  final List<Image> images;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: images.mapIndexed((index, e) => Padding(
        padding: EdgeInsets.only(right: index == images.length - 1 ? 0 : 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: e
        ))).toList()
    );
  }
}