import 'package:erb_mobo/ui/department_center/bloc/department_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/theme_helper.dart';
import '../../../../core/utils/app_flash_bar.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/validations/validtion.dart';

class CreateDepatment extends StatefulWidget {
  final Function jobListCallBack;
  final Widget? childWidget;
  const CreateDepatment({
    Key? key,
    required this.jobListCallBack,
    this.childWidget,
  }) : super(key: key);

  @override
  State<CreateDepatment> createState() => _CreateDepatmentState();
}

class _CreateDepatmentState extends State<CreateDepatment> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _deparmentNameController;
  late TextEditingController _departmentEmployeeCount;
  final DepartmentBloc departmentBloc = DepartmentBloc();

  @override
  void initState() {
    super.initState();
    _deparmentNameController = TextEditingController();
    _departmentEmployeeCount = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: departmentBloc,
      listener: (context, state) {
        if (state is SuccessCreattedDepartment) {
          setState(() {
            widget.jobListCallBack();
          });
            getFlashBar(
              context: context,
              title: 'Mission Success',
              message: 'The New Department is Creatted With Success .',
            );
        } else if (state is ErrorCreattedDepartment) {
          ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
              message: 'Faild Creatting New Department !', context: context));
        }
      },
      child: BlocBuilder(
        bloc: departmentBloc,
        builder: (context, state) {
          if (state is CreattingNewDepartment) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: ScreenUtil().setWidth(3),
              ),
            );
          }
          return InkWell(
            onTap: () => createNewDepartmentDialog(context),
            child: widget.childWidget ??
                IconButton(
                  onPressed: () => createNewDepartmentDialog(context),
                  icon: Icon(
                    Icons.add_circle,
                    size: ScreenUtil().setSp(28),
                  ),
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
      departmentBloc.add(CreateNewDepartment(
        maxNumberOfEmployees: int.parse(_departmentEmployeeCount.text),
        title: _deparmentNameController.text.toString(),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
          message: 'info not completed yet!!', context: context));
    }
  }

  Future<void> createNewDepartmentDialog(
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
                          "Create Department:",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(20)),
                        ),
                        Icon(
                          Icons.account_tree_outlined,
                          size: ScreenUtil().setSp(30),
                          color: Theme.of(context).primaryColor,
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
                                controller: _deparmentNameController,
                                keyboardType: TextInputType.text,
                                validator: (val) =>
                                    Validation.nonEmptyField(val!),
                                decoration: ThemeHelper().textInputDecoration(
                                    'title', 'Enter department Name'),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                              TextFormField(
                                controller: _departmentEmployeeCount,
                                keyboardType: TextInputType.number,
                                validator: (val) =>
                                    Validation.nonEmptyField(val!),
                                decoration: ThemeHelper().textInputDecoration(
                                    'employee count',
                                    'Enter count of employees department'),
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
