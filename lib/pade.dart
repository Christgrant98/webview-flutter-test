import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutterxwebview_flutterx/vimeoplayer.dart';

class DailySteppsPage extends StatelessWidget {
  DailySteppsPage({
    super.key,
  });

  final bool userSubscription = true;

  List<String> videos = [
    '915353629',
    '915353448',
    '915355066',
    '915354028',
    '915353336',
  ];

  @override
  Widget build(BuildContext context) {
    // Videos videos = Videos();
    return NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification &&
              scrollNotification.scrollDelta! > 0 &&
              scrollNotification.metrics.extentAfter == 0 &&
              userSubscription) {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pushNamed(context, '/daily_stepps/more_stepps');
            });
          }
          return false;
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .7,
          child: SingleChildScrollView(
              child: Column(children: [
            // Elementos antes del Carousel
            CarouselSlider.builder(
              itemCount: videos.length,
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * .6,
                  // enlargeCenterPage: true,
                  enlargeFactor: 0.2),
              itemBuilder: (context, index, realIndex) => Container(
                // clipBehavior: Clip.hardEdge,
                // width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16)),
                child: VimeoVideoPlayer(
                  videoId: videos[index],
                ),
              ),
            ),
          ])),
        ));
  }
}
