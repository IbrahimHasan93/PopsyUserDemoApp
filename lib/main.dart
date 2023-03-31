import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popsy_second_app/core/controllers/user_controller.dart';
import 'package:popsy_second_app/details.dart';

import 'core/dependency/dependency_controllers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ControllersDependencies().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Users',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int page = 1;

  @override
  void initState() {
    Get.find<UserController>().login(page.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // backgroundColor: Colors.black54,
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: GetBuilder<UserController>(builder: (userController) {
        return Stack(
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
            (userController.userData ?? []).isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: userController.isLoading
                          ? [
                              const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ]
                          : [
                              const SizedBox(
                                height: 60,
                              ),
                              const Text(
                                'Our Fantastic Staff',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              GridView.count(
                                crossAxisCount: 2,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(20),
                                mainAxisSpacing: 10,
                                shrinkWrap: true,
                                childAspectRatio: .9,
                                children: [
                                  ...userController.userData!
                                      .map((e) => GestureDetector(
                                            onTap: () {
                                              Get.to(() => Details(
                                                    image: e.avatar!,
                                                    email: e.email!,
                                                    index: e.id!,
                                                    fullName:
                                                        '${e.firstName} ${e.lastName}',
                                                  ));
                                            },
                                            child: Column(
                                              children: [
                                                Hero(
                                                  tag: e.avatar!,
                                                  child: CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage:
                                                        NetworkImage(e.avatar!),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Text(
                                                    e.firstName!,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ))
                                      .toList()
                                ],
                              ),
                              !userController.noMoreData
                                  ? TextButton(
                                      onPressed: () {
                                        page++;
                                        userController.login(page.toString());
                                      },
                                      child: const Text('Load More Users'))
                                  : const SizedBox.shrink(),
                              (userController.userData ?? []).isNotEmpty
                                  ? const SizedBox(
                                      height: 30,
                                    )
                                  : const SizedBox.shrink()
                            ],
                    ),
                  )
                : const SizedBox(),
          ],
        );
      }),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
