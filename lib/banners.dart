import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:masjiduserapp/util/constant.dart';

import 'masjit_user_app_api/masjit_app_responce_model/banner_response_model.dart';

class Banners extends StatefulWidget {
  const Banners({Key? key}) : super(key: key);

  @override
  State<Banners> createState() => _BannersState();
}

class _BannersState extends State<Banners> with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder<BannerImage>(
            future: getBannerImage(),
            builder: (context, snap) {
              if (!snap.hasData && !snap.hasError) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final data = snap.data;

              if (data == null) {
                return const Center(
                  child: Text('Error'),
                );
              }

              List<String> images = data.data!;

              return Column(
                children: [
                  CarouselSlider.builder(
                      itemCount: images.length,
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        initialPage: 1,
                        height: MediaQuery.of(context).size.height * .27,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        autoPlay: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                      ),
                      itemBuilder:
                          (BuildContext context, int itemIndex, int index1) {
                        final img = images[index1].isNotEmpty
                            ? NetworkImage(
                                "http://admin.azan4salah.com${images[index1]}",
                              )
                            : const NetworkImage("");

                        return Container(
                            margin: const EdgeInsets.all(16),
                            height: MediaQuery.of(context).size.height * 0.17,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                                BoxShadow(
                                  color: Colors.grey.shade50,
                                  offset: const Offset(-3, 0),
                                ),
                                BoxShadow(
                                  color: Colors.grey.shade50,
                                  offset: const Offset(1, 0),
                                )
                              ],
                            ),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: img,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ));
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int i = 0; i < images.length; i++)
                        Container(
                          width: 7,
                          height: 7,
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: currentIndex == i
                                ? Colors.green
                                : Colors.grey.shade400,
                            shape: BoxShape.circle,
                          ),
                        )
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

Future<BannerImage> getBannerImage() async {
  final box = Hive.box(kBoxName);
  var headersList = {'Authorization': 'Bearer ${box.get(kToken)}'};
  var response = await http.get(
      Uri.parse('http://admin.azan4salah.com/api/user/banners'),
      headers: headersList);
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);

    return bannerImageFromJson(response.body);
  } else {
    throw Exception('Failed to create album.');
  }
}
