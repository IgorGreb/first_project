import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/bloc/finance_cubit.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/constants/finance_texts.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/view/analytics_page.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/view/settings_page.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/view/transactions_page.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/view/widgets/add_transaction_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinanceTrackerView extends StatefulWidget {
  const FinanceTrackerView({super.key});

  @override
  State<FinanceTrackerView> createState() => _FinanceTrackerViewState();
}

class _FinanceTrackerViewState extends State<FinanceTrackerView> {
  int _currentIndex = 0;

  static const _titles = [
    FinanceTexts.transactionsTab,
    FinanceTexts.analyticsTab,
    FinanceTexts.settingsTab,
  ];

  static const _pages = [
    TransactionsPage(),
    AnalyticsPage(),
    FinanceSettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_currentIndex])),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: FinanceTexts.transactionsTab,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights_outlined),
            label: FinanceTexts.analyticsTab,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: FinanceTexts.settingsTab,
          ),
        ],
      ),
      floatingActionButton:
          _currentIndex == 0 ? _buildAddTransactionButton(context) : null,
    );
  }

  Widget _buildAddTransactionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder:
              (_) => BlocProvider.value(
                value: context.read<FinanceCubit>(),
                child: const AddTransactionSheet(),
              ),
        );
      },
      icon: const Icon(Icons.add),
      label: const Text(FinanceTexts.addTransactionTitle),
    );
  }
}
