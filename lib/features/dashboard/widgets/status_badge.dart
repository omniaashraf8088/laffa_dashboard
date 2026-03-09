import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_text_styles.dart';

/// Status badge widget with glow effect and animated dot.
class StatusBadge extends StatefulWidget {
  final String status;
  const StatusBadge({super.key, required this.status});

  @override
  State<StatusBadge> createState() => _StatusBadgeState();
}

class _StatusBadgeState extends State<StatusBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _pulse = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    if (_isActive) _pulseController.repeat(reverse: true);
  }

  bool get _isActive =>
      widget.status.toLowerCase() == 'active' ||
      widget.status.toLowerCase() == 'in progress';

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final (color, bgColor) = _getColors();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withAlpha(40)),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(20),
            blurRadius: 8,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isActive)
            AnimatedBuilder(
              animation: _pulse,
              builder: (context, _) {
                return Container(
                  width: 7,
                  height: 7,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    boxShadow: [
                      BoxShadow(
                        color: color.withAlpha((150 * _pulse.value).toInt()),
                        blurRadius: 6 * _pulse.value,
                      ),
                    ],
                  ),
                );
              },
            )
          else
            Container(
              width: 7,
              height: 7,
              margin: const EdgeInsets.only(right: 6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withAlpha(180),
              ),
            ),
          Text(
            widget.status,
            style: AppTextStyles.statusText.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  (Color, Color) _getColors() {
    switch (widget.status.toLowerCase()) {
      case 'active':
      case 'completed':
        return (AppColors.success, AppColors.success.withAlpha(25));
      case 'in progress':
        return (AppColors.info, AppColors.info.withAlpha(25));
      case 'pending':
      case 'scheduled':
        return (AppColors.warning, AppColors.warning.withAlpha(25));
      case 'cancelled':
      case 'failed':
      case 'suspended':
        return (AppColors.error, AppColors.error.withAlpha(25));
      case 'inactive':
        return (AppColors.textMuted, AppColors.textMuted.withAlpha(25));
      case 'refunded':
        return (AppColors.purpleLight, AppColors.purpleLight.withAlpha(25));
      default:
        return (AppColors.textMuted, AppColors.textMuted.withAlpha(25));
    }
  }
}
