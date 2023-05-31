import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:watch_flutter/bloc/watch_event.dart';
// import 'package:watch_flutter/bloc/watch_state.dart';
import 'package:watch_flutter/models/persons.dart';
import 'package:watch_flutter/repository/repository.dart';

part 'watch_event.dart';
part 'watch_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Repository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await _userRepository.getDataList();
        final tabs = _splitItemsIntoTabs(users);
        emit(UserLoadedState(tabs));
        emit(FilterState(filteredusers: tabs, currentTabIndex: 0));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });

    on<OnSortEvent>((event, emit) {
      emit(UserLoadingState());
      if (event.selectedSort == 'asc') {
        // print(event.filteredusers);
        emit(FilterState(
            filteredusers: event.filteredusers.map((e) {
              if (event.currentTabIndex == event.filteredusers.indexOf(e)) {
                return e
                  ..sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
                //             final sortedList = List.from(e)..sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
                // return sortedList;
              }
              return e;
            }).toList(),
            currentTabIndex: event.currentTabIndex,
            selectedSort: event.selectedSort));
      } else if (event.selectedSort == 'dsc') {
        // print('dsc');
        emit(FilterState(
            filteredusers: event.filteredusers.map((e) {
              if (event.currentTabIndex == event.filteredusers.indexOf(e)) {
                return e
                  ..sort((a, b) => int.parse(b.id).compareTo(int.parse(a.id)));
              }
              return e;
            }).toList(),
            currentTabIndex: event.currentTabIndex,
            selectedSort: event.selectedSort));
      }
    });
  }

  List<List<Persons>> _splitItemsIntoTabs(List<Persons> items) {
    final tabs = <List<Persons>>[];
    for (int i = 0; i < items.length; i += 25) {
      final endIndex = i + 25;
      final sublist =
          items.sublist(i, endIndex > items.length ? items.length : endIndex);
      tabs.add(sublist);
    }
    return tabs;
  }
}
