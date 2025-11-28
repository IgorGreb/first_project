import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/dimensions.dart';
import 'package:flutter_application_grebenyuk/constants/text_styles.dart';
import 'package:flutter_application_grebenyuk/constants/ui_texts.dart';
import 'package:flutter_application_grebenyuk/widgets/app_scaffold.dart';

class AsyncReaTimeCallToApi extends StatefulWidget {
  const AsyncReaTimeCallToApi({super.key});
  static const routeName = '/async_rea_time_call_to_api';

  @override
  State<AsyncReaTimeCallToApi> createState() => _AsyncReaTimeCallToApiState();
}

class _AsyncReaTimeCallToApiState extends State<AsyncReaTimeCallToApi> {
  StreamController<int>? _controller;
  StreamSubscription<int>? _generatorSubscription;
  Stream<int>? _displayStream;

  bool _isRunning = false;
  bool _isPaused = false;
  Object? _lastError;

  /// Повертає стрім, який щосекунди генерує випадкові значення.
  /// Якщо значення > 90 — кидає помилку.
  // Потік симулює зовнішні дані й випадково завершується з помилкою.
  Stream<int> generateRealTimeData() async* {
    final Random random = Random();
    while (true) {
      await Future.delayed(const Duration(seconds: 2));
      final int value = random.nextInt(100) + 1;
      if (value > 90) {
        throw Exception(AsyncRealtimeTexts.invalidValueError(value));
      }
      yield value;
    }
  }

  void _startStream() {
    _resetController(closeExisting: true);

    // Broadcast дозволяє використовувати потік як у StreamBuilder, так і для логів.
    _controller = StreamController<int>.broadcast();
    _displayStream = _controller!.stream;

    _generatorSubscription = generateRealTimeData().listen(
      (value) {
        _controller?.add(value);
      },
      onError: (error, _) {
        _controller?.addError(error);
        _generatorSubscription = null;
        setState(() {
          _lastError = error;
          _isRunning = false;
          _isPaused = false;
        });
      },
      cancelOnError: true,
    );

    setState(() {
      _isRunning = true;
      _isPaused = false;
      _lastError = null;
    });
  }

  void _pauseStream() {
    if (!_isRunning || _generatorSubscription == null) return;
    _generatorSubscription!.pause();
    setState(() {
      _isRunning = false;
      _isPaused = true;
    });
  }

  void _resumeStream() {
    if (!_isPaused || _generatorSubscription == null) return;
    _generatorSubscription!.resume();
    setState(() {
      _isRunning = true;
      _isPaused = false;
    });
  }

  void _stopStream() {
    _resetController(closeExisting: true);
    setState(() {
      _displayStream = null;
      _isRunning = false;
      _isPaused = false;
      _lastError = null;
    });
  }

  void _resetController({required bool closeExisting}) {
    if (closeExisting) {
      _generatorSubscription?.cancel();
      _generatorSubscription = null;
      _controller?.close();
      _controller = null;
    }
  }

  @override
  void dispose() {
    _resetController(closeExisting: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AsyncRealtimeTexts.appBarTitle,
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.gap24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<int>(
              stream: _displayStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return _StatusCard(
                    color: Theme.of(context).colorScheme.errorContainer,
                    textColor: Theme.of(context).colorScheme.onErrorContainer,
                    text:
                        '${AsyncRealtimeTexts.streamErrorPrefix}${snapshot.error}',
                  );
                }

                if (!snapshot.hasData) {
                  return _StatusCard(
                    text:
                        _isPaused
                            ? AsyncRealtimeTexts.pausedState
                            : AsyncRealtimeTexts.idleState,
                  );
                }

                return Column(
                  children: [
                    Text(
                      snapshot.data!.toString(),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.gap12),
                    Text(
                      _isRunning
                          ? AsyncRealtimeTexts.runningState
                          : AsyncRealtimeTexts.stoppedState,
                      style: AppTextStyles.profileInfo,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: AppDimensions.gap32),
            Wrap(
              spacing: AppDimensions.gap16,
              runSpacing: AppDimensions.gap12,
              alignment: WrapAlignment.center,
              children: [
                FilledButton(
                  onPressed: (!_isRunning && !_isPaused) ? _startStream : null,
                  child: const Text(AsyncRealtimeTexts.startButton),
                ),
                OutlinedButton(
                  onPressed: _isRunning ? _pauseStream : null,
                  child: const Text(AsyncRealtimeTexts.pauseButton),
                ),
                FilledButton.tonal(
                  onPressed: _isPaused ? _resumeStream : null,
                  child: const Text(AsyncRealtimeTexts.resumeButton),
                ),
                TextButton(
                  onPressed: _displayStream != null ? _stopStream : null,
                  child: const Text(AsyncRealtimeTexts.stopButton),
                ),
              ],
            ),
            if (_lastError != null) ...[
              const SizedBox(height: AppDimensions.gap20),
              Text(
                '${AsyncRealtimeTexts.lastErrorPrefix}$_lastError',
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

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.text, this.color, this.textColor});

  final String? text;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        color ?? Theme.of(context).colorScheme.surfaceContainerHighest;
    final Color foregroundColor =
        textColor ?? Theme.of(context).colorScheme.onSurfaceVariant;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.gap20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      child: Text(
        text!,
        textAlign: TextAlign.center,
        style: AppTextStyles.profileInfo.copyWith(color: foregroundColor),
      ),
    );
  }
}
