import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';

class SidebarNav extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final bool isCollapsed;
  final VoidCallback onToggleCollapse;

  const SidebarNav({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.isCollapsed,
    required this.onToggleCollapse,
  });

  @override
  State<SidebarNav> createState() => _SidebarNavState();
}

class _SidebarNavState extends State<SidebarNav>
    with SingleTickerProviderStateMixin {
  int _hoveredIndex = -1;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  static const _items = [
    _NavItem(icon: Icons.dashboard_rounded, label: AppStrings.navHome),
    _NavItem(icon: Icons.people_rounded, label: AppStrings.navUsers),
    _NavItem(icon: Icons.directions_car_rounded, label: AppStrings.navRides),
    _NavItem(icon: Icons.payment_rounded, label: AppStrings.navPayments),
    _NavItem(icon: Icons.analytics_rounded, label: AppStrings.navAnalytics),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.isCollapsed ? 78.0 : 250.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.surface.withAlpha(230),
        border: Border(
          right: BorderSide(color: AppColors.purpleBadge, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.purpleHover,
            blurRadius: 30,
            offset: const Offset(5, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          _buildHeader(),
          const SizedBox(height: 36),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _items.length,
              itemBuilder: (context, index) =>
                  _buildNavItem(index, _items[index]),
            ),
          ),
          _buildCollapseButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Pulsing neon logo
              AnimatedBuilder(
                animation: _pulseAnim,
                builder: (context, child) {
                  return Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.purple.withAlpha(
                            (120 * _pulseAnim.value).toInt(),
                          ),
                          blurRadius: 16 * _pulseAnim.value,
                          spreadRadius: -2,
                        ),
                        BoxShadow(
                          color: AppColors.cyan.withAlpha(
                            (60 * _pulseAnim.value).toInt(),
                          ),
                          blurRadius: 24 * _pulseAnim.value,
                          spreadRadius: -4,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.local_taxi_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  );
                },
              ),
              if (!widget.isCollapsed) ...[
                const SizedBox(width: 14),
                Expanded(
                  child: ShaderMask(
                    shaderCallback: (bounds) =>
                        AppColors.primaryGradient.createShader(bounds),
                    child: const Text(
                      AppStrings.brandName,
                      style: AppTextStyles.logo,
                    ),
                  ),
                ),
              ],
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideX(begin: -0.3, end: 0, curve: Curves.easeOutBack);
  }

  Widget _buildNavItem(int index, _NavItem item) {
    final isSelected = widget.selectedIndex == index;
    final isHovered = _hoveredIndex == index;

    return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: MouseRegion(
            onEnter: (_) => setState(() => _hoveredIndex = index),
            onExit: (_) => setState(() => _hoveredIndex = -1),
            child: GestureDetector(
              onTap: () => widget.onItemSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                padding: EdgeInsets.symmetric(
                  horizontal: widget.isCollapsed ? 0 : 16,
                  vertical: 13,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [Color(0xFF7C5FFF), Color(0xFF9B5FFF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )
                      : null,
                  color: isSelected
                      ? null
                      : isHovered
                      ? AppColors.purple.withAlpha(20)
                      : Colors.transparent,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.purpleIndicator,
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                            spreadRadius: -4,
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: widget.isCollapsed
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    // Animated icon with scale
                    AnimatedScale(
                      scale: isHovered || isSelected ? 1.15 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        item.icon,
                        color: isSelected
                            ? Colors.white
                            : isHovered
                            ? AppColors.purple
                            : AppColors.textMuted,
                        size: 22,
                      ),
                    ),
                    if (!widget.isCollapsed) ...[
                      const SizedBox(width: 14),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : isHovered
                              ? AppColors.textPrimary
                              : AppColors.textMuted,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w400,
                          fontSize: 14,
                          letterSpacing: isSelected ? 0.5 : 0,
                        ),
                        child: Text(item.label),
                      ),
                      const Spacer(),
                      // Active indicator dot
                      if (isSelected)
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withAlpha(120),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        )
        .animate(delay: Duration(milliseconds: 100 + index * 100))
        .fadeIn(duration: 500.ms, curve: Curves.easeOut)
        .slideX(begin: -0.4, end: 0, curve: Curves.easeOutBack);
  }

  Widget _buildCollapseButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.overlayWhiteSubtle)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: IconButton(
          onPressed: widget.onToggleCollapse,
          icon: AnimatedRotation(
            turns: widget.isCollapsed ? 0.5 : 0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutBack,
            child: Icon(
              Icons.chevron_left_rounded,
              color: AppColors.textMuted.withAlpha(160),
              size: 26,
            ),
          ),
          tooltip: widget.isCollapsed ? AppStrings.expand : AppStrings.collapse,
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}
