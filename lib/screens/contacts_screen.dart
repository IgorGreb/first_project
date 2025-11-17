import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/main_page_text.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  static const routeName = '/contacts';

  static const List<Map<String, String>> _contacts = [
    {'name': 'Олена Петрова', 'phone': '+380 50 123 45 67'},
    {'name': 'Максим Іванов', 'phone': '+380 63 987 65 43'},
    {'name': 'Web Academy', 'phone': '+380 44 555 44 33'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(HomePageText.contactsScreenTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final contact in _contacts) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              contact['name']!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              contact['phone']!,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(HomePageText.backButton),
            ),
          ],
        ),
      ),
    );
  }
}
