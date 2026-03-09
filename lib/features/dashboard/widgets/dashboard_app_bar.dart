import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const DashboardAppBar({
    super.key,
    required this.title,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withAlpha(200),
        border: Border(
          bottom: BorderSide(color: AppColors.purple.withAlpha(20)),
        ),
      ),
      child: Row(
        children: [
          // Animated title text with gradient
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [AppColors.textPrimary, AppColors.textSecondary],
            ).createShader(bounds),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position:
                      Tween<Offset>(
                        begin: const Offset(0, 0.3),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: anim,
                          curve: Curves.easeOutCubic,
                        ),
                      ),
                  child: child,
                ),
              ),
              child: Text(
                title,
                key: ValueKey(title),
                style: AppTextStyles.appBarTitle,
              ),
            ),
          ),
          const Spacer(),
          // Glassmorphism search bar
          Container(
            width: 280,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight.withAlpha(120),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: AppStrings.searchAnything,
                prefixIcon: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColors.purple, AppColors.cyan],
                  ).createShader(bounds),
                  child: const Icon(
                    Icons.search_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: InputBorder.none,
                hintStyle: AppTextStyles.searchHint,
              ),
              style: AppTextStyles.searchInput,
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
          const SizedBox(width: 20),
          // Theme toggle with rotation
          _AnimatedIconButton(isDarkMode: isDarkMode, onToggle: onToggleTheme),
          const SizedBox(width: 8),
          // Notifications with pulse
          _NotificationBell(),
          const SizedBox(width: 14),
          // Avatar with glow ring
          _AvatarWidget(),
        ],
      ),
    );
  }
}

class _AnimatedIconButton extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggle;
  const _AnimatedIconButton({required this.isDarkMode, required this.onToggle});

  @override
  State<_AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<_AnimatedIconButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onToggle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.purpleBadge : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, anim) => RotationTransition(
              turns: Tween(begin: 0.75, end: 1.0).animate(
                CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
              ),
              child: FadeTransition(opacity: anim, child: child),
            ),
            child: Icon(
              widget.isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              key: ValueKey(widget.isDarkMode),
              color: _hovered ? AppColors.cyan : AppColors.textMuted,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationBell extends StatefulWidget {
  @override
  State<_NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends State<_NotificationBell>
    with SingleTickerProviderStateMixin {
  late AnimationController _bellController;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _bellController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _bellController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        _bellController.forward(from: 0);
      },
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text(
                'Notifications',
                style: TextStyle(color: Colors.white),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  ListTile(
                    leading: Icon(Icons.directions_car, color: AppColors.cyan),
                    title: Text(
                      'New ride completed',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Ride #5023 finished successfully',
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.payment, color: AppColors.purple),
                    title: Text(
                      'Payment received',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'PAY-9012 - 15.50 JOD',
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.person_add, color: AppColors.success),
                    title: Text(
                      'New user registered',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Ahmad Al-Masri joined',
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.purpleBadge : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _bellController,
                builder: (context, child) {
                  final shake = _bellController.isAnimating
                      ? (0.05 *
                            (1 - _bellController.value) *
                            ((_bellController.value * 8 * 3.14159).clamp(
                                      -1,
                                      1,
                                    ) >
                                    0
                                ? 1
                                : -1))
                      : 0.0;
                  return Transform.rotate(
                    angle: shake,
                    child: Icon(
                      Icons.notifications_outlined,
                      color: _hovered ? AppColors.cyan : AppColors.textMuted,
                      size: 22,
                    ),
                  );
                },
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.error, Color(0xFFFF7043)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.error.withAlpha(120),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarWidget extends StatefulWidget {
  @override
  State<_AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<_AvatarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ringController;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ringController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _ringController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedBuilder(
        animation: _ringController,
        builder: (context, _) {
          return Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                startAngle: _ringController.value * 6.28,
                colors: [
                  AppColors.purple,
                  AppColors.cyan,
                  AppColors.purpleLight,
                  AppColors.purple,
                ],
              ),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: AppColors.purpleGlow,
                        blurRadius: 12,
                        spreadRadius: -2,
                      ),
                    ]
                  : null,
            ),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface,
              ),
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.purple,
                child: Text(
                  AppStrings.avatarDefault,
                  style: AppTextStyles.avatarLetter,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
