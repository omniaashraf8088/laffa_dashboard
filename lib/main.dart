import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';
import 'features/dashboard/widgets/sidebar_nav.dart';
import 'features/dashboard/widgets/dashboard_app_bar.dart';
import 'features/dashboard/widgets/animated_background.dart';
import 'features/dashboard/screens/home_screen.dart';
import 'features/dashboard/screens/users_screen.dart';
import 'features/dashboard/screens/rides_screen.dart';
import 'features/dashboard/screens/payments_screen.dart';
import 'features/dashboard/screens/analytics_screen.dart';

void main() {
  Animate.restartOnHotReload = true;
  runApp(const LaffaDashboardApp());
}

class LaffaDashboardApp extends StatefulWidget {
  const LaffaDashboardApp({super.key});

  @override
  State<LaffaDashboardApp> createState() => _LaffaDashboardAppState();
}

class _LaffaDashboardAppState extends State<LaffaDashboardApp> {
  bool _isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: DashboardShell(
        isDarkMode: _isDarkMode,
        onToggleTheme: () => setState(() => _isDarkMode = !_isDarkMode),
      ),
    );
  }
}

class DashboardShell extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const DashboardShell({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  int _selectedIndex = 0;
  bool _sidebarCollapsed = false;

  static const _titles = AppStrings.navTitles;

  static const _screens = <Widget>[
    HomeScreen(),
    UsersScreen(),
    RidesScreen(),
    PaymentsScreen(),
    AnalyticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          SidebarNav(
            selectedIndex: _selectedIndex,
            onItemSelected: (i) => setState(() => _selectedIndex = i),
            isCollapsed: _sidebarCollapsed,
            onToggleCollapse: () =>
                setState(() => _sidebarCollapsed = !_sidebarCollapsed),
          ),
          // Main content
          Expanded(
            child: AnimatedBackground(
              child: Column(
                children: [
                  DashboardAppBar(
                    title: _titles[_selectedIndex],
                    isDarkMode: widget.isDarkMode,
                    onToggleTheme: widget.onToggleTheme,
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      layoutBuilder: (currentChild, previousChildren) {
                        return Stack(
                          fit: StackFit.expand,
                          children: [...previousChildren, ?currentChild],
                        );
                      },
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.02, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: KeyedSubtree(
                        key: ValueKey(_selectedIndex),
                        child: _screens[_selectedIndex],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
