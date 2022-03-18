part of 'job_bloc.dart';

@immutable
abstract class JobState {}

class JobInitial extends JobState {}

class GettingJobs extends JobState {}

class SuccessGettingJobs extends JobState {
  final List<Job> jobs;

  SuccessGettingJobs(this.jobs);
}

class ErrorGettingJobs extends JobState {
  final String error;

  ErrorGettingJobs(this.error);
}

class CreattingJob extends JobState {}

class SuccessCreattingJob extends JobState {
  final Job job;

  SuccessCreattingJob(this.job);
}

class ErrorCreattingJob extends JobState {
  final String error;

  ErrorCreattingJob(this.error);
}

class EdittingJob extends JobState {}

class SuccessEdittingJob extends JobState {
  final Job job;

  SuccessEdittingJob(this.job);
}

class ErrorEdittingJob extends JobState {
  final String error;

  ErrorEdittingJob(this.error);
}

class DelettingJob extends JobState {}

class SuccessDelettingJob extends JobState {}

class ErrorDelettingJob extends JobState {
  final String error;

  ErrorDelettingJob(this.error);
}
