import 'package:date_time_picker/date_time_picker.dart';
import 'package:erb_mobo/ui/leaves_center/bloc/leave_center_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/common_widgets/commomn_app_bar.dart';
import '../../../common/theme_helper.dart';
import '../../../core/utils/app_flash_bar.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../widgets/LeaveWidget/CreateLeaveRequestWidgets/leave_category_selector.dart';

class CreateLeaveRequestPage extends StatefulWidget {
  final Function actionCallBack;
  const CreateLeaveRequestPage({Key? key, required this.actionCallBack})
      : super(key: key);

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
  late int? leaveCategoryId = null;
  LeaveCenterBloc leaveCenterBloc = LeaveCenterBloc();
  void listenToLeaaveCategoryAction(int id) {
    setState(() {
      leaveCategoryId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context: context,
        title: 'Create Leave Request',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(15),
          vertical: ScreenUtil().setHeight(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  LeaveCategorySelector(
                    selectCategoryActionCallBack: listenToLeaaveCategoryAction,
                    preSelectValue: leaveCategoryId,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  dateSection(isStartDate: true),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  dateSection(isStartDate: false),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  descriptionSection(),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(50),
            ),
            buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget buildSubmitButton() {
    return BlocListener(
      bloc: leaveCenterBloc,
      listener: (context, state) {
        if (state is ErrorCreattedLeaveRequest) {
          getFlashBar(
            context: context,
            isErrorgMeg: true,
            title: 'Faild Mission',
            message: 'Faild Creatted the Leave Request ',
          );
        } else if (state is SuccessCreattedLeaveRequest) {
          setState(() {
            widget.actionCallBack();
          });
          Navigator.pop(context);
        }
      },
      child: BlocBuilder(
          bloc: leaveCenterBloc,
          builder: (context, state) {
            if (state is CreattingLeaveRequest) {
              return CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
                strokeWidth: ScreenUtil().setWidth(3),
              );
            }
            return Container(
              decoration: ThemeHelper().buttonBoxDecoration(context: context),
              child: ElevatedButton(
                  style: ThemeHelper().buttonStyle(),
                  child: Center(
                    child: Text(
                      'Create'.toUpperCase(),
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
                  onPressed: () => submitForm()),
            );
          }),
    );
  }

  void submitForm() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate() && leaveCategoryId != null) {
      leaveCenterBloc.add(CreateLeaveRequest(
        leaveCategoryId: leaveCategoryId!,
        description: descriptionController.text,
        fromDate: formDateController.text,
        toDate: toDateController.text,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
          message: 'info not completed yet!!', context: context));
    }
  }

  Widget descriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Leave Description :',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: ScreenUtil().setSp(16),
            fontWeight: FontWeight.w700,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(5),
          ),
          child: TextFormField(
            minLines: 1,
            maxLines: 5,
            maxLength: 120,
            controller: descriptionController,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              labelText: 'descrption',
              alignLabelWithHint: true,
              labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.bold),
              hintText: 'type here ..',
              contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            ),
          ),
        ),
      ],
    );
  }

  Widget dateSection({required bool isStartDate}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isStartDate ? 'Leave Start Date :' : 'Leave End Date :',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: ScreenUtil().setSp(16),
            fontWeight: FontWeight.w700,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(5),
          ),
          child: DateTimePicker(
            type: DateTimePickerType.dateTimeSeparate,
            dateMask: 'd MMM, yyyy',
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(
              Duration(days: 3600),
            ),
            controller: formDateController,
            icon: Icon(Icons.event),
            dateLabelText: isStartDate ? 'start date' : 'end date',
            timeLabelText: isStartDate ? "start hour" : 'end hour',
            validator: (val) {
              print(val);
              return null;
            },
          ),
        )
      ],
    );
  }
}
