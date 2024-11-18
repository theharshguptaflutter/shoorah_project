import 'package:bloc_test/feature/self_assesment/data/data_source/local/assesment_local_data.dart';
import 'package:bloc_test/feature/self_assesment/data/repository_impl/assesment_repo_impl.dart';
import 'package:bloc_test/feature/self_assesment/domain/usecase/get_all_category.dart';
import 'package:bloc_test/feature/self_assesment/presentation/bloc/assesment_bloc.dart';
import 'package:bloc_test/feature/self_assesment/presentation/screen/self_assesment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          lazy: true,
          create: (context) => AssesmentBloc(
                getAllCategory: GetAllCategory(
                  AssesmentRepoImpl(
                    AssesmentLocalDataSourceImpl(),
                  ),
                ),
              )),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloc Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SelfAssessmentsPage(),
    );
  }
}
