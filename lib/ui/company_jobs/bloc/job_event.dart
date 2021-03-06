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
  final int departmentId;
  CreateJob( {
    required this.name,
    required this.description,
    required this.departmentId,
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

class AssignJobToUser extends JobEvent {
  final int userId;
  final int jobId;
  final String level;

  AssignJobToUser({
    required this.userId,
    required this.jobId,
    required this.level,
  });
}
