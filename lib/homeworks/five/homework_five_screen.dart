import 'package:flutter/material.dart';

class HomeworkFiveScreen extends StatelessWidget {
  const HomeworkFiveScreen({super.key});

  static const routeName = '/homework-five';

  static const _firstImageUrl =
      'https://fastly.picsum.photos/id/179/2048/1365.jpg?hmac=GJyDjrvfBfjPfJPqSBd2pX6sjvsGbG10d21blr5bTS8';
  static const _secondImageUrl =
      'https://fastly.picsum.photos/id/200/1920/1280.jpg?hmac=-eKjMC8-UrbLMpy1A4OWrK0feVPB3Ka5KNOGibQzpRU';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Homework'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Beautiful Images',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            buildWidget(_firstImageUrl),
            const SizedBox(height: 20),
            buildWidget(_secondImageUrl),
            const SizedBox(height: 20),
            _buildAssetWidget(),
            const SizedBox(height: 20),
            const Text(
              'My text',
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWidget(String imageUrl) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.network(
        imageUrl,
        height: 200,
        width: 200,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildAssetWidget() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/images/animal.jpg',
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
