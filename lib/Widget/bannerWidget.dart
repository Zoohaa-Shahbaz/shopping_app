import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/Controllers/bannerController.dart';

class BannerWiget extends StatefulWidget {
  const BannerWiget({super.key});

  @override
  State<BannerWiget> createState() => _BannerWigetState();
}

class _BannerWigetState extends State<BannerWiget> {
  @override

  final CarouselController carouselController = CarouselController();

  final  bannerController _bannerContoller = Get.put(bannerController());

  Widget build(BuildContext context) {

    return Container(
      child: Obx(() {
        return CarouselSlider(items: _bannerContoller.bannerUrls.map((element) => ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: CachedNetworkImage(imageUrl: element,fit: BoxFit.cover,
          ),
        ),).toList(), options: CarouselOptions(
          scrollDirection: Axis.horizontal,
          autoPlay: true,


        ));
      },),
    );
  }
}


