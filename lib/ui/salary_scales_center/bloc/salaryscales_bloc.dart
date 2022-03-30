import 'package:bloc/bloc.dart';
import 'package:erb_mobo/data/remote_data_source/ServerApi.dart';
import 'package:meta/meta.dart';

import '../../../models/salary-scale-job.dart';
import '../../../models/salary-scale.dart';

part 'salaryscales_event.dart';
part 'salaryscales_state.dart';

class SalaryScalesBloc extends Bloc<SalaryScalesEvent, SalaryScalesState> {
  SalaryScalesBloc() : super(SalaryScalesInitial()) {
    on<GetCompanySalaryScales>((event, emit) async {
      await _getSalaryScales(emit: emit);
    });
    on<CreateSalaryScales>((event, emit) async {
      await _createSalaryScale(
          emit: emit, salaryScaleJobs: event.salaryScaleJobs);
    });
    on<ActivateSalaryScale>((event, emit) async {
      await _activateSalaryScales(emit: emit, id: event.id);
    });
    on<DeleteSalaryScale>((event, emit) async {
      await _deleteSalaryScales(emit: emit, id: event.id);
    });
  }

  Future<void> _getSalaryScales(
      {required Emitter<SalaryScalesState> emit}) async {
    emit(GettingSalaryScales());
    try {
      final result = await ServerApi.apiClient.getSalaryScales();
      emit(SuccessGettingSalaryScales(result));
    } catch (e) {
      emit(ErrorGettingSalaryScales((e.toString())));
    }
  }

  Future<void> _deleteSalaryScales(
      {required Emitter<SalaryScalesState> emit, required int id}) async {
    emit(DelettingSalaryScale());
    try {
      final result = await ServerApi.apiClient.deleteSalaryScale(id);
      if (result!) {
        emit(SuccessDelettingSalaryScale());
      }
    } catch (e) {
      emit(ErrorDelettingSalaryScale((e.toString())));
    }
  }

  Future<void> _activateSalaryScales(
      {required Emitter<SalaryScalesState> emit, required int id}) async {
    emit(ActivatingSalaryScale());
    try {
      final result = await ServerApi.apiClient.activateSalaryScale(id);

      emit(SuccessAcivateSalaryScale(result));
    } catch (e) {
      emit(ErrorActivateSalaryScale((e.toString())));
    }
  }

  Future<void> _createSalaryScale(
      {required List<SalaryScaleJob> salaryScaleJobs,
      required Emitter<SalaryScalesState> emit}) async {
    emit(CreattingSalaryScale());
    try {
      final result =
          await ServerApi.apiClient.createSalaryScale(salaryScaleJobs);
      emit(SuccessCreattingSalaryScale(result!));
    } catch (e) {
      emit(ErrorCreattingSalaryScale(''));
    }
  }
}
