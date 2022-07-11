import 'package:erb_mobo/core/validations/validtion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/theme_helper.dart';
import '../../../../../core/utils/app_flash_bar.dart';
import '../../../../../core/utils/app_snack_bar.dart';
import '../../../bloc/leave_center_bloc.dart';

class CreateLeaveCategoryDialog extends StatefulWidget {
  final Function ActionCallBack;
  const CreateLeaveCategoryDialog({
    Key? key,
    required this.ActionCallBack,
  }) : super(key: key);

  @override
  State<CreateLeaveCategoryDialog> createState() =>
      _CreateLeaveCategoryDialogState();
}

class _CreateLeaveCategoryDialogState extends State<CreateLeaveCategoryDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _deductionAmountController;
  final LeaveCenterBloc leaveCenterBloc = LeaveCenterBloc();
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _deductionAmountController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: leaveCenterBloc,
      listener: (context, state) {
        if (state is SuccessCreattedLeaveCategory) {
          setState(() {
            widget.ActionCallBack();
          });
          getFlashBar(
            context: context,
            title: 'Mission Success',
            message: 'The New Leave Category is Creatted With Success .',
          );
        } else if (state is ErrorCreattedLeaveCategory) {
          ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
              message: 'Faild Creatting New Leave Category !',
              context: context));
        }
      },
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        heroTag: null,
        child: Center(
          child: Icon(Icons.add,
              color: Colors.white, size: ScreenUtil().setSp(30)),
        ),
        onPressed: () => createNewLeaveCategoryDialog(),
      ),
    );
  }

  Future<void> createNewLeaveCategoryDialog() {
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
                          "New Leave Category:",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(18),
                          ),
                        ),
                        Icon(
                          Icons.category_outlined,
                          size: ScreenUtil().setSp(30),
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: ScreenUtil().setHeight(15),
                              ),
                              TextFormField(
                                controller: _nameController,
                                keyboardType: TextInputType.text,
                                validator: (val) =>
                                    Validation.nonEmptyField(val!),
                                decoration: ThemeHelper().textInputDecoration(
                                    'Name', 'Enter the Leave Category Name'),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                              TextFormField(
                                controller: _deductionAmountController,
                                keyboardType: TextInputType.number,
                                validator: (val) =>
                                    Validation.nonEmptyField(val!),
                                decoration: ThemeHelper().textInputDecoration(
                                    'deduction Amount',
                                    'Enter the Leave deduction Amountt'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(15),
                          ),
                          BlocBuilder(
                            bloc: leaveCenterBloc,
                            builder: (context, state) {
                              if (state is CreattingLeaveCategory) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                    strokeWidth: ScreenUtil().setWidth(3),
                                  ),
                                );
                              }
                              return Container(
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
                              );
                            },
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

  void submitForm() {
    Navigator.pop(context);
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      leaveCenterBloc.add(
        CreateLeaveCategory(
          name: _nameController.text,
          deductionAmount: int.parse(_deductionAmountController.text),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
          message: 'info not completed yet!!', context: context));
    }
  }
}
