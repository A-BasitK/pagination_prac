import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_prac/controllers/cubits/user_data_cubit/user_data_pagination_cubit.dart';
import 'package:pagination_prac/views/screens/users_view_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserDataPaginationCubit()),
      ],
      child: MaterialApp(
        home: UsersView(),
      ),
    );
  }
}
