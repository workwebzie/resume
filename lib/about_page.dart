import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:resume/common/fadein_widget.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          FadeTransitionWidget(
          widget: Text("About Me",style: GoogleFonts.poppins(
            fontSize: 30,
          ),),
        ),
        Row(
          children: [
            Lottie.asset("assets/lottie/l2.json", height: 400),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeTransitionWidget(
                    widget: TypeTextWidget(
                      text: "Hi there ,",
                    ),
                  ),
                  FadeTransitionWidget(
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " I completed my Btech Graduation in 2021,I started my Career as UI/UX designer and gradually become the flutter developer in the same company.\nNow I have 4 years of experience. I specialize in creating efficient mobile applications and very passionate about crafting user-friendly interfaces and solving complex problems.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text("Companies i worked in:",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                        Text(
                          "Beams IT solution , dubai",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Techfriar technologies, infor park , kakkanad",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Mind Inc , Banglore ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TypeTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  const TypeTextWidget({
    super.key,
    required this.text,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          text,
          textStyle: textStyle ??
              TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
          cursor: "",
          speed: const Duration(milliseconds: 100),
        ),
      ],
      pause: const Duration(milliseconds: 100),
      repeatForever: false,
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
      isRepeatingAnimation: false,
    );
  }
}
