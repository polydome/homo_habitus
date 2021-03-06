import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homo_habitus/data/database.dart';
import 'package:homo_habitus/domain/repository/habit_repository.dart';
import 'package:homo_habitus/domain/repository/progress_repository.dart';
import 'package:homo_habitus/ui/theme.dart';
import 'package:homo_habitus/ui/page/create_habit_page.dart';
import 'package:homo_habitus/ui/page/habit_page.dart';
import 'package:homo_habitus/ui/page/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<AppDatabase>(
      create: (context) => AppDatabase(),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
              create: (context) =>
                  HabitRepository(context.read<AppDatabase>())),
          RepositoryProvider(
              create: (context) => ProgressRepository(
                    context.read<AppDatabase>(),
                  )),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Homo Habitus',
          theme: themeData,
          routes: {
            "/": (context) => const HomePage(),
            "/habit": (context) => const HabitPage(),
            "/create_habit": (context) => const CreateHabitPage()
          },
        ),
      ),
    );
  }
}
