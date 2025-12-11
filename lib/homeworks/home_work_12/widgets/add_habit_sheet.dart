import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/bloc/habits_bloc.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/bloc/habits_event.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/constants/habit_dimens.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/constants/habit_texts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddHabitSheet extends StatefulWidget {
  const AddHabitSheet({super.key, required this.userId});

  final String userId;

  @override
  State<AddHabitSheet> createState() => _AddHabitSheetState();
}

class _AddHabitSheetState extends State<AddHabitSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateFormat = DateFormat('dd MMM yyyy');
  String _selectedFrequency = HabitTexts.frequencyDaily;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: _selectedDate,
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<HabitsBloc>().add(
          HabitAddedRequested(
            userId: widget.userId,
            name: _nameController.text.trim(),
            frequency: _selectedFrequency,
            startDate: _selectedDate,
          ),
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: HabitDimens.pagePadding,
        right: HabitDimens.pagePadding,
        top: HabitDimens.spaceLG,
        bottom: MediaQuery.of(context).viewInsets.bottom + HabitDimens.spaceLG,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              HabitTexts.addHabitTitle,
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: HabitDimens.spaceLG),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: HabitTexts.habitNameLabel,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return HabitTexts.nameValidationError;
                }
                return null;
              },
            ),
            const SizedBox(height: HabitDimens.spaceMD),
            DropdownButtonFormField<String>(
              value: _selectedFrequency,
              items: const [
                DropdownMenuItem(
                  value: HabitTexts.frequencyDaily,
                  child: Text(HabitTexts.frequencyDaily),
                ),
                DropdownMenuItem(
                  value: HabitTexts.frequencyWeekly,
                  child: Text(HabitTexts.frequencyWeekly),
                ),
                DropdownMenuItem(
                  value: HabitTexts.frequencyWeekdays,
                  child: Text(HabitTexts.frequencyWeekdays),
                ),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _selectedFrequency = value);
              },
              decoration: const InputDecoration(
                labelText: HabitTexts.frequencyLabel,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: HabitDimens.spaceMD),
            InkWell(
              onTap: _pickDate,
              borderRadius: BorderRadius.circular(HabitDimens.cardRadius),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: HabitTexts.startDateLabel,
                  border: OutlineInputBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_dateFormat.format(_selectedDate)),
                    const Icon(Icons.calendar_today_outlined),
                  ],
                ),
              ),
            ),
            const SizedBox(height: HabitDimens.spaceLG),
            FilledButton(
              onPressed: _submit,
              child: const Text(HabitTexts.saveHabit),
            ),
          ],
        ),
      ),
    );
  }
}
