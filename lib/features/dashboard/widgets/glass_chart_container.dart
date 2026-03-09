import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_text_styles.dart';

/// A reusable glassmorphism container for charts with title, subtitle,
/// an optional icon, and a fade-slide entrance animation.
class GlassChartContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget chart;
  final int delay;
  final IconData? icon;

  const GlassChartContainer({
    super.key,
    required this.title,
    required this.subtitle,
    required this.chart,
    this.delay = 0,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.glassSurface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.glassBorder),
            boxShadow: [
              BoxShadow(
                color: AppColors.glassShadow,
                blurRadius: 30,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildHeader(), const SizedBox(height: 24), chart],
          ),
        )
        .animate(delay: Duration(milliseconds: delay))
        .fadeIn(duration: 700.ms)
        .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildHeader() {
    return Row(
      children: [
        if (icon != null) ...[
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.purpleGlow,
                  blurRadius: 12,
                  spreadRadius: -4,
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 14),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: icon != null
                    ? AppTextStyles.chartTitle
                    : AppTextStyles.sectionTitleTight,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: icon != null
                    ? AppTextStyles.itemSubtitle
                    : AppTextStyles.chartSubtitle,
              ),
            ],
          ),
        ),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.primaryGradient,
            boxShadow: [
              BoxShadow(color: AppColors.purpleIndicator, blurRadius: 8),
            ],
          ),
        ),
      ],
    );
  }
}
