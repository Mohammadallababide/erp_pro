import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:erb_mobo/common/generate_screen.dart';
import 'package:erb_mobo/data/local_data_source/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late bool isTokenExist = false;

  @override
  void initState() {
    if (SharedPref.getToken() != null) {
      setState(() {
        isTokenExist = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: ScreenUtil().setHeight(150),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/brick.png'),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: ScreenUtil().setHeight(75),
                child: Align(
                  alignment: Alignment.center,
                  child: AnimatedTextKit(
                    onFinished: () {
                      Navigator.popAndPushNamed(
                          context,
                          !isTokenExist
                              ? NameScreen.loginPage
                              : NameScreen.dashboardPage);
                    },
                    totalRepeatCount: 3,
                    pause: const Duration(milliseconds: 1000),
                    animatedTexts: [
                      WavyAnimatedText(
                        'WELCOME',
                        textStyle: GoogleFonts.ultra(
                          fontStyle: FontStyle.normal,
                          textStyle: TextStyle(
                            fontSize: ScreenUtil().setSp(26),
                            fontWeight: FontWeight.bold,
                            letterSpacing: ScreenUtil().setSp(15),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                    isRepeatingAnimation: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
