import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_flutter/bloc/watch_bloc.dart';
import 'package:watch_flutter/repository/repository.dart';
import 'package:watch_flutter/screens/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Repository(),
      child: BlocProvider(
        create: (context) => UserBloc(
          RepositoryProvider.of<Repository>(context),
        )..add(LoadUserEvent()),
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const TabsScreen(),
        ),
      ),
    );
  }
}
