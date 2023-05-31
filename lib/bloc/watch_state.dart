// import '../models/persons.dart';
part of 'watch_bloc.dart';

// @immutable
abstract class UserState {}

class UserLoadingState extends UserState {
  // @override
  // List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  final List<List<Persons>> users;

  UserLoadedState(this.users);
}

class FilterState extends UserState {
  final List<List<Persons>> filteredusers;
  final int currentTabIndex;
  final String? selectedSort;
  FilterState(
      {required this.filteredusers,
      required this.currentTabIndex,
      this.selectedSort});
}

class UserErrorState extends UserState {
  final String error;
  UserErrorState(this.error);
  // @override
  // List<Object?> get props => [error];
}
