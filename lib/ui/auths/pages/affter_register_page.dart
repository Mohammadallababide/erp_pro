import 'dart:async';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/animationAppWidget.dart';
import '../../../common/theme_helper.dart';

class AfterRegisterPage extends StatelessWidget {
  AfterRegisterPage({Key? key}) : super(key: key);
  final FlareControls controls = FlareControls();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backwardsCompatibility: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: ScreenUtil().setSp(35),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimationAppWidget(
            name: AnimationWidgetNames.sendVerificationRequest,
          ),
          FutureBuilder(
            future: Future.delayed(Duration(seconds: 2)),
            builder: (c, s) => s.connectionState == ConnectionState.done
                ? Column(
                    children: [
                      Text(
                        'Thank you for register \n We send your register request \n to the admins !',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bebasNeue(
                          fontStyle: FontStyle.normal,
                          textStyle: TextStyle(
                            fontSize: ScreenUtil().setSp(30),
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                          // height: 1.5,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(15),
                          vertical: ScreenUtil().setHeight(15),
                        ),
                        child: Container(
                          decoration: ThemeHelper()
                              .buttonBoxDecoration(context: context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Center(
                              child: Text(
                                'Got it'.toUpperCase(),
                                style: GoogleFonts.belleza(
                                  fontStyle: FontStyle.normal,
                                  textStyle: TextStyle(
                                    fontSize: ScreenUtil().setSp(26),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: ()  {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
