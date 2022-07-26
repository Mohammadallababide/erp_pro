part of 'adminbloc_bloc.dart';

@immutable
abstract class AdminblocEvent {}

class ChangeLeaveCategoryForUser extends AdminblocEvent {
  final int userId;
  final List<LeaveCategory> userLeavesCategories;

  ChangeLeaveCategoryForUser({
    required this.userId,
    required this.userLeavesCategories,
  });
}
