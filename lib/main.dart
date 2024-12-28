import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:resume/about_page.dart';
import 'package:resume/common/colors.dart';
import 'package:resume/common/fadein_widget.dart';
import 'package:resume/constants.dart';
import 'package:resume/controller.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(textTheme: const TextTheme()),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });

  HomeController homeController = Get.put(HomeController());
  final List<String> _tabs = [
    'Home',
    'About',
    'Resume',
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          floatingActionButton:
              TapBarWidget(tabs: _tabs, homeController: homeController),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 80),
                    homeController.selectedIndex.value == "1"
                        ? const AboutPage()
                        : const HomeWidget(),
                  ],
                ),

                ///////////////////////////footer/////////////////////////
                const FooterWidget(),
              ],
            ),
          )),
    );
  }
}

class TapBarWidget extends StatelessWidget {
  const TapBarWidget({
    super.key,
    required List<String> tabs,
    required this.homeController,
  }) : _tabs = tabs;

  final List<String> _tabs;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_tabs.length, (index) {
            return GestureDetector(
              onTap: () {
                homeController.selectedIndex.value = index.toString();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color:
                          homeController.selectedIndex.value == index.toString()
                              ? ThemeColors.secondary
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _tabs[index],
                      style: TextStyle(
                        color: homeController.selectedIndex.value ==
                                index.toString()
                            ? Colors.white
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ////////////////////////////hello /////////////////////
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Hello!",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: RotatedBox(
                quarterTurns: 2,
                child: Image.asset(
                  "assets/images/Vector 1.png",
                  height: 30,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        ////////////////////////////main ///////////////////////////

        Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset(
                "assets/images/Vector 1.png",
                height: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Text.rich(
                    TextSpan(
                      text: "I'm ",
                      style: GoogleFonts.urbanist(
                        fontSize: 90,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text: "Shahil",
                            style: GoogleFonts.urbanist(
                              color: ThemeColors.secondary,
                              fontSize: 90,
                              fontWeight: FontWeight.bold,
                            )),
                        // TextSpan(
                        //     text: ",\nFlutter Developer",
                        //     style: GoogleFonts.urbanist(
                        //       color: Colors.black,
                        //       fontSize: 90,
                        //       fontWeight: FontWeight.bold,
                        //     )),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  TypeTextWidget(
                    text: "Flutter Developer ",
                    textStyle: GoogleFonts.urbanist(
                      color: Colors.black,
                      fontSize: 90,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Description / Testimonial
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shahil’s exceptional flutter developing skills\nensures our flutter app's success.\n Let's discuss what is our next project..",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  Column(
                    children: [
                      const Text(
                        "4 Years",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Experience",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      Image.asset("assets/images/star.png")
                    ],
                  )
                ],
              ),
            ),
            Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    child: Image.asset(
                      "assets/images/Ellipse 2.png",
                      height: 400,
                      color: Color(0xff93AAB8),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Image.asset(
                      'assets/images/shaan.png',
                      fit: BoxFit.fill,
                      height: 500,
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    child: Container(
                      width: 500,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GlassContainer(
                              width: 200,
                              height: 50,
                              child: Text(
                                "Download resume",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          GlassContainer(
                              width: 100,
                              height: 50,
                              child: Text(
                                "Hire Me",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: 500,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    "assets/images/bg1.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 50),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text.rich(
                      TextSpan(
                        text: "My",
                        style: GoogleFonts.urbanist(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                              text: "Applications",
                              style: GoogleFonts.urbanist(
                                color: ThemeColors.secondary,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  ScrollConfiguration(
                    behavior: ScrollBehavior().copyWith(dragDevices: {
                      PointerDeviceKind.mouse,
                      PointerDeviceKind.touch,
                    }, scrollbars: false),
                    child: SizedBox(
                      height: 300,
                      width: Get.width,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        children: [
                          for (var i = 1; i <= 5; i++)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Image.asset(
                                "assets/images/s$i.png",
                                height: 300,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                        ],
                      ),
                    ),
                  )

                  // CarouselView(itemExtent: , children: children)
                ],
              ),
            )
          ],
        ),
        ///////////////////////////////////////work experience/////////////////////////////////
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Text.rich(
            TextSpan(
              text: "My",
              style: GoogleFonts.poppins(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                    text: " Work Experience",
                    style: GoogleFonts.poppins(
                      color: ThemeColors.secondary,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/beams.png",
                height: 80,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bounce(
                    onTap: () {
                      customlaunchUrl(url: Constants.beamsUrl);
                    },
                    child: HoverText(
                      text: "Beam IT solutions,Al qusais , Dubai",
                    ),
                  ),
                  // Text(
                  //   "Beam IT solutions,Al qusais , Dubai",
                  //   style: GoogleFonts.poppins(
                  //     fontSize: 25,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  Text(
                    "August 10 - present",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    "Working in managing and leading Flutter app development projects",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[900],
                        fontStyle: FontStyle.italic),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Text(
                      "Lead a team of developers, providing technical guidance, code reviews, and mentorship to ensure best practices and timely project execution. ",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey[900],
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Flutter Developer Lead",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Text(
                      '''Spearheading the development and management of Flutter-based mobile applications,ensuring high-quality code and efficient project delivery...''',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  // Text(
                  //   "State Management Expertise:",
                  //   style: GoogleFonts.poppins(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Text(
                      '''Proficient in implementing GetX for robust and scalable state management, optimizing app performance and enhancing maintainability. ''',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/techfriar.png",
                height: 80,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bounce(
                    onTap: () {
                      customlaunchUrl(url: Constants.techfriarUrl);
                    },
                    child: HoverText(
                      text: "Techfriar technologies,inforpark ,Kochi",
                    ),
                  ),
                  // Text(
                  //   "Techfriar technologies,inforpark ,Kochi",
                  //   style: GoogleFonts.poppins(
                  //     fontSize: 25,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  Text(
                    "March 2022 - August 2024",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    "Worked as a Flutter developer for Techfriar Technologies",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[900],
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Flutter Developer",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: Text.rich(
                        TextSpan(
                          text: "Worked in different architectures like",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                                text: "  Bloc, GetX , and Riverpod.",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      )

                      // Text(
                      //   '''Worked in different architectures like Bloc, GetX , and Riverpod.''',
                      //   textAlign: TextAlign.left,
                      //   style: GoogleFonts.poppins(
                      //     fontSize: 13,
                      //     color: Colors.grey[900],
                      //   ),
                      // ),
                      ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Text(
                      '''Got experience in working on project which support Audio and Video call ''',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Text(
                      '''Good understanding of serverless Data Management systems such as SQLite and Hive . ''',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/mind.png",
                height: 80,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bounce(
                    onTap: () {
                      customlaunchUrl(url: Constants.mindIncUrl);
                    },
                    child: HoverText(
                      text: "Mind Inc , Banglore ,Karnataka",
                    ),
                  ),
                  // Text(
                  //   "Mind Inc , Banglore ,Karnataka",
                  //   style: GoogleFonts.poppins(
                  //     fontSize: 25,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  Text(
                    "August 2021 - March 2022",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    "worked as flutter developer apprentice and UI/UX designer for Mind.IncSoftware Solutions. ",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[900],
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Text(
                      "UI/UX designer",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: Text.rich(
                        TextSpan(
                          text: "Worked in different architectures like",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                                text: "  Bloc, GetX , and Riverpod.",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      )

                      // Text(
                      //   '''Worked in different architectures like Bloc, GetX , and Riverpod.''',
                      //   textAlign: TextAlign.left,
                      //   style: GoogleFonts.poppins(
                      //     fontSize: 13,
                      //     color: Colors.grey[900],
                      //   ),
                      // ),
                      ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Text(
                      '''Got experience in working on project which support Audio and Video call ''',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Text(
                      '''Good understanding of serverless Data Management systems such as SQLite and Hive . ''',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
/////////////////////////////new idea section/////////////////////////////////////
        Lottie.asset("assets/lottie/l1.json", height: 400),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            children: [
              const Text(
                "Have an Awesome Project Idea?",
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Let's Discuss",
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Enter Email Address",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                      ),
                      child: const Text(
                        "Send",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.orange),
                  Text(" 4.8/5 Average Ratings"),
                  SizedBox(width: 15),
                  Icon(Icons.verified, color: Colors.orange),
                  Text(" Certified Flutter Developer"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 30),
          height: 400,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.asset(
              "assets/images/bg1.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          height: 450,
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 40, 50, 0),
                  child: Row(
                    children: [
                      const Text(
                        "Lets Connect there",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 50),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Hire me",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Icon(Icons.arrow_forward, color: Colors.white),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Get the latest information",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Email Address",
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(15),
                                  ),
                                  child: const Icon(Icons.arrow_forward,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: const Divider(color: Colors.grey, height: 40)),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Logo and description
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: Colors.orange,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "SN",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Shahil Nuhman MP",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Shahilnuhmanmp@gmail.com",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              const SizedBox(height: 20),
                              const Row(
                                children: [
                                  Icon(Icons.facebook, color: Colors.white),
                                  SizedBox(width: 10),
                                  Icon(Icons.youtube_searched_for_outlined,
                                      color: Colors.white),
                                  SizedBox(width: 10),
                                  Icon(Icons.chat, color: Colors.white),
                                  SizedBox(width: 10),
                                  Icon(Icons.safety_check, color: Colors.white),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Navigation and Contact
                        const Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Navigation",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Home",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "About Us",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Service",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Resume",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Project",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Contact",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "+971 55 365 1049",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "shahilnuhmanp@gmail.com",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Subscription
                      ],
                    ),
                    const Divider(color: Colors.grey, height: 40),
                    const Text(
                      "All the documents are available on request .",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class GlassContainer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Widget child;

  const GlassContainer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 30,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: Colors.white.withOpacity(0.2), // Border color
          width: 1.5,
        ),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            alignment: Alignment.center,
            color: Colors.white.withOpacity(0.1), // Slight translucent color
            child: child, // The inner content of the glass container
          ),
        ),
      ),
    );
  }
}

class HoverText extends StatefulWidget {
  final String text;

  const HoverText({super.key, required this.text});
  @override
  _HoverTextState createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  Color _textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _textColor = Colors.blue;
          });
        },
        onExit: (_) {
          setState(() {
            _textColor = Colors.black;
          });
        },
        child: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 300),
          style: GoogleFonts.poppins(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: _textColor,
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}

Future<void> customlaunchUrl({required String url}) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}
