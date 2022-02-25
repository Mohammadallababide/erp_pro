import 'package:bloc/bloc.dart';
import 'package:erb_mobo/data/remote_data_source/ServerApi.dart';
import 'package:erb_mobo/models/user.dart';
import 'package:meta/meta.dart';

part 'myprofilebloc_event.dart';
part 'myprofilebloc_state.dart';

class MyprofileblocBloc extends Bloc<MyprofileblocEvent, MyprofileblocState> {
  MyprofileblocBloc() : super(MyprofileblocInitial()) {
    // on<MyprofileblocEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<FetchMyProfileInfo>((event, emit) async {
      await _fetchMyProfileInfo(emit);
    });
  }
  Future<void> _fetchMyProfileInfo(Emitter<MyprofileblocState> emit) async {
    emit(FetchingMyProfileInfo());
    try {
      final User? result = await ServerApi.apiClient.fetchMyProfile();
      emit(SuccessFetchMyProfileInfo(result!));
    } catch (e) {
      emit(ErrorFetchMyProfileInfo(e.toString()));
    }
  }
}
