import '../../interface/sample_interface.dart';

/// Template for lib/core/theme/theme_constants.dart — design tokens
///
/// Generates spacing, border radius, and elevation constants
/// following Material 3's 4dp grid system.
class ScaffoldThemeConstantsSample extends Sample {
  ScaffoldThemeConstantsSample({String? path})
      : super(path ?? 'lib/core/theme/theme_constants.dart', overwrite: false);

  @override
  String get content => '''
import 'package:flutter/material.dart';

// ── Spacing (4dp grid) ──────────────────────────────────────────────────

/// App-wide spacing constants based on a 4dp grid.
///
/// Usage: `SizedBox(height: AppSpacing.md)` or `AppSpacing.paddingLg`
abstract final class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double xxxl = 48.0;

  // Pre-built EdgeInsets
  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);
}

// ── Border Radius ───────────────────────────────────────────────────────

/// Material 3 border radius tokens.
abstract final class AppBorderRadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 28.0;

  static final BorderRadius radiusXs = BorderRadius.circular(xs);
  static final BorderRadius radiusSm = BorderRadius.circular(sm);
  static final BorderRadius radiusMd = BorderRadius.circular(md);
  static final BorderRadius radiusLg = BorderRadius.circular(lg);
  static final BorderRadius radiusXl = BorderRadius.circular(xl);
}

// ── Elevation ───────────────────────────────────────────────────────────

/// Material 3 elevation levels.
abstract final class AppElevation {
  static const double level0 = 0.0;
  static const double level1 = 1.0;
  static const double level2 = 3.0;
  static const double level3 = 6.0;
  static const double level4 = 8.0;
  static const double level5 = 12.0;
}
''';
}
