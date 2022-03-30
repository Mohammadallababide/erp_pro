import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'adminbloc_event.dart';
part 'adminbloc_state.dart';

class AdminblocBloc extends Bloc<AdminblocEvent, AdminblocState> {
  AdminblocBloc() : super(AdminblocInitial()) {
    on<AdminblocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
