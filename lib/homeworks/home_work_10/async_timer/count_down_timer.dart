import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/dimensions.dart';
import 'package:flutter_application_grebenyuk/constants/text_styles.dart';
import 'package:flutter_application_grebenyuk/constants/ui_texts.dart';
import 'package:flutter_application_grebenyuk/widgets/app_scaffold.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({super.key});
  static const routeName = '/count_down_timer';

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  static const int _durationSeconds = 10;

  Stream<int>? _countdownStream;
  Object? _lastError;

  /// Ініціює таймер, що щосекунди емітить залишок часу.
  // Відправляє залишок часу щосекунди, поки не дійде до нуля.
  Stream<int> countdownTimer({int fromSeconds = _durationSeconds}) async* {
    if (fromSeconds <= 0) {
      throw Exception(AsyncTimerTexts.invalidDurationError);
    }

    for (int value = fromSeconds; value >= 0; value--) {
      yield value;
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  void _startTimer() {
    setState(() {
      _lastError = null;
      _countdownStream = countdownTimer();
    });
  }

  void _startWithError() {
    // Демонструємо обробку помилок, передаючи некоректне значення.
    setState(() {
      _lastError = null;
      _countdownStream = countdownTimer(fromSeconds: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      titleWidget: const Text(
        AsyncTimerTexts.appBarTitle,
        style: AppTextStyles.homeWelcome,
        textAlign: TextAlign.center,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.gap24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<int>(
              stream: _countdownStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  _lastError = snapshot.error;
                  return _StatusCard(
                    text: '${AsyncTimerTexts.errorPrefix}${snapshot.error}',
                    color: Theme.of(context).colorScheme.errorContainer,
                    textColor: Theme.of(context).colorScheme.onErrorContainer,
                  );
                }

                if (!snapshot.hasData) {
                  return const _StatusCard(
                    text: AsyncTimerTexts.idleState,
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return _StatusCard(
                    text: AsyncTimerTexts.finishedState,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    textColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  );
                }

                return _TimerValue(seconds: snapshot.data!);
              },
            ),
            const SizedBox(height: AppDimensions.gap32),
            Wrap(
              spacing: AppDimensions.gap16,
              runSpacing: AppDimensions.gap12,
              alignment: WrapAlignment.center,
              children: [
                FilledButton(
                  onPressed: _startTimer,
                  child: const Text(AsyncTimerTexts.startButton),
                ),
                OutlinedButton(
                  onPressed: _startWithError,
                  child: const Text(AsyncTimerTexts.startWithErrorButton),
                ),
              ],
            ),
            if (_lastError != null) ...[
              const SizedBox(height: AppDimensions.gap20),
              Text(
                '${AsyncTimerTexts.lastErrorPrefix}$_lastError',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TimerValue extends StatelessWidget {
  const _TimerValue({required this.seconds});

  final int seconds;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          seconds.toString().padLeft(2, '0'),
          style: Theme.of(
            context,
          ).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppDimensions.gap12),
        const Text(AsyncTimerTexts.runningDescription),
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.text, this.color, this.textColor});

  final String text;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final Color background = color ?? Theme.of(context).colorScheme.surface;
    final Color foreground =
        textColor ?? Theme.of(context).colorScheme.onSurface;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.gap20),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTextStyles.profileInfo.copyWith(color: foreground),
      ),
    );
  }
}
