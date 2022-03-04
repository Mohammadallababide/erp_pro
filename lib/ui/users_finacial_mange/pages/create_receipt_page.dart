import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/theme_helper.dart';
import '../../../models/deduction.dart';
import '../widgets/CreateReceiptWidgets/build_deductions_section.dart';
import '../widgets/CreateReceiptWidgets/build_salary_section.dart';

class CreateUserReceiptPage extends StatefulWidget {
  const CreateUserReceiptPage({Key? key}) : super(key: key);

  @override
  State<CreateUserReceiptPage> createState() => _CreateUserReceiptPageState();
}

class _CreateUserReceiptPageState extends State<CreateUserReceiptPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController salaryAmountController;
  late TextEditingController bounsAmountController;
  late TextEditingController allowanceAmountController;
  late String startSalaryDate;
  late String endSalaryDate;
  late int userId;
  late List<Deduction> deductions = [];

  void lisentToAnyChangeOnDeductionsList(List<Deduction> newValue) {
    setState(() {
      deductions = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New User Receipt',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(10),
            vertical: ScreenUtil().setHeight(15),
          ),
          children: [
            Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                  vertical: ScreenUtil().setHeight(10),
                ),
                child: Column(
                  children: [
                    buildSalarySection(context),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    DeductionsSection(
                      deductions: deductions,
                      deductionsListCallBack:
                          lisentToAnyChangeOnDeductionsList,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            buildSubmitButton(context),
          ],
        ),
      ),
    );
  }

  buildSubmitButton(context) {
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
        onPressed: () => {},
      ),
    );
  }
}
