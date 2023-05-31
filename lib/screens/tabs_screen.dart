import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_flutter/models/persons.dart';

import '../bloc/watch_bloc.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key, Key? key1});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen>
    with SingleTickerProviderStateMixin {
  List<List<Persons>> allList = [];
  late TabController _tabController;

  String? isSelected;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final List<String> tabs = <String>[
    //   'Contact 1',
    //   'Contact 2',
    //   'Contact 3',
    //   'Contact 4',
    // ];
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Watchlist'),
      // ),
      body: bodyContent(),
    );
  }

  Widget bodyContent() {
    return SafeArea(
      // BlocProvider(
      //   create: (context) => UserBloc(
      //     Repository(),
      //   )..add(LoadUserEvent()),
      child: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoadedState) {
            allList = state.users;
            _tabController =
                TabController(length: state.users.length, vsync: this);
          }
        },
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserErrorState) {
            return const Center(child: Text("Error"));
          }
          if (state is FilterState) {
            final tabs = state.filteredusers;
            return Column(
              children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.blue),
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                        child: Row(
                          children: const [
                            SizedBox(width: 10),
                            Text(
                              'WatchList',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TabBar(
                        onTap: (tabIndex) {
                          isSelected = '';

                          context.read<UserBloc>().add(OnSortEvent(
                              filteredusers: allList,
                              currentTabIndex: tabIndex,
                              selectedSort: 'asc'));
                        },
                        controller: _tabController,
                        isScrollable: true,
                        tabs: _buildTabBarTabs(tabs),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: _buildTabBarViews(tabs, context),
                  ),
                ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }

  List<Widget> _buildTabBarTabs(List<List<Persons>> tabs) {
    return tabs.map((tabItems) {
      return Tab(
        child: Text(
          'Group ${tabs.indexOf(tabItems) + 1}',
          style: const TextStyle(color: Colors.black, fontSize: 15),
        ),
      );
    }).toList();
  }

  List<Widget> _buildTabBarViews(List<List<Persons>> tabs, context) {
    double height = MediaQuery.of(context).size.height;
    return tabs.map((tabItems) {
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey.shade200),
            child: ListView.builder(
              // physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: tabItems.length,
              itemBuilder: (context, index) {
                final item = tabItems[index];
                return Container(
                  margin: EdgeInsets.only(bottom: height * 0.01),
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(item.contacts),
                    // trailing: const Icon(Icons.person),
                    trailing: Text(item.id),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.rectangle,
              ),
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return BlocConsumer<UserBloc, UserState>(
                        listener: (context, state) {
                          if (state is FilterState) {
                            isSelected = state.selectedSort!;
                          }
                        },
                        builder: (context, state) {
                          return SizedBox(
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      16.0, 16.0, 16.0, 0),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          'Sort By',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(right: 16.0),
                                          child: Text(
                                            'Done',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                ListTile(
                                  title: Row(
                                    children: [
                                      const Text('User ID'),
                                      const Spacer(),
                                      TextButton(
                                        onPressed: () {
                                          context
                                              .read<UserBloc>()
                                              .add(OnSortEvent(
                                                filteredusers: allList,
                                                currentTabIndex:
                                                    _tabController.index,
                                                selectedSort: 'asc',
                                              ));
                                        },
                                        child: Text(
                                          '0 \u{2193} 9',
                                          style: TextStyle(
                                              color: isSelected == null
                                                  ? Colors.black
                                                  : isSelected! == 'asc'
                                                      ? Colors.blue
                                                      : Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context
                                              .read<UserBloc>()
                                              .add(OnSortEvent(
                                                filteredusers: allList,
                                                currentTabIndex:
                                                    _tabController.index,
                                                selectedSort: 'dsc',
                                              ));
                                        },
                                        child: Text(
                                          '9 \u{2191} 0',
                                          style: TextStyle(
                                              color: isSelected == null
                                                  ? Colors.black
                                                  : isSelected! == 'dsc'
                                                      ? Colors.blue
                                                      : Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    // Handle User ID sorting action
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                icon: const Icon(Icons.sort),
                color: Colors.black,
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  // List<Widget> _buildTabBar(List<Persons> tabs) {
  //   return tabs.map((tabItems) {
  //     return Tab(
  //       text: 'Tab ${tabs.indexOf(tabItems) + 1}',
  //     );
  //   }).toList();
  // }

  // Expanded(
  //                   child: ListView.builder(
  //                       itemCount: tabs.length,
  //                       itemBuilder: (_, index) {
  //                         return Padding(
  //                           padding: const EdgeInsets.symmetric(
  //                               vertical: 12, horizontal: 12),
  //                           child: Card(
  //                               color: Theme.of(context).primaryColor,
  //                               child: ListTile(
  //                                 contentPadding: const EdgeInsets.all(8),
  //                                 // minVerticalPadding: ,
  //                                 title: Text(
  //                                   '${tabs[index].name} ',
  //                                   style: const TextStyle(
  //                                       color: Colors.white, fontSize: 20),
  //                                 ),
  //                                 subtitle: Text(
  //                                   tabs[index].contacts,
  //                                   style: const TextStyle(
  //                                       color: Colors.white, fontSize: 15),
  //                                 ),
  //                                 trailing: CircleAvatar(
  //                                   // backgroundImage:
  //                                   //     NetworkImage(userList[index].url.toString()),
  //                                   child: Text(
  //                                     tabs[index].id,
  //                                   ),
  //                                   // backgroundColor: Colors.white,
  //                                 ),
  //                               )),
  //                         );
  //                       }),
  //                 ),
}
