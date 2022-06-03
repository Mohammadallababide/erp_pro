import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_snack_bar.dart';
import '../../../../common/theme_helper.dart';
import '../../../../core/validations/validtion.dart';
import '../../../../models/deduction.dart';

import 'deduction_type_dropDownButton.dart';

class DeductionsSection extends StatefulWidget {
  final List<Deduction> deductions;
  final Function deductionsListCallBack;
  const DeductionsSection({
    Key? key,
    required this.deductions,
    required this.deductionsListCallBack,
  }) : super(key: key);

  @override
  _DeductionsSectionState createState() => _DeductionsSectionState();
}

class _DeductionsSectionState extends State<DeductionsSection> {
  late TextEditingController _deductionAmountController =
      TextEditingController();
  late String _deductionTypeController;
  late TextEditingController _deductionReasonController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void listToDuductionTypeValue(String newValue) {
    setState(() {
      _deductionTypeController = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Deductions Section',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(
              onPressed: () => showAddOrEditDeductionOnSalaryForm(
                context: context,
                index: null,
                deduction: null,
              ),
              icon: const Icon(Icons.add_circle),
              iconSize: ScreenUtil().setSp(30),
            ),
          ],
        ),
        buildDeductionsTable(context),
      ],
    );
  }

  Padding buildDeductionsTable(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'amount',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(15),
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'type',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(15),
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: ScreenUtil().setSp(15),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: ScreenUtil().setHeight(10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1.5,
                ),
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(5),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(120),
            child: ListView.builder(
                itemCount: widget.deductions.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildDeductionCard(
                    deduction: widget.deductions[index],
                    index: index,
                  );
                }),
          )
        ],
      ),
    );
  }

  Row buildDeductionCard({required Deduction deduction, required int index}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            deduction.amount.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(15),
              fontWeight: FontWeight.w400,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            deduction.type,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(15),
              fontWeight: FontWeight.w400,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Expanded(
          child: IconButton(
              onPressed: () => showDeductionDetails(deduction, index),
              icon: Icon(Icons.arrow_forward_ios_outlined,
                  color: Theme.of(context).primaryColor),
              iconSize: ScreenUtil().setSp(15)),
        ),
      ],
    );
  }

// Add New Salary Deduction Section

  Future<void> showAddOrEditDeductionOnSalaryForm({
    required BuildContext context,
    int? index,
    Deduction? deduction,
  }) {
    if (deduction != null) {
      _deductionAmountController.text = deduction.amount.toString();
      _deductionTypeController = deduction.type;
      _deductionReasonController.text = deduction.reason;
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "New Deduction",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                            controller: _deductionAmountController,
                            keyboardType: TextInputType.number,
                            validator: (val) => Validation.nonEmptyField(val!),
                            decoration: ThemeHelper().textInputDecoration(
                                'deduction amount', 'deduction amount'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(15),
                        ),
                        Container(
                          child: TextFormField(
                            controller: _deductionReasonController,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 5,
                            validator: (val) => Validation.nonEmptyField(val!),
                            decoration: ThemeHelper().textInputDecoration(
                                'deduction reason', 'deduction reason'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(15),
                        ),
                        DeductionTypeDropDownButton(
                          deductionTypeCallBack: listToDuductionTypeValue,
                          oldValue: deduction != null ? deduction.type : null,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () => submitForm(index),
                      child: Text(
                        index != null ? 'Edit' : 'Add',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(18),
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void submitForm(int? index) {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      if (index == null) {
        addNewItemToDeductionsList();
      } else {
        editItemInDeductionsList(
          amount: int.parse(_deductionAmountController.text),
          type: _deductionTypeController,
          reason: _deductionReasonController.text,
          index: index,
        );
        Navigator.pop(context);
      }
      _deductionAmountController = TextEditingController();
      _deductionTypeController = '';
      _deductionReasonController = TextEditingController();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
          message: 'info not completed yet!!', context: context));
    }
  }

// end Add New Salary Deduction Section

// show Dedection deatils section
  Future<void> showDeductionDetails(Deduction deduction, int index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Deduction Details",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                      width: ScreenUtil().setWidth(30),
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => showAddOrEditDeductionOnSalaryForm(
                          context: context,
                          index: index,
                          deduction: deduction,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                      width: ScreenUtil().setWidth(30),
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () => removeItemFromDeductionsList(index),
                      ),
                    )
                  ],
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  buildDeductionDetails(deduction.amount.toString(),
                      'deduction amount :', context),
                  buildDeductionDetails(
                      deduction.type, 'deduction reason :', context),
                  buildDeductionDetails(
                      deduction.reason, 'deduction type :', context),
                ],
              ),
            ),
          );
        });
  }

  Widget buildDeductionDetails(
          String getValue, String title, BuildContext context) =>
      Padding(
        padding: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Container(
              width:
                  MediaQuery.of(context).size.width - ScreenUtil().setWidth(30),
              height: ScreenUtil().setHeight(38),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1.5,
                  ),
                ),
              ),
              child: Text(
                getValue,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(15),
                  height: ScreenUtil().setHeight(1.5),
                ),
              ),
            )
          ],
        ),
      );

//end show Dedection deatils section

// function for process on deductions list (add new item , delete item , edit item)

  void addNewItemToDeductionsList() {
    setState(() {
      widget.deductions.add(Deduction(
        amount: int.parse(_deductionAmountController.value.text),
        reason: _deductionReasonController.value.text,
        type: _deductionTypeController,
      ));
      widget.deductionsListCallBack(widget.deductions);
    });
  }

  void editItemInDeductionsList(
      {required int amount,
      required String type,
      required String reason,
      required int index}) {
    setState(() {
      widget.deductions[index] = Deduction(
        amount: amount,
        reason: reason,
        type: type,
      );
      widget.deductionsListCallBack(widget.deductions);
    });
  }

  void removeItemFromDeductionsList(int index) {
    setState(() {
      widget.deductions.removeAt(index);
      widget.deductionsListCallBack(widget.deductions);
    });
    Navigator.pop(context);
  }
}
