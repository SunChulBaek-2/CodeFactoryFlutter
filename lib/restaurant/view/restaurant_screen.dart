import 'package:codefactory_flutter/common/const/data.dart';
import 'package:codefactory_flutter/restaurant/component/restaurant_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../main.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginateRestaurant() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    print('restaurant accessToken = $accessToken');
    final resp = await dio.get('http://$ip/restaurant',
      options: Options(
        headers: {
          'authorization' : 'Bearer $accessToken,'
        }
      )
    );
    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder<List>(
            future: paginateRestaurant(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  final item = snapshot.data!.elementAt(index);
                  return RestaurantCard(
                    image: Image.network('http://${ip}${item['thumbUrl']}', fit: BoxFit.cover),
                    name: item['name'],
                    tags: List<String>.from(item['tags']),
                    ratingsCount: item['ratingsCount'],
                    deliveryTime: item['deliveryTime'],
                    deliveryFee: item['deliveryFee'],
                    ratings: item['ratings'],
                  );
                },
                separatorBuilder: (_, index) {
                  return SizedBox(height: 16);
                },
              );
            },
          )
        )
      )
    );
  }

}