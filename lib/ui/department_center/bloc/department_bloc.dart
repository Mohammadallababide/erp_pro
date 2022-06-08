import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/remote_data_source/ServerApi.dart';
import '../../../models/department.dart';
part 'department_event.dart';
part 'department_state.dart';

class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  DepartmentBloc() : super(DepartmentInitial()) {
    on<CreateNewDepartment>((event, emit) async {
      await _createDepartment(
        emit: emit,
        maxNumberOfEmployees: event.maxNumberOfEmployees,
        title: event.title,
      );
    });

    on<GetDepartments>((event, emit) async {
      await _getDepartment(
        emit: emit,
      );
    });

    on<GetDepartmentById>((event, emit) async {
      await _getDepartmentById(
        emit: emit,
        id: event.id,
      );
    });

    on<EditDepartment>((event, emit) async {
      await _editDepartment(
        emit: emit,
        maxNumberOfEmployees: event.maxNumberOfEmployees,
        title: event.title,
        id: event.id,
      );
    });
    on<AddUserToDepartment>((event, emit) async {
      await _addUsersToDepartment(
        emit: emit,
        id: event.id,
        usersId: event.usersId,
      );
    });
    on<MarkUsersAsMangerOfDepartment>((event, emit) async {
      await _markUserAsMangerOfDepartment(
        emit: emit,
        id: event.id,
        userId: event.userId,
      );
    });
  }
  Future<void> _createDepartment({
    required int maxNumberOfEmployees,
    required String title,
    required Emitter<DepartmentState> emit,
  }) async {
    emit(CreattingNewDepartment());
    try {
      await ServerApi.apiClient.createDepartment(
        maxNumberOfEmployees: maxNumberOfEmployees,
        title: title,
      );
      emit(SuccessCreattedDepartment());
    } catch (e) {
      emit(ErrorCreattedDepartment((e.toString())));
    }
  }

  Future<void> _getDepartmentById({
    required Emitter<DepartmentState> emit,
    required int id,
  }) async {
    emit(GettingDepartmentById());
    try {
      Department? result = await ServerApi.apiClient.getDepartmentById(id);
      emit(SuccessGettedDepartmentById(result!));
    } catch (e) {
      emit(ErrorGettedDepatmentById((e.toString())));
    }
  }

  Future<void> _getDepartment({
    required Emitter<DepartmentState> emit,
  }) async {
    emit(GettingDepartments());
    try {
      List<Department>? result = await ServerApi.apiClient.getDepartments();
      emit(SuccessGettedDepartment(result!));
    } catch (e) {
      emit(ErrorGettedDepatment((e.toString())));
    }
  }

  Future<void> _editDepartment(
      {required int maxNumberOfEmployees,
      required String title,
      required int id,
      required Emitter<DepartmentState> emit}) async {
    emit(EdittingDepartment());
    try {
      Department? result = await ServerApi.apiClient.editDepartment(
        maxNumberOfEmployees: maxNumberOfEmployees,
        title: title,
        id: id,
      );
      emit(SuccessEdittedDepartment(result!));
    } catch (e) {
      emit(ErrorEdittedDepartment((e.toString())));
    }
  }

  Future<void> _addUsersToDepartment(
      {required List<int> usersId,
      required int id,
      required Emitter<DepartmentState> emit}) async {
    emit(AddingUsersToDepartment());
    try {
      await ServerApi.apiClient.addUsersToDepartment(usersId: usersId, id: id);
      emit(SuccessAddedUsersToDepartment());
    } catch (e) {
      emit(ErrorCreattedDepartment((e.toString())));
    }
  }

  Future<void> _markUserAsMangerOfDepartment(
      {required int userId,
      required int id,
      required Emitter<DepartmentState> emit}) async {
    emit(AddingUsersToDepartment());
    try {
      await ServerApi.apiClient
          .markUserAsMangerOfDepartment(userId: userId, id: id);
      emit(SuccessAddedUsersToDepartment());
    } catch (e) {
      emit(ErrorCreattedDepartment((e.toString())));
    }
  }
}
