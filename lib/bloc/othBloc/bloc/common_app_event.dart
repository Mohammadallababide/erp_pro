part of 'common_app_bloc.dart';

@immutable
abstract class CommonAppEvent {}

class GetAppFile extends CommonAppEvent {
  final int id;

  GetAppFile(this.id);

}