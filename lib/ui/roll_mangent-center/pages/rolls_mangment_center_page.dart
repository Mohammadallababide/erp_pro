import 'package:erb_mobo/common/common_widgets/commomn_app_bar.dart';
import 'package:flutter/material.dart';

class RollsMangmentCenterPage extends StatefulWidget {
  const RollsMangmentCenterPage({Key? key}) : super(key: key);

  @override
  State<RollsMangmentCenterPage> createState() =>
      _RollsMangmentCenterPageState();
}

class _RollsMangmentCenterPageState extends State<RollsMangmentCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        title: 'Company Rolls Center',
        context: context,
      ),
    );
  }
}
