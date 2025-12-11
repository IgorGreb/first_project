import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/bloc/finance_cubit.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/constants/finance_texts.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/models/finance_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinanceSettingsPage extends StatefulWidget {
  const FinanceSettingsPage({super.key});

  @override
  State<FinanceSettingsPage> createState() => _FinanceSettingsPageState();
}

class _FinanceSettingsPageState extends State<FinanceSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _budgetController;
  String _currency = FinanceCategories.currencyOptions.first;

  @override
  void initState() {
    super.initState();
    final state = context.read<FinanceCubit>().state;
    _budgetController = TextEditingController(
      text: state.settings.monthlyBudget.toStringAsFixed(0),
    );
    _currency = state.settings.currency;
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FinanceCubit, FinanceState>(
      listenWhen:
          (previous, current) =>
              previous.settings != current.settings &&
              current.status != FinanceStatus.loading,
      listener: (context, state) {
        _budgetController.text = state.settings.monthlyBudget.toStringAsFixed(
          0,
        );
        _currency = state.settings.currency;
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: _currency,
                decoration: const InputDecoration(
                  labelText: FinanceTexts.currencyLabel,
                  border: OutlineInputBorder(),
                ),
                items:
                    FinanceCategories.currencyOptions
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _currency = value);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _budgetController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: FinanceTexts.budgetLimitLabel,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Вкажіть бюджет';
                  }
                  final parsed = double.tryParse(value.replaceAll(',', '.'));
                  if (parsed == null || parsed <= 0) {
                    return 'Некоректне значення';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _submit,
                child: const Text(FinanceTexts.settingsSaveButton),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final budget = double.parse(_budgetController.text.replaceAll(',', '.'));
    final settings = FinanceSettings(
      currency: _currency,
      monthlyBudget: budget,
    );
    await context.read<FinanceCubit>().updateSettings(settings);
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Налаштування збережено')));
  }
}
