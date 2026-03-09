import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Centralized text styles for the entire dashboard.
class AppTextStyles {
  AppTextStyles._();

  // ── Page Headlines ──

  /// Page title (28px) – used with ShaderMask for gradient text
  static const pageTitle = TextStyle(
    color: Colors.white,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  /// Page subtitle / description
  static TextStyle get pageSubtitle =>
      TextStyle(color: AppColors.textMuted.withAlpha(180), fontSize: 14);

  // ── App Bar ──

  /// App bar page title
  static const appBarTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  // ── Sidebar ──

  /// Brand logo text "Laffa"
  static const logo = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
  );

  // ── Section Headers ──

  /// Section title (18px, e.g. "Recent Rides")
  static const sectionTitle = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  /// Section title with tight tracking (18px, chart containers)
  static const sectionTitleTight = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.3,
  );

  /// Chart container title (17px)
  static const chartTitle = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 17,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.3,
  );

  /// Chart / section subtitle
  static TextStyle get chartSubtitle =>
      TextStyle(color: AppColors.textMuted.withAlpha(160), fontSize: 13);

  // ── Display / Numbers ──

  /// Large card value number
  static const cardValue = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: -0.5,
  );

  /// Animated counter default style
  static const counterValue = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  // ── Summary Card ──

  /// Card label text (title below value)
  static TextStyle get cardLabel => const TextStyle(
    color: Color(0xC8FFFFFF), // white @ 200/255
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
  );

  /// Card subtitle badge text
  static TextStyle get cardSubtitle => const TextStyle(
    color: Color(0xDCFFFFFF), // white @ 220/255
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );

  // ── Charts ──

  /// Chart axis labels
  static TextStyle get axisLabel =>
      TextStyle(color: AppColors.textMuted.withAlpha(150), fontSize: 11);

  /// Tooltip header / label text
  static const tooltipLabel = TextStyle(
    color: AppColors.textMuted,
    fontSize: 12,
  );

  /// Tooltip highlighted value
  static const tooltipValue = TextStyle(
    color: AppColors.cyan,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  /// Pie chart section label
  static const pieSectionLabel = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 13,
  );

  /// Chart legend label
  static const legendLabel = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 13,
  );

  /// Small chart legend label (12px)
  static const legendLabelSmall = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 12,
  );

  /// Chart legend value
  static const legendValue = TextStyle(
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w700,
    fontSize: 13,
  );

  // ── Search ──

  /// Search input text
  static const searchInput = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  /// Search hint text
  static TextStyle get searchHint =>
      TextStyle(color: AppColors.textMuted.withAlpha(150), fontSize: 13);

  // ── Data Table ──

  /// Table column header (base – apply color via copyWith)
  static const tableHeader = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13,
  );

  /// Pagination info text
  static TextStyle get paginationInfo =>
      TextStyle(color: AppColors.textMuted.withAlpha(180), fontSize: 13);

  // ── Badges ──

  /// Small white badge (e.g. "Live")
  static const badgeWhite = TextStyle(
    color: Colors.white,
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );

  /// Small purple badge (e.g. "4 Charts")
  static const badgePurple = TextStyle(
    color: AppColors.purple,
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );

  /// Status badge text (base – apply color via copyWith)
  static const statusText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  // ── Table Cells ──

  /// Highlighted cell (cyan, e.g. prices)
  static const cellHighlight = TextStyle(
    color: AppColors.cyan,
    fontWeight: FontWeight.w600,
  );

  /// Bold cell text (e.g. user names)
  static const cellBold = TextStyle(fontWeight: FontWeight.w600);

  /// Default cell body text
  static const cellBody = TextStyle(fontSize: 13);

  // ── Activity Items ──

  /// Item title (name)
  static const itemTitle = TextStyle(
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  /// Item subtitle (route, description)
  static TextStyle get itemSubtitle =>
      TextStyle(color: AppColors.textMuted.withAlpha(160), fontSize: 12);

  // ── Avatar ──

  /// Avatar letter
  static const avatarLetter = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
}
