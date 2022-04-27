import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:erb_mobo/ui/invoices-center.dart/bloc/invoice_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/common_widgets/app_snack_bar.dart';
import '../../../common/common_widgets/commomn_app_bar.dart';
import '../../../common/theme_helper.dart';
import '../../../core/validations/validtion.dart';

class CreateInvoicePage extends StatefulWidget {
  CreateInvoicePage({Key? key}) : super(key: key);

  @override
  State<CreateInvoicePage> createState() => _CreateInvoicePageState();
}

class _CreateInvoicePageState extends State<CreateInvoicePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  InvoiceBloc invoiceBloc = InvoiceBloc();
  late TextEditingController grossAmountController = TextEditingController();
  late TextEditingController netAmountController = TextEditingController();
  late TextEditingController taxNumberController = TextEditingController();
  late TextEditingController dueDateController = TextEditingController(
    text: DateTime.now()
        .add(
          Duration(days: 1),
        )
        .toString(),
  );
  late File? pdfFile;
  late String issueDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        title: 'create new Invoice',
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(20),
            horizontal: ScreenUtil().setWidth(5),
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Flexible(
                  flex: 4,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          pickPdfIncoive();
                        },
                        child: Container(
                          height: ScreenUtil().setSp(150),
                          width: ScreenUtil().setSp(150),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).primaryColor,
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/upload-icon.jpg'))),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 7,
                  child: buildInvoiceForm(),
                ),
                Flexible(
                  flex: 1,
                  child: BlocListener(
                      bloc: invoiceBloc,
                      listener: (context, state) {
                        if (state is SuccessCreattedInvoice) {
                          Navigator.pop(
                            context,
                            true,
                          );
                        } else if (state is ErrorCreattedInvoice) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              getAppSnackBar(
                                  message: 'Faild! upload new Invoice.',
                                  context: context));
                        }
                      },
                      child: BlocBuilder(
                          bloc: invoiceBloc,
                          builder: (context, state) {
                            if (state is CreattingInvoice) {
                              return CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                                strokeWidth: ScreenUtil().setWidth(3),
                              );
                            }
                            return Container(
                              decoration: ThemeHelper()
                                  .buttonBoxDecoration(context: context),
                              child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Center(
                                    child: Text(
                                      'Submit'.toUpperCase(),
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
                          })),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pickPdfIncoive() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Please select an ivoice pdf file:',
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      pdfFile = File(result.files.single.path!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
          message: 'Faild pick the pdf file !!', context: context));
    }
  }

  Widget buildInvoiceForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildTextFromField(
            lebelText: 'Invoice Gross Amount',
            keyboardType: TextInputType.number,
            controller: grossAmountController,
          ),
          buildTextFromField(
            lebelText: 'Invoice Net Amount',
            keyboardType: TextInputType.number,
            controller: netAmountController,
          ),
          buildTextFromField(
            lebelText: 'Invoice Tax Number',
            keyboardType: TextInputType.number,
            controller: taxNumberController,
          ),
          DateTimePicker(
            type: DateTimePickerType.dateTimeSeparate,
            dateMask: 'd MMM, yyyy',
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(
              Duration(days: 3600),
            ),
            controller: dueDateController,
            initialDate: DateTime.now().add(Duration(days: 1)),
            icon: Icon(Icons.event),
            dateLabelText: 'Due Date',
            timeLabelText: "Due Hour",
            selectableDayPredicate: (date) {
              // Disable weekend days to select from the calendar
              if (date.weekday == 6 || date.weekday == 7) {
                return false;
              }
              return true;
            },
            validator: (val) {
              print(val);
              return null;
            },
          ),
          SizedBox(
            height: ScreenUtil().setHeight(15),
          ),
        ],
      ),
    );
  }

  void submitForm() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate() && pdfFile != null) {
      print(grossAmountController.text);
      print(netAmountController.text);
      print(taxNumberController.text);
      print(dueDateController.text);
      print(pdfFile);
      issueDate = DateTime.now().toString();
      invoiceBloc.add(CreateIvoice(
          grossAmount: int.parse(grossAmountController.text),
          netAmount: int.parse(netAmountController.text),
          taxNumber: taxNumberController.text,
          filePath: pdfFile!.path,
          dueDate: dueDateController.text,
          issueDate: issueDate));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
          message: 'info not completed yet!!', context: context));
    }
  }

  Column buildTextFromField({
    required String lebelText,
    required TextInputType keyboardType,
    required TextEditingController controller,
  }) {
    return Column(
      children: [
        TextFormField(
          validator: (val) => Validation.nonEmptyField(val!),
          textAlign: TextAlign.start,
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            border: UnderlineInputBorder(),
            labelText: lebelText,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          ),
          keyboardType: keyboardType,
        ),
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
      ],
    );
  }
}
