part of 'job_bloc.dart';

@immutable
abstract class JobEvent {}

class GetJobs extends JobEvent {
  final int? page;
  final int? limit;

  GetJobs({
    this.page,
    this.limit,
  });
}

class CreateJob extends JobEvent {
  final String name;
  final String description;

  CreateJob({
    required this.name,
    required this.description,
  });
}

class EditJob extends JobEvent {
  final int id;
  final String name;
  final String description;

  EditJob({
    required this.id,
    required this.name,
    required this.description,
  });
}

class DeleteJob extends JobEvent {
  final int id;

  DeleteJob(this.id);
}
