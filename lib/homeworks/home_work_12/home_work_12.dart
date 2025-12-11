import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/firebase_options.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/bloc/habits_bloc.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/bloc/habits_event.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/constants/habit_texts.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/services/auth_repository.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/services/habit_repository.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/widgets/habits_page.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/widgets/login_page.dart';
import 'package:flutter_application_grebenyuk/widgets/app_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWork12 extends StatefulWidget {
  const HomeWork12({super.key});
  static const routeName = '/homework-twelve';

  @override
  State<HomeWork12> createState() => _HomeWork12State();
}

class _HomeWork12State extends State<HomeWork12> {
  late final Future<void> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = _initFirebase();
  }

  Future<void> _initFirebase() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const AppScaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return AppScaffold(
            body: Center(
              child: Text(
                '${HabitTexts.initializationErrorPrefix}${snapshot.error}',
              ),
            ),
          );
        }

        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (_) => AuthRepository()),
            RepositoryProvider(create: (_) => HabitRepository()),
          ],
          child: const _HomeWork12Router(),
        );
      },
    );
  }
}

class _HomeWork12Router extends StatelessWidget {
  const _HomeWork12Router();

  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<AuthRepository>();
    return StreamBuilder<User?>(
      stream: authRepository.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AppScaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;
        if (user == null) {
          return const AppScaffold(body: LoginPage());
        }

        return BlocProvider(
          create: (context) => HabitsBloc(
            habitRepository: context.read<HabitRepository>(),
          )..add(HabitsSubscriptionRequested(user.uid)),
          child: HabitsPage(user: user),
        );
      },
    );
  }
}
