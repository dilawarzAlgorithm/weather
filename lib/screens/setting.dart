import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/provider/setting_notifier.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(savedSettingProvider);
    final notifier = ref.read(savedSettingProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Setting'), centerTitle: false),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _SettingRow(
              label: 'Temperature',
              isSelected: [settings.isCelsius, !settings.isCelsius],
              onPressed: (index) => notifier.toggleTemperature(index),
              children: const [Text('Celsius'), Text('Fahrenheit')],
            ),
            const SizedBox(height: 24),
            _SettingRow(
              label: 'Speed',
              isSelected: [settings.isMph, !settings.isMph],
              onPressed: (index) => notifier.toggleSpeed(index),
              children: const [Text('Mph'), Text('Kph')],
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final String label;
  final List<bool> isSelected;
  final Function(int) onPressed;
  final List<Widget> children;

  const _SettingRow({
    required this.label,
    required this.isSelected,
    required this.onPressed,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        ToggleButtons(
          onPressed: onPressed,
          constraints: const BoxConstraints(minHeight: 40.0, minWidth: 80.0),
          borderRadius: BorderRadius.circular(8),
          selectedColor: Colors.white,
          fillColor: Theme.of(context).colorScheme.primary,
          isSelected: isSelected,
          children: children,
        ),
      ],
    );
  }
}
