import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/remote_data_source/ServerApi.dart';
import '../../../models/appFile.dart';

part 'common_app_event.dart';
part 'common_app_state.dart';

class CommonAppBloc extends Bloc<CommonAppEvent, CommonAppState> {
  CommonAppBloc() : super(CommonAppInitial()) {
    on<GetAppFile>((event, emit) async {
      await _getAppFile(
        emit: emit,
        fileId: event.id,
      );
    });
  }

  Future<void> _getAppFile({required Emitter emit, required int fileId}) async {
    emit(GettingAppFile());
    try {
      AppFile? file = await ServerApi.apiClient.getAppFile(fileId);
      emit(SuccessGetAppFile(file!));
    } catch (e) {
      emit(ErrorGettingAppFile((e.toString())));
    }
  }
}
