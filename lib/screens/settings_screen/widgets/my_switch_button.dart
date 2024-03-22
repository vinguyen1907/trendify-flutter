import 'package:flutter/material.dart';

class MySwitchButton extends StatelessWidget {
  const MySwitchButton({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Switch(
          value: value,
          activeColor: Theme.of(context).colorScheme.secondaryContainer,
          activeTrackColor: Theme.of(context).colorScheme.onSecondaryContainer,
          inactiveTrackColor: Theme.of(context).colorScheme.primaryContainer,
          inactiveThumbColor: Theme.of(context).colorScheme.onPrimaryContainer,
          onChanged: onChanged),
    );
  }
}
