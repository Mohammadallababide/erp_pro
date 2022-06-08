import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimationAppWidget extends StatelessWidget {
  final AnimationWidgetNames name;
  const AnimationAppWidget({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getAnimationoAccrodingName();
  }

  Widget getAnimationoAccrodingName() {
    if (name == AnimationWidgetNames.searching) {
    } else if (name == AnimationWidgetNames.searching) {
    } else if (name == AnimationWidgetNames.dashbordLoadder) {
      return Center(
        child: Container(
          height: ScreenUtil().setHeight(100),
          width: double.infinity,
          child: FlareActor(
            "assets/flare/dashboard_animated.flr",
            animation: "play",
            color: Colors.black,
            sizeFromArtboard: true,
            fit: BoxFit.contain,
            shouldClip: false,
          ),
        ),
      );
    } else if (name == AnimationWidgetNames.empty1) {
      return Container(
        height: ScreenUtil().setHeight(180),
        width: double.infinity - ScreenUtil().setWidth(20),
        child: FlareActor(
          "assets/flare/empty2.flr",
          animation: "empty",
          sizeFromArtboard: true,
          shouldClip: false,
          fit: BoxFit.contain,
        ),
      );
    } else if (name == AnimationWidgetNames.empty2) {
    } else if (name == AnimationWidgetNames.networkError) {
      return Center(
        child: Container(
          height: ScreenUtil().setHeight(130),
          width: double.infinity,
          child: FlareActor(
            "assets/flare/network_error.flr",
            animation: "idle",
            sizeFromArtboard: true,
            fit: BoxFit.contain,
            shouldClip: false,
          ),
        ),
      );
    } else if (name == AnimationWidgetNames.noUserFound) {
    } else if (name == AnimationWidgetNames.uploaddingFile) {
      return Container(
        height: ScreenUtil().setSp(150),
        width: double.infinity,
        child: FlareActor(
          "assets/flare/uploding.flr",
          animation: "uploading",
          sizeFromArtboard: true,
          fit: BoxFit.contain,
          shouldClip: false,
        ),
      );
    } else if (name == AnimationWidgetNames.ProgressIndicator) {
      return Center(
        child: Container(
          height: ScreenUtil().setHeight(100),
          width: double.infinity,
          child: FlareActor(
            "assets/flare/Progress Indicator.flr",
            animation: "Loading",
            color: Colors.black,
            sizeFromArtboard: true,
            fit: BoxFit.contain,
            shouldClip: false,
          ),
        ),
      );
    } else if (name == AnimationWidgetNames.sendVerificationRequest) {
      return  Container(
            height: ScreenUtil().setHeight(350),
            width: double.infinity - ScreenUtil().setWidth(20),
            child: FlareActor(
              "assets/flare/send_verification_request.flr",
              animation: "verification",
              sizeFromArtboard: true,
              fit: BoxFit.cover,
            ),
          );
    } else if (name == AnimationWidgetNames.usersLoadder) {
    } else if (name == AnimationWidgetNames.welcomePage) {}
    return Container();
  }
}

enum AnimationWidgetNames {
  searching,
  dashbordLoadder,
  empty1,
  empty2,
  networkError,
  noUserFound,
  ProgressIndicator,
  sendVerificationRequest,
  usersLoadder,
  welcomePage,
  uploaddingFile,
}
