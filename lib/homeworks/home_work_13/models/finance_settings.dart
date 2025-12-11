import 'package:equatable/equatable.dart';

class FinanceSettings extends Equatable {
  const FinanceSettings({
    required this.currency,
    required this.monthlyBudget,
  });

  const FinanceSettings.initial()
      : currency = 'UAH',
        monthlyBudget = 20000;

  final String currency;
  final double monthlyBudget;

  FinanceSettings copyWith({
    String? currency,
    double? monthlyBudget,
  }) {
    return FinanceSettings(
      currency: currency ?? this.currency,
      monthlyBudget: monthlyBudget ?? this.monthlyBudget,
    );
  }

  Map<String, dynamic> toJson() => {
        'currency': currency,
        'monthlyBudget': monthlyBudget,
      };

  factory FinanceSettings.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const FinanceSettings.initial();
    return FinanceSettings(
      currency: json['currency'] as String? ?? 'UAH',
      monthlyBudget: (json['monthlyBudget'] as num?)?.toDouble() ?? 20000,
    );
  }

  @override
  List<Object?> get props => [currency, monthlyBudget];
}
