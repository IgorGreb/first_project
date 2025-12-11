import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/bloc/finance_cubit.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/constants/finance_texts.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/models/finance_transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinanceCubit, FinanceState>(
      builder: (context, state) {
        if (state.status == FinanceStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.transactions.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                FinanceTexts.emptyTransactions,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            if (index == 0) {
              return _SummarySection(state: state);
            }
            return _TransactionTile(
              transaction: state.transactions[index - 1],
              currency: state.settings.currency,
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemCount: state.transactions.length + 1,
        );
      },
    );
  }
}

class _SummarySection extends StatelessWidget {
  const _SummarySection({required this.state});

  final FinanceState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final expensesCardColor = theme.colorScheme.errorContainer;
    final expensesTextColor = theme.colorScheme.onErrorContainer;
    final incomeCardColor = Colors.green.shade50;
    final incomeTextColor = Colors.green.shade800;
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            title: FinanceTexts.totalExpensesLabel,
            amount: state.totalExpenses,
            currency: state.settings.currency,
            color: expensesCardColor,
            textColor: expensesTextColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            title: FinanceTexts.totalIncomeLabel,
            amount: state.totalIncome,
            currency: state.settings.currency,
            color: incomeCardColor,
            textColor: incomeTextColor,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.amount,
    required this.currency,
    required this.color,
    required this.textColor,
  });

  final String title;
  final double amount;
  final String currency;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: textColor),
            ),
            const SizedBox(height: 8),
            Text(
              '${amount.toStringAsFixed(2)} $currency',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.transaction, required this.currency});

  final FinanceTransaction transaction;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd MMM yyyy');
    final icon =
        transaction.isIncome
            ? Icons.arrow_upward_rounded
            : Icons.arrow_downward_rounded;
    final color =
        transaction.isIncome
            ? Colors.green.shade600
            : Theme.of(context).colorScheme.error;
    final sign = transaction.isIncome ? '+' : '-';
    return Dismissible(
      key: ValueKey(transaction.id),
      direction: DismissDirection.endToStart,
      onDismissed:
          (_) => context.read<FinanceCubit>().deleteTransaction(transaction.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.delete_outline,
          color: Theme.of(context).colorScheme.error,
        ),
      ),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, color: color),
          ),
          title: Text(transaction.description),
          subtitle: Text(
            '${transaction.category} · ${formatter.format(transaction.date)}',
          ),
          trailing: Text(
            '$sign${transaction.amount.toStringAsFixed(2)} $currency',
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
