import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/repos/user_data_repo.dart';
import '../../../models/user_data_model/user_data_model.dart';

part 'user_data_pagination_state.dart';

class UserDataPaginationCubit extends Cubit<UserDataPaginationState> {
  UserDataPaginationCubit() : super(UserDataPaginationInitial()) {
    getUserData(1);
  }

  getUserData(int pageNumber) async {
    if (pageNumber == 1) {
      emit(UserDataPaginationLoading());
    }
    try {
      final userData = await UserDataRepo.userData(pageNumber);

      emit(UserDataPaginationLoaded(allUserData: userData!));
    } catch (e) {
      emit(UserDataPaginationError(err: e.toString()));
    }
  }
}
