// lib/features/privacy/presentation/screens/privacy_policy_screen.dart

import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: AppConstants.accentColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Policy for Kebabologist',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Last updated: ${DateTime.now().year}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const _PolicySection(
              title: 'Information We Collect',
              content:
                  'We do not collect any personal information. All calculations are performed locally on your device.',
            ),
            const _PolicySection(
              title: 'How We Use Information',
              content:
                  'The app uses only the information you input for kebab calculations. No data is transmitted to external servers.',
            ),
            const _PolicySection(
              title: 'Data Storage',
              content:
                  'Your preferences and calculation history are stored locally on your device and are not shared with third parties.',
            ),
            const _PolicySection(
              title: 'External Links',
              content:
                  'Our app contains links to social media platforms. We are not responsible for the privacy practices of these external sites.',
            ),
            const _PolicySection(
              title: 'Contact Us',
              content:
                  'If you have any questions about this Privacy Policy, please contact us through the app store.',
            ),
          ],
        ),
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  final String title;
  final String content;

  const _PolicySection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(content, style: const TextStyle(fontSize: 14, height: 1.5)),
        const SizedBox(height: 24),
      ],
    );
  }
}
