import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SliderBannerHome extends StatelessWidget {
  final List<String> bannerImages; // List of banner image URLs
  // final CarouselController _carouselController = CarouselController();

  SliderBannerHome({
    Key? key,
    required this.bannerImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (bannerImages.isEmpty) {
      return SizedBox(); // Return empty if no banners are available
    }

    return SizedBox(
      width: double.infinity,
      height: 240.w,
      child: CarouselSlider.builder(
        itemCount: bannerImages.length,
        itemBuilder: (context, index, realIndex) {
          return Padding(
            padding: EdgeInsets.all(15.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.w),
              child: Image.asset(
                bannerImages[index], // Load from assets
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          viewportFraction: 0.94,
          height: MediaQuery.of(context).size.width > 600 ? 500.w : 600.w,
          onPageChanged: (index, reason) {
          },
        ),
      ),
    );
  }
}
