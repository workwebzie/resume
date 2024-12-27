import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AboutPage extends StatelessWidget {
const AboutPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
      
        Lottie.asset("assets/lottie/l1.json"),
          Container(color: Colors.amber,
        child: Text("Coming Soon "),),
         
      ],
    );
  }
}