import 'package:flutter/material.dart';

import '../../../../core/utils/costant.dart';

class DeductionTypeDropDownButton extends StatefulWidget {
  final Function deductionTypeCallBack;
  final String? oldValue;
  const DeductionTypeDropDownButton({
    Key? key,
    required this.deductionTypeCallBack,
    this.oldValue,
  }) : super(key: key);

  @override
  State<DeductionTypeDropDownButton> createState() =>
      _DeductionTypeDropDownButtonState();
}

class _DeductionTypeDropDownButtonState
    extends State<DeductionTypeDropDownButton> {
  late String dropdownvalue;
  @override
  void initState() {
    dropdownvalue = widget.oldValue ?? ConstatValues.deductionTypeList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildDeductionTypeDropDown();
  }

  Widget buildDeductionTypeDropDown() {
    return DropdownButton(
      value: dropdownvalue,
      icon: Icon(Icons.keyboard_arrow_down),
      items: ConstatValues.deductionTypeList.map((String items) {
        return DropdownMenuItem(value: items, child: Text(items));
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
          widget.deductionTypeCallBack(newValue);
        });
      },
    );
  }
}
