import 'package:erb_mobo/common/common_widgets/commomn_app_bar.dart';
import 'package:erb_mobo/ui/approvment_request_list/widgets/aprovment_requests_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../common/common_widgets/app_drawer.dart';

class ApprovmentRequests extends StatelessWidget {
  const ApprovmentRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar:commonAppBar(context: context,title:'approvment requests'),
        drawer: const AppDrawer(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.blueGrey[50],
          child: const ApprovmentRequestsList(),
        ),
      ),
    );
  }
}
