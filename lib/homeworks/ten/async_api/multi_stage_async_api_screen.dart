import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/dimensions.dart';
import 'package:flutter_application_grebenyuk/constants/durations.dart';
import 'package:flutter_application_grebenyuk/constants/text_styles.dart';
import 'package:flutter_application_grebenyuk/constants/ui_texts.dart';
import 'package:flutter_application_grebenyuk/widgets/app_scaffold.dart';

class MultiStageAsyncApiScreen extends StatefulWidget {
  const MultiStageAsyncApiScreen({super.key});
  static const String routeName = '/multi_stage_async_api';

  @override
  State<MultiStageAsyncApiScreen> createState() =>
      _MultiStageAsyncApiScreenState();
}

class _MultiStageAsyncApiScreenState extends State<MultiStageAsyncApiScreen> {
  static const int _errorChanceDivisor = 10;

  final Random _random = Random();
  final List<String> _logs = [];

  bool _isLoading = false;
  String? _result;
  String? _error;

  // Список описує послідовність етапів і дозволяє швидко змінювати логіку.
  static const List<_ApiStage> _stages = [
    _ApiStage(
      label: MultiStageApiTexts.stageInit,
      delay: AppDurations.multiStageInitDelay,
      canFail: false,
    ),
    _ApiStage(
      label: MultiStageApiTexts.stageRequest,
      delay: AppDurations.multiStageRequestDelay,
      canFail: true,
    ),
    _ApiStage(
      label: MultiStageApiTexts.stageResponse,
      delay: AppDurations.multiStageResponseDelay,
      canFail: false,
    ),
  ];

  Future<void> fetchDataFromApi() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _logs.clear();
      _result = null;
      _error = null;
    });

    try {
      // Випрацьовуємо всі етапи послідовно, зупиняючись одразу при помилці.
      for (final _ApiStage stage in _stages) {
        await _runStage(stage);
        if (stage.canFail && _random.nextInt(_errorChanceDivisor) == 0) {
          throw Exception(MultiStageApiTexts.errorPrefix);
        }
      }

      setState(() {
        _result = MultiStageApiTexts.successMessage;
        _logs.add('${MultiStageApiTexts.logSuccessPrefix}${_result!}');
      });
    } catch (error) {
      setState(() {
        _error = error.toString();
        _logs.add('${MultiStageApiTexts.logErrorPrefix}${_error!}');
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Додає записи в лог до та після завершення етапу.
  Future<void> _runStage(_ApiStage stage) async {
    setState(() {
      _logs.add(stage.label);
    });
    await Future.delayed(stage.delay);
    setState(() {
      _logs.add('${stage.label}${MultiStageApiTexts.stageCompletedSuffix}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: MultiStageApiTexts.appBarTitle,
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.gap24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : fetchDataFromApi,
              child: const Text(MultiStageApiTexts.startButton),
            ),
            const SizedBox(height: AppDimensions.gap20),
            if (_isLoading) ...[
              const LinearProgressIndicator(),
              const SizedBox(height: AppDimensions.gap12),
            ],
            if (_result != null)
              Text(
                _result!,
                style: AppTextStyles.profileInfo.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            if (_error != null)
              Text(
                _error!,
                style: AppTextStyles.profileInfo.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            const SizedBox(height: AppDimensions.gap12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(AppDimensions.gap16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadiusMedium,
                  ),
                ),
                child:
                    _logs.isEmpty
                        ? const Center(
                          child: Text(MultiStageApiTexts.emptyState),
                        )
                        : ListView.builder(
                          itemCount: _logs.length,
                          itemBuilder:
                              (context, index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppDimensions.gap6,
                                ),
                                child: Text(
                                  _logs[index],
                                  style: AppTextStyles.profileInfo,
                                ),
                              ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ApiStage {
  const _ApiStage({
    required this.label,
    required this.delay,
    required this.canFail,
  });

  final String label;
  final Duration delay;
  final bool canFail;
}
