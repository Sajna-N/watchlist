// import 'package:watch_flutter/models/persons.dart';

part of 'watch_bloc.dart';

// @immutable
abstract class UserEvent {
  const UserEvent();
}

class LoadUserEvent extends UserEvent {
  // @override
  // List<Object?> get props => [];
}

class OnSortEvent extends UserEvent {
  final List<List<Persons>> filteredusers;

  final int currentTabIndex;

  final String? selectedSort;
  const OnSortEvent(
      {required this.filteredusers,
      required this.currentTabIndex,
      this.selectedSort});
}
