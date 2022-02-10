import 'package:erb_mobo/common/common_widgets/commomn_app_bar.dart';
import 'package:erb_mobo/ui/home/widgets/app_drawer/app_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:commonAppBar(context: context,title:'home page'),
      drawer: const AppDrawer(),
      body: Container(),
    );
  }
}
