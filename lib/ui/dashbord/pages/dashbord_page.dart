import 'package:erb_mobo/common/common_widgets/commomn_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../common/common_widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar:commonAppBar(context: context,title:'home page'),
        drawer: const AppDrawer(),
        body: Container(),
      ),
    );
  }
}
