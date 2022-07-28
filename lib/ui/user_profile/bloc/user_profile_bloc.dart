import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/remote_data_source/ServerApi.dart';
import '../../../models/user.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc() : super(UserProfileInitial()) {
    on<GetUserProfile>((event, emit) async {
      await _getUserProfile(emit, event.id);
    });
    on<GetMyProfile>((event, emit) async {
      await _getMyProfile(emit);
    });
  }

  Future<void> _getUserProfile(Emitter<UserProfileState> emit, int id) async {
    emit(GettingUserProfile());
    try {
      final User? result = await ServerApi.apiClient.getUserProfile(id);
      emit(SuccessGettedUserProfile(result!));
    } catch (e) {
      emit(ErrorGettedUserProfile(e.toString()));
    }
  }

  Future<void> _getMyProfile(Emitter<UserProfileState> emit) async {
    emit(GettingMyProfile());
    try {
      final User? result = await ServerApi.apiClient.getMyProfile();
      emit(SuccessGettedMyProfile(result!));
    } catch (e) {
      emit(ErrorGettedMyProfile(e.toString()));
    }
  }
}
