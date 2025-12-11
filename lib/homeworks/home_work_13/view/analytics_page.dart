import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/bloc/finance_cubit.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/constants/finance_texts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinanceCubit, FinanceState>(
      builder: (context, state) {
        if (state.status == FinanceStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.transactions.isEmpty) {
          return Center(
            child: Text(
              FinanceTexts.noAnalyticsData,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _AnalyticsCard(
              title: FinanceTexts.balanceLabel,
              value:
                  '${state.balance.toStringAsFixed(2)} ${state.settings.currency}',
            ),
            const SizedBox(height: 12),
            _BudgetUsageCard(state: state),
            const SizedBox(height: 12),
            _TopCategoriesCard(state: state),
          ],
        );
      },
    );
  }
}

class _AnalyticsCard extends StatelessWidget {
  const _AnalyticsCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _BudgetUsageCard extends StatelessWidget {
  const _BudgetUsageCard({required this.state});

  final FinanceState state;

  @override
  Widget build(BuildContext context) {
    final used = state.totalExpenses;
    final available = state.settings.monthlyBudget;
    final remaining = (available - used).clamp(0, available);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              FinanceTexts.budgetUsageLabel,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(value: state.budgetUsage),
            const SizedBox(height: 8),
            Text(
              '${used.toStringAsFixed(2)} / ${available.toStringAsFixed(0)} ${state.settings.currency}',
            ),
            Text(
              'Залишок: ${remaining.toStringAsFixed(2)} ${state.settings.currency}',
            ),
          ],
        ),
      ),
    );
  }
}

class _TopCategoriesCard extends StatelessWidget {
  const _TopCategoriesCard({required this.state});

  final FinanceState state;

  @override
  Widget build(BuildContext context) {
    final entries = state.topExpenseCategories;
    if (entries.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            FinanceTexts.noAnalyticsData,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              FinanceTexts.topCategoriesLabel,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            ...entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key),
                    Text(
                      '${entry.value.toStringAsFixed(2)} ${state.settings.currency}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
