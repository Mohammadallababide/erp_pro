import 'package:erb_mobo/common/common_widgets/commomn_app_bar.dart';
import 'package:erb_mobo/ui/approvment_request_list/widgets/aprovment_requests_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../common/common_widgets/app_drawer.dart';
import '../../../common/common_widgets/common_scaffold_app.dart';

class ApprovmentRequests extends StatelessWidget {
  const ApprovmentRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldApp(
      title: 'approvment requests',
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blueGrey[50],
        child: const ApprovmentRequestsList(),
      ),
    );
  }
}
