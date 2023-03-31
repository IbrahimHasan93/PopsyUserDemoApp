import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Details extends StatelessWidget {
  final String image;
  final String fullName;
  final String email;
  final int index;
  const Details(
      {super.key,
      required this.image,
      required this.fullName,
      required this.index,
      required this.email});

  @override
  Widget build(BuildContext context) {
    List<String> details = [
      '$fullName is a busy working professional who values convenience and efficiency. She has a fast-paced job that requires her to juggle multiple tasks at once, so she often relies on technology to help her stay organized and productive. Jane likes apps and tools that are user-friendly and intuitive, and that allow her to access information and complete tasks quickly and easily. She values quality customer support and likes to have access to help when she needs it.',
      '$fullName  is a tech-savvy college student who enjoys exploring new technologies and experimenting with different gadgets and tools. He spends a lot of time on his computer and smartphone, and likes to use apps and websites that are customizable and offer advanced features. Mark is interested in the latest trends in technology and likes to stay up-to-date with the latest developments. He values performance and speed, and is willing to invest time and effort into learning new software and programming languages.'
    ];
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            foregroundDecoration: const BoxDecoration(
              gradient: LinearGradient(
                // Where the linear gradient begins and ends
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                // Add one stop for each color. Stops should increase from 0 to 1
                stops: [0.0, 1],
                colors: [
                  // Colors are easy thanks to Flutter's Colors class.
                  Colors.black26,
                  Colors.black,
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon:
                            const Icon(Icons.arrow_back, color: Colors.white)),
                    Expanded(
                      child: Transform.translate(
                        offset: const Offset(-20, 0),
                        child: Center(
                          child: Hero(
                            tag: image,
                            child: CircleAvatar(
                              radius: 100,
                              backgroundImage: NetworkImage(image),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 100),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Column(
                          children: [
                            Text(
                              fullName,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                email,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    index.isEven ? details[0] : details[1],
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 28.0, top: 20),
                  child: Text(
                    'Active member since 2018',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
