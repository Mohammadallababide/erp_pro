import 'package:erb_mobo/common/common_widgets/ReceiptDetailsWidgets/ReceiptInfo/rececipt_list_widget.dart';
import 'package:erb_mobo/ui/my_profile/bloc/myprofilebloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceiptList extends StatelessWidget {
  final MyprofileblocBloc myprofileblocBloc;
  const ReceiptList({Key? key, required this.myprofileblocBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      buildWhen: (previous, current) =>
          previous != current && current is SuccessFetchMyProfileInfo ||
          current is ErrorFetchMyProfileInfo,
      bloc: myprofileblocBloc,
      builder: (context, state) {
        if (state is SuccessFetchMyProfileInfo) {
          return ReceiptListWidget(
            receipts: state.user.receipts,
          );
        } else if (state is ErrorFetchMyProfileInfo) {
          return const Center(
            child: Text('some thing is wrong'),
          );
        } else if (state is FetchingMyProfileInfo) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
        return Container();
      },
    );
  }
}
