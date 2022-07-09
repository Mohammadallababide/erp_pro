import 'package:flutter/material.dart';

import '../../../common/common_widgets/app_drawer.dart';
import '../../../common/common_widgets/commomn_app_bar.dart';

class LeavesCenter extends StatelessWidget {
  const LeavesCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context: context,
        title: 'Leaves Center',
      ),
      drawer: const AppDrawer(),
      body: Container(),
    );
  }
}
