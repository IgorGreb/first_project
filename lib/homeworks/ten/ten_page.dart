import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/dimensions.dart';
import 'package:flutter_application_grebenyuk/constants/text_styles.dart';
import 'package:flutter_application_grebenyuk/constants/ui_texts.dart';
import 'package:flutter_application_grebenyuk/homeworks/ten/async_api/multi_stage_async_api_screen.dart';
import 'package:flutter_application_grebenyuk/homeworks/ten/async_chat_bot/asycn_chat_bot.dart';
import 'package:flutter_application_grebenyuk/homeworks/ten/async_real_time_data/async_rea_time_call_to_api.dart';
import 'package:flutter_application_grebenyuk/homeworks/ten/async_timer/count_down_timer.dart';
import 'package:flutter_application_grebenyuk/widgets/app_scaffold.dart';

class TenPage extends StatelessWidget {
  const TenPage({super.key});
  static const routeName = '/homework-ten';

  static final List<_HomeWorkButtonData> _buttons = [
    const _HomeWorkButtonData(
      title: TenPageTexts.chatBot,
      routeName: AsyncChatBot.routeName,
    ),
    const _HomeWorkButtonData(
      title: TenPageTexts.asyncCountdown,
      routeName: CountDownTimer.routeName,
    ),
    const _HomeWorkButtonData(
      title: TenPageTexts.asyncCallToApi,
      routeName: AsyncReaTimeCallToApi.routeName,
    ),
    const _HomeWorkButtonData(
      title: TenPageTexts.asyncMultiStage,
      routeName: MultiStageAsyncApiScreen.routeName,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      titleWidget: const Text(
        TenPageTexts.homeworkTenTitle,
        style: AppTextStyles.homeWelcome,
        textAlign: TextAlign.center,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.gap20),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: AppDimensions.gap20,
          crossAxisSpacing: AppDimensions.gap20,
          children:
              _buttons
                  .map(
                    (button) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.borderRadiusSmall,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, button.routeName);
                      },
                      child: Text(
                        button.title,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.homeButton,
                      ),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}

class _HomeWorkButtonData {
  const _HomeWorkButtonData({required this.title, required this.routeName});

  final String title;
  final String routeName;
}
