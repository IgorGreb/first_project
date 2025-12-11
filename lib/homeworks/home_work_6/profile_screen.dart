import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/dimensions.dart';
import 'package:flutter_application_grebenyuk/constants/text_styles.dart';
import 'package:flutter_application_grebenyuk/constants/ui_texts.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_6/contacts_screen.dart';
import 'package:flutter_application_grebenyuk/widgets/app_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: ProfileScreenTexts.appBarTitle,
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: AppDimensions.avatarSize,
                  height: AppDimensions.avatarSize,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius:
                        BorderRadius.circular(AppDimensions.borderRadiusMedium),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    ProfileScreenTexts.initials,
                    style: AppTextStyles.profileInitials,
                  ),
                ),
                const SizedBox(width: AppDimensions.gap16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        ProfileScreenTexts.name,
                        style: AppTextStyles.profileName,
                      ),
                      SizedBox(height: AppDimensions.gap8),
                      Text(ProfileScreenTexts.age),
                      SizedBox(height: AppDimensions.gap8),
                      Text(ProfileScreenTexts.job),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.gap32),
            Container(
              padding: const EdgeInsets.all(AppDimensions.cardPadding),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius:
                    BorderRadius.circular(AppDimensions.borderRadiusMedium),
              ),
              child: const Text(
                ProfileScreenTexts.about,
                style: AppTextStyles.profileInfo,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ContactsScreen.routeName);
              },
              child: const Text(ProfileScreenTexts.contactsButton),
            ),
            const SizedBox(height: AppDimensions.gap12),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(ProfileScreenTexts.backButton),
            ),
          ],
        ),
      ),
    );
  }
}
