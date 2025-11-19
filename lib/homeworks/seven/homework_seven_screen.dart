import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/homeworks/seven/widgets/profile_header.dart';
import 'package:flutter_application_grebenyuk/homeworks/seven/widgets/user_status.dart';

class HomeworkSevenScreen extends StatelessWidget {
  const HomeworkSevenScreen({super.key});

  static const routeName = '/homework-seven';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile'), centerTitle: true),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth >= 600;
          final EdgeInsets padding = EdgeInsets.symmetric(
            horizontal: isWide ? 48 : 20,
            vertical: isWide ? 32 : 20,
          );
          final double sectionSpacing = isWide ? 32 : 20;
          final double dividerSpacing = isWide ? 24 : 16;

          return SingleChildScrollView(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileHeader(
                  name: 'Oleksandr',
                  description: 'Flutter Developer',
                  isWide: isWide,
                ),
                SizedBox(height: sectionSpacing),
                const Divider(),
                SizedBox(height: dividerSpacing),
                Text(
                  'About',
                  style: TextStyle(
                    fontSize: isWide ? 20 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'I build mobile experiences with Flutter, Dart, and Firebase.',
                  style: TextStyle(fontSize: isWide ? 16 : 14, height: 1.4),
                ),
                SizedBox(height: sectionSpacing),
                const Divider(),
                SizedBox(height: dividerSpacing),
                UserStatusWidget(projects: 32, followers: 1280, following: 340),
              ],
            ),
          );
        },
      ),
    );
  }
}
