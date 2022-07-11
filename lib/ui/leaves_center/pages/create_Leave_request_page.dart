import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import '../../../common/common_widgets/commomn_app_bar.dart';

class CreateLeaveRequestPage extends StatefulWidget {
  const CreateLeaveRequestPage({Key? key}) : super(key: key);

  @override
  State<CreateLeaveRequestPage> createState() => _CreateLeaveRequestPageState();
}

class _CreateLeaveRequestPageState extends State<CreateLeaveRequestPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController descriptionController = TextEditingController();
  late TextEditingController formDateController = TextEditingController(
    text: DateTime.now().toString(),
  );
  late TextEditingController toDateController = TextEditingController(
    text: DateTime.now()
        .add(
          Duration(days: 1),
        )
        .toString(),
  );
  late int leaveCategoryId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context: context,
        title: 'Create Leave Request',
      ),
      body: ListView(
        children: [
          Form(
            child: Column(
              children: [
                 DateTimePicker(
            type: DateTimePickerType.dateTimeSeparate,
            dateMask: 'd MMM, yyyy',
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(
              Duration(days: 3600),
            ),
            controller: formDateController,
            // initialDate: DateTime.now().add(Duration(days: 1)),
            icon: Icon(Icons.event),
            dateLabelText: 'Due Date',
            timeLabelText: "Due Hour",
            // selectableDayPredicate: (date) {
            //   // Disable weekend days to select from the calendar
            //   if (date.weekday == 6 || date.weekday == 7) {
            //     return false;
            //   }
            //   return true;
            // },
            validator: (val) {
              print(val);
              return null;
            },
          ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
