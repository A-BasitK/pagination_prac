part of 'user_data_pagination_cubit.dart';

@immutable
abstract class UserDataPaginationState {}

class UserDataPaginationInitial extends UserDataPaginationState {}

class UserDataPaginationLoading extends UserDataPaginationState {}

class UserDataPaginationLoaded extends UserDataPaginationState {
  final UserDataModel allUserData;
  UserDataPaginationLoaded({required this.allUserData});
}

class UserDataPaginationError extends UserDataPaginationState {
  final String err;
  UserDataPaginationError({required this.err});
}
