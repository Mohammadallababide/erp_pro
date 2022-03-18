import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/remote_data_source/ServerApi.dart';
import '../../../models/job.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  JobBloc() : super(JobInitial()) {
    on<GetJobs>((event, emit) async {
      await _getJobs(emit: emit, page: event.page ?? 1);
    });
    on<CreateJob>((event, emit) async {
      await _createJob(
        emit: emit,
        name: event.name,
        description: event.description,
      );
    });
    on<EditJob>((event, emit) async {
      await _editJob(
        emit: emit,
        name: event.name,
        description: event.description,
        id: event.id,
      );
    });

    on<DeleteJob>((event, emit) async {
      await _deleteJob(
        emit: emit,
        id: event.id,
      );
    });
  }

  Future<void> _createJob({
    required String name,
    required String description,
    required Emitter<JobState> emit,
  }) async {
    emit(CreattingJob());
    try {
      final Job? result =
          await ServerApi.apiClient.createJob(name, description);
      emit(SuccessCreattingJob(result!));
    } catch (e) {
      emit(ErrorCreattingJob((e.toString())));
    }
  }

  Future<void> _editJob({
    required int id,
    required String name,
    required String description,
    required Emitter<JobState> emit,
  }) async {
    emit(EdittingJob());
    try {
      final Job? result = await ServerApi.apiClient.editJob(
        name: name,
        description: description,
        id: id,
      );
      emit(SuccessEdittingJob(result!));
    } catch (e) {
      emit(ErrorEdittingJob((e.toString())));
    }
  }

  Future<void> _deleteJob({
    required int id,
    required Emitter<JobState> emit,
  }) async {
    emit(DelettingJob());
    try {
      final bool? result = await ServerApi.apiClient.deleteJob(id);
      if (result!) {
        emit(SuccessDelettingJob());
      }
    } catch (e) {
      emit(ErrorDelettingJob((e.toString())));
    }
  }

  Future<void> _getJobs({
    required int page,
    required Emitter<JobState> emit,
  }) async {
    emit(GettingJobs());
    try {
      final List<Job> result = await ServerApi.apiClient.getJobs(page);
      emit(SuccessGettingJobs(result));
    } catch (e) {
      emit(ErrorGettingJobs((e.toString())));
    }
  }
}
