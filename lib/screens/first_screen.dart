import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}



//main.dart

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<UserBloc>(
//       create: (context) => UserBloc(Repository()),
//       // MultiBlocProvider(
//       //   providers: [
//       //     BlocProvider<UserBloc>(
//       //       create: (BuildContext context) => UserBloc(Repository()),
//       //     ),
//       //   ],
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         // home: const MyHomePage(title: 'Flutter Demo Home Page'),
//         // home: const TabsScreen(),
//         onGenerateRoute: RouteGenerator.generateRoute,
//       ),
//     );
//   }
// }

         // if (state is UserLoadedState) {
          //   List<List<Persons>> tabs = state.users;
          //   return DefaultTabController(
          //     length: tabs.length,
          //     child: Column(
          //       children: [
          //         TabBar(
          //           tabs: tabs.map((tabItems) {
          //             return Tab(
          //               text: 'Tab ${tabs.indexOf(tabItems) + 1}',
          //             );
          //           }).toList(),
          //         ),
          //       ],
          //     ),
          //   );
          // }


          // class Persons {
//   final String id;
//   final String name;
//   final String contacts;
//   String? url;

//   Persons(
//       {required this.id, required this.name, required this.contacts, this.url});

//   factory Persons.fromJson(Map<String, dynamic> json) {
//     return Persons(
//         id: json['id'],
//         name: json['name'] ?? 'First Name',
//         contacts: json['Contacts'] ?? '7904696681',
//         url: json['url']);
//   }
// }