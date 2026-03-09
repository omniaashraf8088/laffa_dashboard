import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_text_styles.dart';

/// Reusable animated page header with gradient title, optional badge & subtitle.
class PageHeader extends StatelessWidget {
  final String title;
  final String? badgeText;
  final String? subtitle;

  const PageHeader({
    super.key,
    required this.title,
    this.badgeText,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppColors.primaryGradient.createShader(bounds),
              child: Text(title, style: AppTextStyles.pageTitle),
            ),
            if (badgeText != null) ...[
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.purpleSubtle,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.purpleBorder),
                ),
                child: Text(badgeText!, style: AppTextStyles.badgePurple),
              ),
            ],
          ],
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.05, end: 0),
        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(
            subtitle!,
            style: AppTextStyles.pageSubtitle,
          ).animate().fadeIn(delay: 100.ms, duration: 500.ms),
        ],
      ],
    );
  }
}
