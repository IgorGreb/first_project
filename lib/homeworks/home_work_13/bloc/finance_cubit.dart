import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/data/finance_repository.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/models/finance_settings.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/models/finance_transaction.dart';

part 'finance_state.dart';

class FinanceCubit extends Cubit<FinanceState> {
  FinanceCubit({required FinanceRepository repository})
    : _repository = repository,
      super(const FinanceState());

  final FinanceRepository _repository;

  Future<void> loadData() async {
    emit(state.copyWith(status: FinanceStatus.loading, errorMessage: null));
    try {
      final settings = await _repository.loadSettings();
      final transactions = await _repository.loadTransactions();
      emit(
        state.copyWith(
          status: FinanceStatus.success,
          settings: settings,
          transactions: transactions,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: FinanceStatus.failure,
          errorMessage: 'Не вдалося завантажити дані: $error',
        ),
      );
    }
  }

  Future<void> addTransaction({
    required double amount,
    required String description,
    required String category,
    required DateTime date,
    required TransactionType type,
  }) async {
    final transaction = FinanceTransaction(
      id: _generateId(),
      amount: amount,
      description: description,
      category: category,
      date: date,
      type: type,
    );
    final updated = [transaction, ...state.transactions];
    emit(state.copyWith(transactions: updated));
    await _repository.saveTransactions(updated);
  }

  Future<void> deleteTransaction(String id) async {
    final updated =
        state.transactions
            .where((transaction) => transaction.id != id)
            .toList();
    emit(state.copyWith(transactions: updated));
    await _repository.saveTransactions(updated);
  }

  Future<void> updateSettings(FinanceSettings settings) async {
    emit(state.copyWith(settings: settings));
    await _repository.saveSettings(settings);
  }

  String _generateId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(9999);
    return '$timestamp-$random';
  }
}
