import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/remote_data_source/ServerApi.dart';
import '../../../models/user.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial()) {
    on<UsersEvent>((event, emit) async {
      await _getUser(emit);
    });
  }

  Future<void> _getUser(Emitter<UsersState> emit) async {
    emit(GettingUsers());
    try {
      final List<User>? result = await ServerApi.apiClient.getUsersApprovment();
      emit(SuccessGetUsers(result!));
    } catch (e) {
      emit(ErrorGetUsers((e.toString())));
    }
  }
}
