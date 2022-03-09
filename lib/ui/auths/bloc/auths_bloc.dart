import 'package:bloc/bloc.dart';
import 'package:erb_mobo/data/remote_data_source/ServerApi.dart';
import 'package:erb_mobo/models/user.dart';

import '../../../models/imageModel.dart';

part 'auths_event.dart';
part 'auths_state.dart';

class AuthsBloc extends Bloc<AuthsEvent, AuthsState> {
  AuthsBloc() : super(AuthsInitial()) {
    on<SingUp>((event, emit) async {
      await _signUp(
        emit: emit,
        email: event.email,
        firstName: event.firstName,
        lastName: event.lastName,
        password: event.password,
        phoneNumber: event.phoneNumber,
      );
    });

    on<SingIn>((event, emit) async {
      await _sigIn(event.email, event.password, emit);
    });

    on<GetUsersSignupRequests>((event, emit) async {
      await _getUserSignupRequests(emit);
    });

    on<ApproveSignupUser>((event, emit) async {
      await _approveSignupUser(event.id, emit);
    });


  on<RejectSignupUser>((event, emit) async {
      await _rejectSignupUser(event.id, emit);
    });

    on<UploadImage>((event, emit) async {
      await _uploadImage(event.filePath, emit);
    });
  }

  Future<void> _uploadImage(String path, Emitter<AuthsState> emit) async {
    emit(ProcessingApproveSignupUser());
    try {
      final ImageModel = await ServerApi.apiClient.uploadImage(path);
      emit(SucessUploadImage(ImageModel!));
    } catch (e) {
      emit(ErrorApproveSignupUser((e.toString())));
    }
  }

  Future<void> _approveSignupUser(int id, Emitter<AuthsState> emit) async {
    emit(ProcessingApproveSignupUser());
    try {
      final result = await ServerApi.apiClient.approveSignupUser(id);
      emit(SuccessApproveSignupUser(result!));
    } catch (e) {
      emit(ErrorApproveSignupUser((e.toString())));
    }
  }

  


    Future<void> _rejectSignupUser(int id, Emitter<AuthsState> emit) async {
    emit(ProcessingApproveSignupUser());
    try {
      final result = await ServerApi.apiClient.rejectSignupUser(id);
      emit(SuccessRejectSignupUser(result!));
    } catch (e) {
      emit(ErrorRejectSignupUser((e.toString())));
    }
  }

  Future<void> _getUserSignupRequests(Emitter<AuthsState> emit) async {
    emit(GettingSignupUsersRequests());
    try {
      final List<User> result =
          await ServerApi.apiClient.getUsersRequestsSignupApprovment();
      emit(SucessGettingSignupUsersRequests(result));
    } catch (e) {
      emit(ErrorGettingSignupUsersRequests((e.toString())));
    }
  }

  Future<void> _signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
    required Emitter<AuthsState> emit,
  }) async {
    emit(AuthProcessing());
    try {
      final String message = await ServerApi.apiClient.signUp(
          phoneNumber: phoneNumber,
          email: email,
          firstName: firstName,
          lastName: lastName,
          password: password);
      emit(SuccessSingUp(message));
    } catch (e) {
      emit(ErrorSingUp((e.toString())));
    }
  }

  Future<void> _sigIn(
      String email, String password, Emitter<AuthsState> emit) async {
    emit(AuthProcessing());
    try {
      final User? user =
          await ServerApi.apiClient.signIn(email: email, password: password);
      emit(SuccessSingIn(user!));
    } catch (e) {
      emit(ErrorSingIn((e.toString())));
    }
  }
}
