import 'package:flutter/material.dart';
import '../../../core/theme/app_text_styles.dart';

/// A legend row showing colored dot + label + percentage value.
class ChartLegend extends StatelessWidget {
  final Map<String, double> data;
  final List<Color> colors;
  final bool compact;

  const ChartLegend({
    super.key,
    required this.data,
    required this.colors,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final entries = data.entries.toList();

    if (compact) {
      return Wrap(
        spacing: 16,
        runSpacing: 8,
        children: entries.asMap().entries.map((entry) {
          final c = colors[entry.key % colors.length];
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _dot(c),
              const SizedBox(width: 6),
              Text(
                '${entry.value.key} (${entry.value.value.toInt()}%)',
                style: AppTextStyles.legendLabelSmall,
              ),
            ],
          );
        }).toList(),
      );
    }

    return Column(
      children: entries.asMap().entries.map((entry) {
        final c = colors[entry.key % colors.length];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              _dot(c),
              const SizedBox(width: 10),
              Expanded(
                child: Text(entry.value.key, style: AppTextStyles.legendLabel),
              ),
              Text(
                '${entry.value.value.toInt()}%',
                style: AppTextStyles.legendValue,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _dot(Color c) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(3),
        boxShadow: [BoxShadow(color: c.withAlpha(80), blurRadius: 6)],
      ),
    );
  }
}
