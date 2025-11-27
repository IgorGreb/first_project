import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/dimensions.dart';
import 'package:flutter_application_grebenyuk/constants/text_styles.dart';
import 'package:flutter_application_grebenyuk/constants/ui_texts.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  static const routeName = '/contacts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ContactsScreenTexts.appBarTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final contact in ContactsScreenTexts.contacts) ...[
                      Container(
                        width: double.infinity,
                        padding:
                            const EdgeInsets.all(AppDimensions.cardPadding),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.borderRadiusMedium,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              contact['name']!,
                              style: AppTextStyles.contactsName,
                            ),
                            const SizedBox(height: AppDimensions.gap6),
                            Text(
                              contact['phone']!,
                              style: AppTextStyles.contactsPhone,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppDimensions.gap16),
                    ],
                  ],
                ),
              ),
            ),
            ElevatedButton(
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
