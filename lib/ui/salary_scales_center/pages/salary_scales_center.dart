import 'package:erb_mobo/ui/salary_scales_center/bloc/salaryscales_bloc.dart';
import 'package:erb_mobo/ui/salary_scales_center/widgets/salary_scale_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/common_widgets/app_drawer.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../common/common_widgets/commomn_app_bar.dart';
import '../../../models/salary-scale.dart';
import 'create_new_salary_scale_page.dart';

class SalaryScalesCenter extends StatefulWidget {
  SalaryScalesCenter({Key? key}) : super(key: key);

  @override
  State<SalaryScalesCenter> createState() => _SalaryScalesCenterState();
}

class _SalaryScalesCenterState extends State<SalaryScalesCenter> {
  final SalaryScalesBloc salaryScalesBloc = SalaryScalesBloc();
  late List<SalaryScale> salaryScaleList = [];
  late int activateSalaryScaleIndex = 0;
  @override
  void initState() {
    super.initState();
    salaryScalesBloc.add(GetCompanySalaryScales());
  }

  listenDelettingSalaryScale(int index) {
    setState(() {
      salaryScaleList.removeAt(index);
    });
  }

  listenActivategSalaryScale(int index) {
    setState(() {
      activateSalaryScaleIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: BlocListener(
        bloc: salaryScalesBloc,
        listener: (context, state) {
          if (state is ErrorGettingSalaryScales) {
            ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
                message: 'Faild! complate process.', context: context));
          } else if (state is SuccessGettingSalaryScales) {
            setState(() {
              salaryScaleList = state.salaryScales;
              activateSalaryScaleIndex =
                  salaryScaleList.indexWhere((element) => element.isActive);
            });
          }
        },
        child: Scaffold(
          appBar: commonAppBar(
            context: context,
            title: 'salary scales',
            actions: [
              IconButton(
                onPressed: () async {
                  final bool? shouldRefresh = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateNewSalaryScalePage(),
                    ),
                  );
                  if (shouldRefresh != null) {
                    if (shouldRefresh) {
                      salaryScalesBloc.add(GetCompanySalaryScales());
                    }
                  }
                },
                icon: Icon(
                  Icons.add_circle,
                  size: ScreenUtil().setSp(28),
                ),
              ),
            ],
          ),
          drawer: const AppDrawer(),
          body: BlocBuilder(
            bloc: salaryScalesBloc,
            builder: (context, state) {
              if (state is ErrorGettingSalaryScales) {
                return Center(child: Text('some thing is wrong'));
              } else if (state is GettingSalaryScales) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  strokeWidth: ScreenUtil().setWidth(3),
                ));
              }
              return ListView.builder(
                itemCount: salaryScaleList.length,
                itemBuilder: (BuildContext context, int index) {
                  return SalaryScaleCard(
                    salaryScale: salaryScaleList[index],
                    isActive: activateSalaryScaleIndex == index,
                    index: index,
                    delettingSalaryScaleCallBack: listenDelettingSalaryScale,
                    activateScaleSalaryCallBack: listenActivategSalaryScale,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
