import 'dart:convert';

import 'package:flutter_application_grebenyuk/homeworks/home_work_13/models/finance_settings.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/models/finance_transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinanceRepository {
  static const _transactionsKey = 'finance_transactions';
  static const _settingsKey = 'finance_settings';

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  Future<List<FinanceTransaction>> loadTransactions() async {
    final prefs = await _prefs;
    final rawList = prefs.getStringList(_transactionsKey);
    if (rawList == null) return const [];
    return rawList
        .map(
          (raw) => FinanceTransaction.fromJson(
            jsonDecode(raw) as Map<String, dynamic>,
          ),
        )
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<void> saveTransactions(List<FinanceTransaction> transactions) async {
    final prefs = await _prefs;
    final encoded = transactions
        .map((tx) => jsonEncode(tx.toJson()))
        .toList(growable: false);
    await prefs.setStringList(_transactionsKey, encoded);
  }

  Future<FinanceSettings> loadSettings() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_settingsKey);
    if (raw == null) return const FinanceSettings.initial();
    return FinanceSettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> saveSettings(FinanceSettings settings) async {
    final prefs = await _prefs;
    await prefs.setString(_settingsKey, jsonEncode(settings.toJson()));
  }
}
