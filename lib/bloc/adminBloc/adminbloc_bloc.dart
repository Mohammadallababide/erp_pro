import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/remote_data_source/ServerApi.dart';
import '../../models/user.dart';
import '../../models/userLeavesCategories.dart';

part 'adminbloc_event.dart';
part 'adminbloc_state.dart';

class AdminblocBloc extends Bloc<AdminblocEvent, AdminblocState> {
  AdminblocBloc() : super(AdminblocInitial()) {
    on<ChangeLeaveCategoryForUser>((event, emit) async {
      await _changeLeaveCategoryForUser(
        emit: emit,
        userId: event.userId,
        userLeavesCategories: event.userLeavesCategories,
      );
    });
  }

  // for leave api
  Future<void> _changeLeaveCategoryForUser({
    required int userId,
    required List<UserLeaveCategorie> userLeavesCategories,
    required Emitter<AdminblocState> emit,
  }) async {
    emit(ChangingLeaveCategoryForUser());
    try {
      User? result = await ServerApi.apiClient.changeLeaveCategoryForUser(
          userId: userId, userLeavesCategories: userLeavesCategories);
      emit(SuccessChangedLeaveCategoryForUser(result!));
    } catch (e) {
      emit(ErrorChangedLeaveCategoryForUser((e.toString())));
    }
  }
}
