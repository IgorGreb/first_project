part of 'finance_cubit.dart';

enum FinanceStatus { initial, loading, success, failure }

class FinanceState extends Equatable {
  const FinanceState({
    this.status = FinanceStatus.initial,
    this.transactions = const [],
    this.settings = const FinanceSettings.initial(),
    this.errorMessage,
  });

  final FinanceStatus status;
  final List<FinanceTransaction> transactions;
  final FinanceSettings settings;
  final String? errorMessage;

  FinanceState copyWith({
    FinanceStatus? status,
    List<FinanceTransaction>? transactions,
    FinanceSettings? settings,
    String? errorMessage,
  }) {
    return FinanceState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      settings: settings ?? this.settings,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  double get _currentMonthExpenses {
    final now = DateTime.now();
    return transactions
        .where(
          (tx) =>
              !tx.isIncome &&
              tx.date.year == now.year &&
              tx.date.month == now.month,
        )
        .fold(0, (sum, tx) => sum + tx.amount);
  }

  double get _currentMonthIncome {
    final now = DateTime.now();
    return transactions
        .where(
          (tx) =>
              tx.isIncome &&
              tx.date.year == now.year &&
              tx.date.month == now.month,
        )
        .fold(0, (sum, tx) => sum + tx.amount);
  }

  double get totalExpenses => _currentMonthExpenses;

  double get totalIncome => _currentMonthIncome;

  double get balance => totalIncome - totalExpenses;

  double get budgetUsage {
    if (settings.monthlyBudget <= 0) return 0;
    return (totalExpenses / settings.monthlyBudget).clamp(0, 1);
  }

  List<MapEntry<String, double>> get topExpenseCategories {
    final now = DateTime.now();
    final Map<String, double> data = {};
    for (final tx in transactions) {
      if (tx.isIncome) continue;
      if (tx.date.year == now.year && tx.date.month == now.month) {
        data.update(tx.category, (value) => value + tx.amount,
            ifAbsent: () => tx.amount);
      }
    }
    final entries = data.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries.take(3).toList();
  }

  @override
  List<Object?> get props => [status, transactions, settings, errorMessage];
}
