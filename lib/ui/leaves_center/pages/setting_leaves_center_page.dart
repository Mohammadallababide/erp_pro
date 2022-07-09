import 'package:flutter/material.dart';

import '../../../common/common_widgets/commomn_app_bar.dart';

class SettingLeavesCenterPage extends StatelessWidget {
  const SettingLeavesCenterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context: context,
        title: 'Leaves Categories Center',
      ),
      body: Container(),
    );
  }
}
