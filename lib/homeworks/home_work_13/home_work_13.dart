import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/bloc/finance_cubit.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/data/finance_repository.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/view/finance_tracker_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWork13 extends StatelessWidget {
  const HomeWork13({super.key});

  static const routeName = '/homework-thirteen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FinanceCubit(repository: FinanceRepository())..loadData(),
      child: const FinanceTrackerView(),
    );
  }
}
