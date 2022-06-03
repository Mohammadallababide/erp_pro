import 'package:erb_mobo/ui/department_center/bloc/department_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/common_widgets/app_drawer.dart';
import '../../../common/common_widgets/commomn_app_bar.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../models/department.dart';
import '../widgets/department_center_page_widgets/create_department.dart';
import '../widgets/department_center_page_widgets/department_card.dart';

class DepartmentCenterPage extends StatefulWidget {
  const DepartmentCenterPage({Key? key}) : super(key: key);

  @override
  State<DepartmentCenterPage> createState() => _DepartmentCenterPageState();
}

class _DepartmentCenterPageState extends State<DepartmentCenterPage> {
  final DepartmentBloc departmentBloc = DepartmentBloc();
  late List<Department> departmentsList = [];
  late bool isLoading = true;
  @override
  void initState() {
    super.initState();
    departmentBloc.add(GetDepartments());
  }

  void listenOnCreattedNewDepartmentAction() {
    departmentBloc.add(GetDepartments());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: BlocListener(
        bloc: departmentBloc,
        listener: (context, state) async {
          if (state is SuccessGettedDepartment) {
            await Future.delayed(
              Duration(seconds: 3),
            );
            setState(() {
              departmentsList = state.department;
              isLoading = false;
            });
          } else if (state is ErrorGettedDepatment) {
            await Future.delayed(
              Duration(seconds: 3),
            );
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
                message: 'Faild Getting Jobs !', context: context));
          }
        },
        child: Scaffold(
          appBar: commonAppBar(
            context: context,
            title: 'Departments Center',
            actions: [
              CreateDepatment(
                jobListCallBack: listenOnCreattedNewDepartmentAction,
              ),
            ],
          ),
          drawer: const AppDrawer(),
          body: !isLoading
              ? BlocBuilder(
                  bloc: departmentBloc,
                  builder: (context, state) {
                    if (state is SuccessGettedDepartment) {
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(5),
                          vertical: ScreenUtil().setHeight(10),
                        ),
                        itemCount: departmentsList.length,
                        itemBuilder: (
                          BuildContext context,
                          int index,
                        ) =>
                            DepartmentCard(
                          department: departmentsList[index],
                          index: index,
                        ),
                      );
                    } else if (state is ErrorGettedDepatment) {
                      return Center(
                        child: Text('some thing is wrong'),
                      );
                    }
                    return Container();
                  },
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
        ),
      ),
    );
  }
}
