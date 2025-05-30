import 'package:flutter/material.dart';
import 'package:kebabology_app/core/constants/app_constants.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';

class WeightSlider extends StatelessWidget {
  const WeightSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kebab Weight',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${provider.weight.round()}g',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.accentColor,
                  ),
                ),
                Slider(
                  value: provider.weight,
                  min: 200,
                  max: 600,
                  divisions: 40,
                  activeColor: AppConstants.accentColor,
                  onChanged: provider.updateWeight,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('200g', style: TextStyle(fontSize: 12)),
                    Text('600g', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
