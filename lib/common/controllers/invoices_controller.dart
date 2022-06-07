import 'package:erb_mobo/models/invoice.dart';

import '../../data/local_data_source/shared_pref.dart';
import '../../ui/invoices-center/widgets/enum/inv_filter_type_enum.dart';

class InvoicesController {
  final List<Invoice> invoiceList;

  InvoicesController(this.invoiceList);

  List<Invoice> getToBeReviwedInvoices() {
    List<Invoice> result = [];
    this.invoiceList.forEach((element) {
      if (element.status ==
          InvFilterTypeEnum.review_pending.toString().split('.')[1]) {
        result.add(element);
      }
    });

    return result;
  }

  List<Invoice> getToBeApprovedInvoices() {
    List<Invoice> result = [];
    this.invoiceList.forEach((element) {
      if (element.status ==
          InvFilterTypeEnum.approval_pending.toString().split('.')[1]) {
        result.add(element);
      }
    });
    return result;
  }

  List<Invoice> getToBePaidInvoices() {
    List<Invoice> result = [];
    this.invoiceList.forEach((element) {
      if (element.status ==
          InvFilterTypeEnum.payment_pending.toString().split('.')[1]) {
        result.add(element);
      }
    });
    return result;
  }

  List<Invoice> getRejectedInvoices() {
    List<Invoice> result = [];
    this.invoiceList.forEach((element) {
      if (element.status ==
          InvFilterTypeEnum.rejected.toString().split('.')[1]) {
        result.add(element);
      }
    });
    return result;
  }

  List<Invoice> getComplatedInvoices() {
    List<Invoice> result = [];
    this.invoiceList.forEach((element) {
      if (element.status ==
          InvFilterTypeEnum.completed.toString().split('.')[1]) {
        result.add(element);
      }
    });
    return result;
  }

  List<Invoice> getOverdueInvoices() {
    List<Invoice> result = [];
    this.invoiceList.forEach((element) {
      if (DateTime.now().isAfter(DateTime.parse(element.dueDate))) {
        result.add(element);
      }
    });
    return result;
  }

  List<Invoice> getAssignedToMeInvoices() {
    List<Invoice> result = [];
    this.invoiceList.forEach((element) {
      if (element.assigneeId == SharedPref.getUser().id) {
        result.add(element);
      }
    });
    return result;
  }

  int getTotalWorth(List<Invoice> list) {
    int result = 0;
    list.forEach((element) {
      result += element.netAmount;
    });
    return result;
  }

  List<Map<dynamic, dynamic>> getAllInvoicesStatsMap() {
    List<Map<String, dynamic>> result = [];
    result.add({
      'review_pending': (this.getToBeReviwedInvoices().length * 100) /
          (this.invoiceList.length),
      'approval_pending': (this.getToBeApprovedInvoices().length * 100) /
          (this.invoiceList.length),
      'payment_pending':
          (this.getToBePaidInvoices().length * 100) / (this.invoiceList.length),
      'completed': (this.getComplatedInvoices().length * 100) /
          (this.invoiceList.length),
      'rejected': (this.getComplatedInvoices().length * 100) /
          (this.invoiceList.length),
    });
    return result;
  }
}
