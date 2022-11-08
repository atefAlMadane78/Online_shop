import 'package:ecom/model/cacheHelper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import './Login_screen.dart';

class BoardingModel {
  final String image;
  final String title, body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class onBoarding_screen extends StatefulWidget {
  onBoarding_screen({Key? key}) : super(key: key);

  @override
  State<onBoarding_screen> createState() => _onBoarding_screenState();
}

class _onBoarding_screenState extends State<onBoarding_screen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/father and son.jfif',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body'),
    BoardingModel(
        image: 'assets/images/onboard2.jfif',
        title: 'On Board 2 Title',
        body: 'On Board 2 Body'),
    BoardingModel(
        image: 'assets/images/onboard3.jfif',
        title: 'On Board 3 Title',
        body: 'On Board 3 Body'),
  ];

  bool islast = false;

  void submit() {
    cacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login_screen()));
      }
    });
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: submit,
              // () {
              //   Navigator.pushReplacement(context,
              //       MaterialPageRoute(builder: (context) => Login_screen()));
              // },
              child: const Text('SKIP'),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics:
                      const BouncingScrollPhysics(), // turn the color that show when arrive to final or first image to free space
                  controller: boardController,
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        islast = true;
                      });
                    } else {
                      setState(() {
                        islast = false;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Color(0xFF32ccbc),
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 5.0,
                        expansionFactor:
                            4 // the recatngle that show on screen show now
                        ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                      onPressed: () {
                        if (islast) {
                          submit();
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Login_screen()));
                        } else {
                          boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }
                      },
                      child: const Icon(Icons.arrow_forward_ios_outlined))
                ],
              )
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
              //width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            model.title,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            model.body,
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
        ],
      );
}
