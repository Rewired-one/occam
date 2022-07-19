import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF000000),
              Color(0xFF212121),
              Color(0xFF171717),
            ],
            stops: [
              0,
              55.73,
              100,
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                SizedBox(height: constraints.maxHeight * .375),
                SizedBox(
                  height: constraints.maxHeight * .1,
                  child: SvgPicture.asset('assets/images/splash_screen/occam_logo.svg'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
