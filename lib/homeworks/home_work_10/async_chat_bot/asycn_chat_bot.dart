import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/colors.dart';
import 'package:flutter_application_grebenyuk/constants/dimensions.dart';
import 'package:flutter_application_grebenyuk/constants/durations.dart';
import 'package:flutter_application_grebenyuk/constants/ui_texts.dart';
import 'package:flutter_application_grebenyuk/widgets/app_scaffold.dart';

/// Екран, що демонструє роботу асинхронного чат-бота.
class AsyncChatBot extends StatefulWidget {
  const AsyncChatBot({super.key});
  static const routeName = '/async_chat_bot';

  @override
  State<AsyncChatBot> createState() => _AsyncChatBotState();
}

class _AsyncChatBotState extends State<AsyncChatBot> {
  final Random _random = Random();
  final TextEditingController _textController = TextEditingController();
  final List<_ChatMessage> _messages = []; // Історія повідомлень.
  bool _isLoading = false; // Стан, коли бот готує відповідь.
  Timer? _typingTimer; // Таймер для анімації набору тексту.
  int _typingPhase = 0; // Поточна фаза "..." для тексту "Бот друкує".

  /// Симулює роботу бота на боці "серверу".
  Future<String> simulateChatResponse(String question) async {
    final String normalizedQuestion = question.toLowerCase().trim();

    // Відповідь із даними погоди має власну затримку та повідомлення.
    if (normalizedQuestion.contains('яка погода')) {
      final int temperature = await _fetchRandomTemperature();
      return HomeworkTenTexts.weatherResponse(temperature);
    }

    final int delaySeconds = 2 + _random.nextInt(3); // 2-4 секунди
    await Future.delayed(Duration(seconds: delaySeconds));

    if (normalizedQuestion.contains('погано')) {
      throw Exception(HomeworkTenTexts.errorResponse);
    }

    if (normalizedQuestion.contains('добре')) {
      return HomeworkTenTexts.positiveResponse;
    }

    return HomeworkTenTexts.defaultResponse;
  }

  /// Відправляє питання користувача та опрацьовує відповідь/помилку.
  Future<void> _sendQuestion() async {
    if (_isLoading) return;

    final String question = _textController.text.trim();
    if (question.isEmpty) {
      return;
    }

    setState(() {
      _messages.add(_ChatMessage(text: question, isBot: false));
      _isLoading = true;
    });
    _startTypingAnimation();
    _textController.clear();

    try {
      final String response = await simulateChatResponse(question);
      if (!mounted) return;

      setState(() {
        _messages.add(_ChatMessage(text: response, isBot: true));
      });
    } catch (error) {
      if (!mounted) return;

      final String errorMessage = error.toString().replaceFirst(
        'Exception: ',
        '',
      );
      setState(() {
        _messages.add(
          _ChatMessage(text: errorMessage, isBot: true, isError: true),
        );
      });
    } finally {
      if (!mounted) return;
      _stopTypingAnimation();
      setState(() {
        _typingPhase = 0;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _textController.dispose();
    super.dispose();
  }

  /// Симуляція звернення до зовнішнього API погоди із затримкою в 5 секунд.
  Future<int> _fetchRandomTemperature() async {
    await Future.delayed(AppDurations.weatherFetchDelay);
    return _random.nextInt(35) - 5;
  }

  void _startTypingAnimation() {
    _typingTimer?.cancel();
    _typingTimer = Timer.periodic(AppDurations.typingAnimationStep, (_) {
      if (!mounted) return;
      setState(() {
        _typingPhase = (_typingPhase + 1) % 3;
      });
    });
  }

  void _stopTypingAnimation() {
    _typingTimer?.cancel();
    _typingTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: HomeworkTenTexts.appBarTitle,
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.gap16),
        child: Column(
          children: [
            Expanded(
              child:
                  _messages.isEmpty
                      ? const Center(
                        child: Text(
                          HomeworkTenTexts.emptyChatPlaceholder,
                          textAlign: TextAlign.center,
                        ),
                      )
                      : ListView.builder(
                        // Список відображає як повідомлення користувача, так і бота.
                        padding: const EdgeInsets.only(
                          bottom: AppDimensions.gap16,
                        ),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final _ChatMessage message = _messages[index];
                          final Alignment alignment =
                              message.isBot
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight;
                          final Color bubbleColor =
                              message.isBot
                                  ? AppColors.chatBotBubble
                                  : Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer;

                          return Align(
                            alignment: alignment,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: AppDimensions.gap6,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppDimensions.gap14,
                                vertical: AppDimensions.gap10,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    message.isError
                                        ? AppColors.chatErrorBubble
                                        : bubbleColor,
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.borderRadiusLarge,
                                ),
                              ),
                              child: Text(
                                message.text,
                                style: TextStyle(
                                  color:
                                      message.isError
                                          ? AppColors.chatErrorText
                                          : AppColors.chatDefaultText,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
            ),
            if (_isLoading) ...[
              const SizedBox(height: AppDimensions.gap8),
              // Індикація набору відповіді ботом.
              AnimatedSwitcher(
                duration: AppDurations.typingIndicatorFade,
                child: Text(
                  '${HomeworkTenTexts.typingLabel}${'.' * (_typingPhase + 1)}',
                  key: ValueKey<int>(_typingPhase),
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: AppColors.chatTypingText,
                  ),
                ),
              ),
            ],
            const SizedBox(height: AppDimensions.gap12),
            Row(
              // Панель введення з полем та кнопкою надсилання.
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendQuestion(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.chatInputFill,
                      hintText: HomeworkTenTexts.questionHint,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.gap16,
                        vertical: AppDimensions.gap14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadiusLarge,
                        ),
                        borderSide: const BorderSide(
                          color: AppColors.chatInputBorder,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadiusLarge,
                        ),
                        borderSide: const BorderSide(
                          color: AppColors.chatInputBorder,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadiusLarge,
                        ),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.gap12),
                ElevatedButton(
                  onPressed: _isLoading ? null : _sendQuestion,
                  child: const Text(HomeworkTenTexts.sendButton),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.gap16),
          ],
        ),
      ),
    );
  }
}

/// Модель одного повідомлення в історії чату.
class _ChatMessage {
  final String text;
  final bool isBot;
  final bool isError;

  const _ChatMessage({
    required this.text,
    required this.isBot,
    this.isError = false,
  });
}
