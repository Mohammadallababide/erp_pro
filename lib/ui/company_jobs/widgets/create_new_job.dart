import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/common_widgets/app_snack_bar.dart';
import '../../../common/theme_helper.dart';
import '../../../core/validations/validtion.dart';
import '../bloc/job_bloc.dart';

class CreateNewJob extends StatefulWidget {
  final Function jobListCallBack;
  const CreateNewJob({
    Key? key,
    required this.jobListCallBack,
  }) : super(key: key);

  @override
  State<CreateNewJob> createState() => _CreateNewJobState();
}

class _CreateNewJobState extends State<CreateNewJob> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _jobNameController;
  late TextEditingController _jobDescriptionController;
  final JobBloc jobBloc = JobBloc();
  @override
  void initState() {
    super.initState();
    _jobNameController = TextEditingController();
    _jobDescriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: jobBloc,
      listener: (context, state) {
        if (state is SuccessCreattingJob) {
          setState(() {
            widget.jobListCallBack(state.job);
          });
        } else if (state is ErrorCreattingJob) {
          ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
              message: 'Faild Creatting Job !', context: context));
        }
      },
      child: BlocBuilder(
        bloc: jobBloc,
        builder: (context, state) {
          if (state is CreattingJob) {
     return   Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircularProgressIndicator(
            color: Colors.blue,
            strokeWidth: ScreenUtil().setWidth(3),
          ),
        );
          }
          return IconButton(
            onPressed: () => createNewJobDialog(context),
            icon: Icon(
              Icons.add_circle,
              size: ScreenUtil().setSp(28),
            ),
          );
     
        },
      ),
    );
  }

  void submitForm() {
    Navigator.pop(context);
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      jobBloc.add(CreateJob(
          name: _jobNameController.text,
          description: _jobDescriptionController.text));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
          message: 'info not completed yet!!', context: context));
    }
  }

  Future<void> createNewJobDialog(
    BuildContext context,
  ) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(25),
                  vertical: ScreenUtil().setHeight(10)),
              child: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Create Job:",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(20)),
                        ),
                        Container(
                          height:
                              ScreenUtil().setSp(ScreenUtil().radius(15) * 2),
                          width:
                              ScreenUtil().setSp(ScreenUtil().radius(15) * 2),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.2),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage('assets/images/job.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: ScreenUtil().setHeight(15),
                              ),
                              TextFormField(
                                controller: _jobNameController,
                                keyboardType: TextInputType.text,
                                validator: (val) =>
                                    Validation.nonEmptyField(val!),
                                decoration: ThemeHelper().textInputDecoration(
                                    'Name', 'Enter Job Name'),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                              TextFormField(
                                controller: _jobDescriptionController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                maxLength: 120,
                                validator: (val) =>
                                    Validation.nonEmptyField(val!),
                                decoration: ThemeHelper().textInputDecoration(
                                    'description', 'Enter Job description'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(15),
                          ),
                          Container(
                            decoration: ThemeHelper()
                                .buttonBoxDecoration(context: context),
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
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
