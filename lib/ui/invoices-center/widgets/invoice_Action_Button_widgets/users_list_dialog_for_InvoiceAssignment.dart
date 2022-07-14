import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common_widgets/commonDialog/confirm_process_Dialog.dart';
import '../../../../models/user.dart';
import '../../../users List/bloc/users_bloc.dart';
import '../../../../common/common_widgets/user_card_tile.dart';
import '../../bloc/invoice_bloc.dart';

class UsersListDialogForInvoicesAssignment extends StatefulWidget {
  final InvoiceBloc invoiceBloc;
  final User? userAssignemt;
  final int invId;

  final Function userActionCallBack;
  UsersListDialogForInvoicesAssignment({
    Key? key,
    required this.invoiceBloc,
    this.userAssignemt,
    required this.invId,
    required this.userActionCallBack,
  }) : super(key: key);

  @override
  State<UsersListDialogForInvoicesAssignment> createState() =>
      _UsersListDialogForInvoicesAssignmentState();
}

class _UsersListDialogForInvoicesAssignmentState
    extends State<UsersListDialogForInvoicesAssignment> {
  UsersBloc usersBloc = UsersBloc();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 5,
        child: ListTile(
          title: Text(
            widget.userAssignemt == null
                ? 'assign invoice'
                : 'un assign invoice',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(14)),
          ),
          subtitle: Text(
            widget.userAssignemt == null
                ? 'by this action you can assign the invoice to the spcifice user.'
                : 'by this action you can drop out the invoice assign from the spcifice user.',
          ),
          trailing: widget.userAssignemt == null
              ? Icon(
                  Icons.assignment_ind,
                  color: Colors.blueAccent,
                )
              : Icon(
                  Icons.remove_circle_outline_rounded,
                  color: Colors.red,
                ),
        ),
      ),
      onTap: () {
        usersBloc.add(GetUsers());
        showAssignOrUnAssignInvoiceOptionDialog();
      },
    );
  }

  Future<void> showAssignOrUnAssignInvoiceOptionDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(5),
                    vertical: ScreenUtil().setHeight(15)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(15),
                        ),
                        child: Text(
                          widget.userAssignemt == null
                              ? "Assign To User :"
                              : "UnAssign From User",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(20)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(200),
                      child: BlocBuilder(
                        buildWhen: (previous, current) =>
                            previous != current && current is SuccessGetUsers,
                        bloc: usersBloc,
                        builder: (context, state) {
                          if (state is GettingUsers) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            );
                          } else if (state is SuccessGetUsers) {
                            return ListView.builder(
                              itemCount: state.users.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () => showConfeirmProcessAlert(
                                    context: context,
                                    cancelProcessFun: () {
                                      Navigator.of(context).pop();
                                    },
                                    submitProcessFun: () {
                                      if (widget.userAssignemt != null) {
                                        // setState(() {
                                        //   widget.userActionCallBack();
                                        // });
                                        widget.invoiceBloc.add(
                                          UnAssignInvoiceToUser(
                                              id: widget.invId,
                                              userId: widget.userAssignemt!.id!,
                                              assignmentNote: 'message'),
                                        );
                                      } else {
                                        setState(() {
                                          widget.userActionCallBack(
                                              state.users[index]);
                                        });
                                        widget.invoiceBloc
                                            .add(AssignInvoiceToUser(
                                          id: widget.invId,
                                          userId: state.users[index].id!,
                                          assignmentNote: 'message',
                                        ));
                                      }
                                      //  this loop for closing the 3 opend dialog ...
                                      for (int i = 0; i < 3; i++) {
                                        Navigator.pop(context);
                                      }
                                    },
                                    prcessedText: 'Are You Sure You Want To ' +
                                        (widget.userAssignemt != null
                                            ? 'unAsign'
                                            : 'Assign') +
                                        'this Receipt?',
                                    icon: (widget.userAssignemt == null)
                                        ? Icon(
                                            Icons.assignment_ind,
                                            color: Colors.blueAccent,
                                          )
                                        : Icon(
                                            Icons.remove_circle_outline_rounded,
                                            color: Colors.red,
                                          ),
                                  ),
                                  child: widget.userAssignemt == null
                                      ? UserTileCard(
                                          isSelected: false,
                                          user: state.users[index],
                                        )
                                      : widget.userAssignemt!.id ==
                                              state.users[index].id!
                                          ? UserTileCard(
                                              isSelected: true,
                                              user: state.users[index],
                                            )
                                          : UserTileCard(
                                              isSelected: false,
                                              user: state.users[index],
                                            ),
                                );
                              },
                            );
                          }
                          return Center(child: Text('some thing wrong ...'));
                        },
                      ),
                    ),
                  ],
                )),
          );
        });
  }
}
