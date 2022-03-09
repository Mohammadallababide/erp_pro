import 'package:erb_mobo/models/salary.dart';
import 'package:erb_mobo/models/user.dart';
import 'package:erb_mobo/ui/users_finacial_mange/pages/select_assignment_user_salary_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/common_widgets/app_snack_bar.dart';
import '../../../common/theme_helper.dart';
import '../../../core/validations/validtion.dart';
import '../../../models/deduction.dart';
import '../../../models/receipt.dart';
import '../bloc/usersfinaicalmange_bloc.dart';
import '../widgets/CreateReceiptWidgets/build_deductions_section.dart';
import '../widgets/CreateReceiptWidgets/build_salary_date_faild.dart';

class CreateOrEditUserReceiptPage extends StatefulWidget {
  final int? receiptId;
  final Receipt? receipt;
  final Function? editReceiptInfoCallBack;
  final Function? createReceiptListCallBack;
  const CreateOrEditUserReceiptPage({
    Key? key,
    this.receiptId,
    this.receipt,
    this.editReceiptInfoCallBack,
    this.createReceiptListCallBack,
  }) : super(key: key);

  @override
  State<CreateOrEditUserReceiptPage> createState() =>
      _CreateOrEditUserReceiptPageState();
}

class _CreateOrEditUserReceiptPageState
    extends State<CreateOrEditUserReceiptPage> {
  final UsersfinaicalmangeBloc receiptBloc = UsersfinaicalmangeBloc();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String startSalaryDate = '';
  late String endSalaryDate = '';
  late TextEditingController _salaryAmountController;
  late TextEditingController _bounsAmountController;
  late TextEditingController _allowanceAmountController;

  late User userAssignemt = User(email: '', firstName: '', lastName: '');
  late List<Deduction> deductions = [];

  void lisentToAnyChangeOnDeductionsList(List<Deduction> newValue) {
    setState(() {
      deductions = newValue;
    });
  }

  void lisentToAssignmentUser(User user) {
    setState(() {
      userAssignemt = user;
    });
  }

  void lisentToAnChangeStartAndEndSalary(String start, String end) {
    setState(() {
      startSalaryDate = start;
      endSalaryDate = end;
    });
  }

  @override
  void initState() {
    super.initState();
    _salaryAmountController = TextEditingController();
    _bounsAmountController = TextEditingController();
    _allowanceAmountController = TextEditingController();
    if (widget.receiptId != null) {
      _salaryAmountController.text = widget.receipt!.salary.amount.toString();
      _bounsAmountController.text = widget.receipt!.salary.bonus.toString();
      _allowanceAmountController.text =
          widget.receipt!.salary.allowance.toString();
      userAssignemt = widget.receipt!.user!;
      startSalaryDate = widget.receipt!.salary.workStartDate ?? '';
      endSalaryDate = widget.receipt!.salary.workEndDate ?? '';
      deductions = widget.receipt!.deductions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: receiptBloc,
      listener: (context, state) {
        if (state is SuccessCreatingReceipt) {
          // todo call function callback for add new item in the users receipts list
          widget.createReceiptListCallBack!(state.receipt);
          Navigator.pop(context);
        } else if (state is SuccessEditingReceipt) {
          // todo call function callback for edit item in the users receipts list
          widget.editReceiptInfoCallBack!(state.receipt);
          Navigator.pop(context);
        } else if (state is ErrorCreatingReceipt ||
            state is ErrorEditingReceipt) {
              ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
            message: 'Faild Complate the process!!', context: context));
            }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.receiptId == null ? 'New User Receipt' : "Edit User Receipt",
            style: const TextStyle(color: Colors.white),
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
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Salary info Section',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(15),
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        Container(
                          child: TextFormField(
                            controller: _salaryAmountController,
                            keyboardType: TextInputType.number,
                            validator: (val) => Validation.nonEmptyField(val!),
                            decoration: ThemeHelper().textInputDecoration(
                                'salary amount', 'salary amount'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(15),
                        ),
                        Container(
                          child: TextFormField(
                            controller: _bounsAmountController,
                            keyboardType: TextInputType.number,
                            validator: (val) => Validation.nonEmptyField(val!),
                            decoration: ThemeHelper().textInputDecoration(
                                'bonus on salary', 'bonus on salary'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(15),
                        ),
                        Container(
                          child: TextFormField(
                            controller: _allowanceAmountController,
                            keyboardType: TextInputType.number,
                            validator: (val) => Validation.nonEmptyField(val!),
                            decoration: ThemeHelper().textInputDecoration(
                                'allowance amount', 'allowance amount'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(25),
                        ),
                        buildAssignmentUserSalarySection(),
                        SizedBox(
                          height: ScreenUtil().setHeight(25),
                        ),
                        SlarayDateRangeFaild(
                          startSalaryDate: startSalaryDate,
                          endSalaryDate: endSalaryDate,
                          title: 'Salary Range Date',
                          starAndEndtSalaryDateCallBack:
                              lisentToAnChangeStartAndEndSalary,
                        ),
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
              ),
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),
              BlocBuilder(
                bloc: receiptBloc,
                builder: (context, state) {
                  if (state is EditingReceipt || state is CreatingReceipt) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                        strokeWidth: ScreenUtil().setWidth(3),
                      ),
                    );
                  } else {
                    return buildSubmitButton(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildAssignmentUserSalarySection() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Salary Asignment To :',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(15),
              fontWeight: FontWeight.w700,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(15),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              userAssignemt.id == null
                  ? Text(
                      'No User Assignment Yet!',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : Row(
                      children: [
                        Container(
                          height: ScreenUtil().setSp(25),
                          width: ScreenUtil().setSp(25),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Image(
                            image: AssetImage('assets/images/useric.png'),
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(7),
                        ),
                        Text(
                          userAssignemt.firstName +
                              ' ' +
                              userAssignemt.lastName,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
              widget.receiptId == null
                  ? InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectAssignmentUserSalaryPage(
                            salaryUserCallBack: lisentToAssignmentUser,
                            userSelectedAssignmentSalaryId: userAssignemt.id,
                          ),
                        ),
                      ),
                      child: Container(
                        height: ScreenUtil().setHeight(40),
                        width: ScreenUtil().setWidth(75),
                        decoration:
                            ThemeHelper().buttonBoxDecoration(context: context),
                        child: Center(
                          child: Text(
                            'Change',
                            style: GoogleFonts.belleza(
                              fontStyle: FontStyle.normal,
                              textStyle: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                        right: ScreenUtil().setWidth(10),
                      ),
                      child: Icon(
                        Icons.check_circle,
                        color: Theme.of(context).primaryColor,
                        size: ScreenUtil().setSp(26),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  buildSubmitButton(context) {
    return Container(
      decoration: ThemeHelper().buttonBoxDecoration(context: context),
      child: ElevatedButton(
        style: ThemeHelper().buttonStyle(),
        child: Center(
          child: Text(
            widget.receiptId != null
                ? 'Edit'.toUpperCase()
                : 'Create'.toUpperCase(),
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
        onPressed: () => submitForm(),
      ),
    );
  }

  void submitForm() {
    // edit receipt case
    if (widget.receiptId != null) {
      formKey.currentState!.save();
      if (formKey.currentState!.validate() &&
          endSalaryDate.isNotEmpty &&
          startSalaryDate.isNotEmpty) {
        receiptBloc.add(
          EditReceipt(
            receiptId: widget.receiptId!,
            salary: Salary(
                amount: int.parse(_salaryAmountController.text),
                bonus: int.parse(_bounsAmountController.text),
                allowance: int.parse(_allowanceAmountController.text),
                workEndDate: endSalaryDate,
                workStartDate: startSalaryDate),
            deductions: deductions,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
            message: 'info not completed yet!!', context: context));
      }
    }
    // create receipt case
    else {
      formKey.currentState!.save();
      if (formKey.currentState!.validate() &&
          endSalaryDate.isNotEmpty &&
          startSalaryDate.isNotEmpty &&
          userAssignemt.id != null) {
        receiptBloc.add(
          CreateReceipt(
            userId: userAssignemt.id ?? 17,
            salary: Salary(
                amount: int.parse(_salaryAmountController.text),
                bonus: int.parse(_bounsAmountController.text),
                allowance: int.parse(_allowanceAmountController.text),
                workEndDate: endSalaryDate,
                workStartDate: startSalaryDate),
            deductions: deductions,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
            message: 'info not completed yet!!', context: context));
      }
    }
  }
}
