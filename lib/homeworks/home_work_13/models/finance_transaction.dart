import 'package:equatable/equatable.dart';

enum TransactionType { income, expense }

class FinanceTransaction extends Equatable {
  const FinanceTransaction({
    required this.id,
    required this.amount,
    required this.description,
    required this.category,
    required this.date,
    required this.type,
  });

  final String id;
  final double amount;
  final String description;
  final String category;
  final DateTime date;
  final TransactionType type;

  bool get isIncome => type == TransactionType.income;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'category': category,
      'date': date.toIso8601String(),
      'type': type.name,
    };
  }

  factory FinanceTransaction.fromJson(Map<String, dynamic> json) {
    return FinanceTransaction(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? 'Інше',
      date: DateTime.parse(json['date'] as String),
      type: _typeFromString(json['type'] as String?),
    );
  }

  FinanceTransaction copyWith({
    String? id,
    double? amount,
    String? description,
    String? category,
    DateTime? date,
    TransactionType? type,
  }) {
    return FinanceTransaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      category: category ?? this.category,
      date: date ?? this.date,
      type: type ?? this.type,
    );
  }

  static TransactionType _typeFromString(String? value) {
    if (value == TransactionType.income.name) return TransactionType.income;
    return TransactionType.expense;
  }

  @override
  List<Object?> get props => [id, amount, description, category, date, type];
}
