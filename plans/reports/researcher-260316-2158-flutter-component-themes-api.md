---
name: Flutter ThemeData Component Themes API Reference (2026)
description: Complete reference of exact class names, constructors, and properties for all Material Design component themes in Flutter ThemeData
type: research
date: 2026-03-16
---

# Flutter ThemeData Component Themes API Reference (2026)

**Status:** Latest stable Flutter 3.x+ (as of March 2026)
**Context:** Non-deprecated Material Design 3 component themes
**Scope:** Exact class names, constructor signatures, and key properties for code generation

---

## Summary

All component themes in Flutter's `ThemeData` follow the pattern: `ThemeData.propertyName` → `PropertyNameThemeData` class. All are nullable, immutable, and support `copyWith()` for customization.

---

## Component Theme Reference

### 1. FilledButtonThemeData

**Property:** `filledButtonTheme`
**Type:** `FilledButtonThemeData?`
**Class Status:** Current (non-deprecated)

**Constructor:**
```dart
FilledButtonThemeData({ButtonStyle? style})
```

**Key Properties:**
- `style` (ButtonStyle?) — Overrides for FilledButton's default style

**Minimal Material 3 Example:**
```dart
ThemeData(
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Colors.blue),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
    ),
  ),
)
```

---

### 2. OutlinedButtonThemeData

**Property:** `outlinedButtonTheme`
**Type:** `OutlinedButtonThemeData?`
**Class Status:** Current (non-deprecated)

**Constructor:**
```dart
OutlinedButtonThemeData({ButtonStyle? style})
```

**Key Properties:**
- `style` (ButtonStyle?) — Overrides for OutlinedButton's default style

**Minimal Material 3 Example:**
```dart
ThemeData(
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      side: WidgetStateProperty.all(BorderSide(color: Colors.blue, width: 2)),
      foregroundColor: WidgetStateProperty.all(Colors.blue),
    ),
  ),
)
```

---

### 3. TextButtonThemeData

**Property:** `textButtonTheme`
**Type:** `TextButtonThemeData?`
**Class Status:** Current (non-deprecated)

**Constructor:**
```dart
TextButtonThemeData({ButtonStyle? style})
```

**Key Properties:**
- `style` (ButtonStyle?) — Overrides for TextButton's default style

**Minimal Material 3 Example:**
```dart
ThemeData(
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.blue),
      textStyle: WidgetStateProperty.all(TextStyle(fontSize: 14)),
    ),
  ),
)
```

---

### 4. FloatingActionButtonThemeData

**Property:** `floatingActionButtonTheme`
**Type:** `FloatingActionButtonThemeData?`
**Class Status:** Current (non-deprecated)

**Constructor:**
```dart
FloatingActionButtonThemeData({
  Color? foregroundColor,
  Color? backgroundColor,
  Color? focusColor,
  Color? hoverColor,
  Color? splashColor,
  double? elevation,
  double? focusElevation,
  double? hoverElevation,
  double? disabledElevation,
  double? highlightElevation,
  ShapeBorder? shape,
  bool? enableFeedback,
  double? iconSize,
  BoxConstraints? sizeConstraints,
  BoxConstraints? smallSizeConstraints,
  BoxConstraints? largeSizeConstraints,
  BoxConstraints? extendedSizeConstraints,
  double? extendedIconLabelSpacing,
  EdgeInsetsGeometry? extendedPadding,
  TextStyle? extendedTextStyle,
  WidgetStateProperty<MouseCursor?>? mouseCursor
})
```

**Key Properties:**
- **Colors:** `foregroundColor`, `backgroundColor`, `focusColor`, `hoverColor`, `splashColor`
- **Elevation:** `elevation`, `focusElevation`, `hoverElevation`, `disabledElevation`, `highlightElevation`
- **Layout:** `iconSize`, `sizeConstraints`, `smallSizeConstraints`, `largeSizeConstraints`, `extendedSizeConstraints`
- **Extended FAB:** `extendedIconLabelSpacing`, `extendedPadding`, `extendedTextStyle`
- **Other:** `shape`, `enableFeedback`, `mouseCursor`

**Minimal Material 3 Example:**
```dart
ThemeData(
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    elevation: 4,
    shape: CircleBorder(),
  ),
)
```

---

### 5. ChipThemeData

**Property:** `chipTheme`
**Type:** `ChipThemeData?`
**Class Status:** Current (non-deprecated)

**Constructor:**
```dart
ChipThemeData({
  WidgetStateProperty<Color?>? color,
  Color? backgroundColor,
  Color? deleteIconColor,
  Color? disabledColor,
  Color? selectedColor,
  Color? secondarySelectedColor,
  Color? shadowColor,
  Color? surfaceTintColor,
  Color? selectedShadowColor,
  bool? showCheckmark,
  Color? checkmarkColor,
  EdgeInsetsGeometry? labelPadding,
  EdgeInsetsGeometry? padding,
  BorderSide? side,
  OutlinedBorder? shape,
  TextStyle? labelStyle,
  TextStyle? secondaryLabelStyle,
  Brightness? brightness,
  double? elevation,
  double? pressElevation,
  IconThemeData? iconTheme,
  BoxConstraints? avatarBoxConstraints,
  BoxConstraints? deleteIconBoxConstraints
})
```

**Key Properties:**
- **Colors:** `color`, `backgroundColor`, `selectedColor`, `secondarySelectedColor`, `disabledColor`, `deleteIconColor`, `checkmarkColor`
- **Styling:** `shape`, `side`, `labelStyle`, `secondaryLabelStyle`, `brightness`
- **Elevation:** `elevation`, `pressElevation`, `selectedShadowColor`
- **Layout:** `padding`, `labelPadding`, `avatarBoxConstraints`, `deleteIconBoxConstraints`
- **Other:** `showCheckmark`, `shadowColor`, `surfaceTintColor`, `iconTheme`

**Minimal Material 3 Example:**
```dart
ThemeData(
  chipTheme: ChipThemeData(
    backgroundColor: Colors.grey[200],
    selectedColor: Colors.blue,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  ),
)
```

---

### 6. DialogThemeData

**Property:** `dialogTheme`
**Type:** `DialogThemeData?`
**Class Status:** Current (non-deprecated) — **NOT** DialogTheme

**Constructor:**
```dart
DialogThemeData({
  Color? backgroundColor,
  double? elevation,
  Color? shadowColor,
  Color? surfaceTintColor,
  ShapeBorder? shape,
  AlignmentGeometry? alignment,
  Color? iconColor,
  TextStyle? titleTextStyle,
  TextStyle? contentTextStyle,
  EdgeInsetsGeometry? actionsPadding,
  Color? barrierColor,
  EdgeInsets? insetPadding,
  Clip? clipBehavior,
  BoxConstraints? constraints
})
```

**Key Properties:**
- **Colors:** `backgroundColor`, `shadowColor`, `surfaceTintColor`, `iconColor`, `barrierColor`
- **Styling:** `shape`, `elevation`, `clipBehavior`
- **Text Styles:** `titleTextStyle`, `contentTextStyle`
- **Layout:** `alignment`, `actionsPadding`, `insetPadding`, `constraints`

**Minimal Material 3 Example:**
```dart
ThemeData(
  dialogTheme: DialogThemeData(
    backgroundColor: Colors.white,
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    contentTextStyle: TextStyle(fontSize: 16, color: Colors.grey[800]),
  ),
)
```

---

### 7. BottomNavigationBarThemeData

**Property:** `bottomNavigationBarTheme`
**Type:** `BottomNavigationBarThemeData?`
**Class Status:** Current (non-deprecated)

**Constructor:**
```dart
BottomNavigationBarThemeData({
  Color? backgroundColor,
  double? elevation,
  IconThemeData? selectedIconTheme,
  IconThemeData? unselectedIconTheme,
  Color? selectedItemColor,
  Color? unselectedItemColor,
  TextStyle? selectedLabelStyle,
  TextStyle? unselectedLabelStyle,
  bool? showSelectedLabels,
  bool? showUnselectedLabels,
  BottomNavigationBarType? type,
  bool? enableFeedback,
  BottomNavigationBarLandscapeLayout? landscapeLayout,
  WidgetStateProperty<MouseCursor?>? mouseCursor
})
```

**Key Properties:**
- **Colors:** `backgroundColor`, `selectedItemColor`, `unselectedItemColor`
- **Icon Themes:** `selectedIconTheme`, `unselectedIconTheme`
- **Text Styles:** `selectedLabelStyle`, `unselectedLabelStyle`
- **Visibility:** `showSelectedLabels`, `showUnselectedLabels`
- **Layout:** `type`, `landscapeLayout`, `elevation`
- **Interaction:** `enableFeedback`, `mouseCursor`

**Minimal Material 3 Example:**
```dart
ThemeData(
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    elevation: 8,
    type: BottomNavigationBarType.fixed,
  ),
)
```

---

### 8. NavigationBarThemeData

**Property:** `navigationBarTheme`
**Type:** `NavigationBarThemeData?`
**Class Status:** Current (non-deprecated) — **NEW** in Material Design 3

**Constructor:**
```dart
NavigationBarThemeData({
  double? height,
  Color? backgroundColor,
  double? elevation,
  Color? shadowColor,
  Color? surfaceTintColor,
  Color? indicatorColor,
  ShapeBorder? indicatorShape,
  WidgetStateProperty<TextStyle?>? labelTextStyle,
  WidgetStateProperty<IconThemeData?>? iconTheme,
  NavigationDestinationLabelBehavior? labelBehavior,
  WidgetStateProperty<Color?>? overlayColor,
  EdgeInsetsGeometry? labelPadding
})
```

**Key Properties:**
- **Colors:** `backgroundColor`, `shadowColor`, `surfaceTintColor`, `indicatorColor`, `overlayColor`
- **Indicator:** `indicatorColor`, `indicatorShape`
- **Text & Icons:** `labelTextStyle`, `iconTheme`, `labelBehavior`
- **Layout:** `height`, `elevation`, `labelPadding`

**Minimal Material 3 Example:**
```dart
ThemeData(
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Colors.white,
    indicatorColor: Colors.blue,
    height: 80,
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 12, fontWeight: FontWeight.w600)
    ),
  ),
)
```

---

### 9. BottomSheetThemeData

**Property:** `bottomSheetTheme`
**Type:** `BottomSheetThemeData?`
**Class Status:** Current (non-deprecated)

**Constructor:**
```dart
BottomSheetThemeData({
  Color? backgroundColor,
  Color? surfaceTintColor,
  double? elevation,
  Color? modalBackgroundColor,
  Color? modalBarrierColor,
  Color? shadowColor,
  double? modalElevation,
  ShapeBorder? shape,
  bool? showDragHandle,
  Color? dragHandleColor,
  Size? dragHandleSize,
  Clip? clipBehavior,
  BoxConstraints? constraints
})
```

**Key Properties:**
- **Colors:** `backgroundColor`, `surfaceTintColor`, `shadowColor`, `modalBackgroundColor`, `modalBarrierColor`
- **Styling:** `shape`, `elevation`, `modalElevation`, `clipBehavior`
- **Drag Handle:** `showDragHandle`, `dragHandleColor`, `dragHandleSize`
- **Layout:** `constraints`

**Minimal Material 3 Example:**
```dart
ThemeData(
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.white,
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16))
    ),
    showDragHandle: true,
    dragHandleColor: Colors.grey[400],
  ),
)
```

---

### 10. SnackBarThemeData

**Property:** `snackBarTheme`
**Type:** `SnackBarThemeData?`
**Class Status:** Current (non-deprecated)

**Constructor:**
```dart
SnackBarThemeData({
  Color? backgroundColor,
  Color? actionTextColor,
  Color? disabledActionTextColor,
  TextStyle? contentTextStyle,
  double? elevation,
  ShapeBorder? shape,
  SnackBarBehavior? behavior,
  double? width,
  EdgeInsets? insetPadding,
  bool? showCloseIcon,
  Color? closeIconColor,
  double? actionOverflowThreshold,
  Color? actionBackgroundColor,
  Color? disabledActionBackgroundColor,
  DismissDirection? dismissDirection
})
```

**Key Properties:**
- **Colors:** `backgroundColor`, `actionTextColor`, `disabledActionTextColor`, `closeIconColor`, `actionBackgroundColor`, `disabledActionBackgroundColor`
- **Text & Style:** `contentTextStyle`, `shape`, `elevation`
- **Actions:** `showCloseIcon`, `actionOverflowThreshold`
- **Layout:** `behavior`, `width`, `insetPadding`, `dismissDirection`

**Minimal Material 3 Example:**
```dart
ThemeData(
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.grey[800],
    contentTextStyle: TextStyle(color: Colors.white, fontSize: 14),
    actionTextColor: Colors.blue,
    elevation: 6,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
)
```

---

### 11. DividerThemeData

**Property:** `dividerTheme`
**Type:** `DividerThemeData?`
**Class Status:** Current (non-deprecated)

**Constructor:**
```dart
DividerThemeData({
  Color? color,
  double? space,
  double? thickness,
  double? indent,
  double? endIndent,
  BorderRadiusGeometry? radius
})
```

**Key Properties:**
- **Styling:** `color`, `thickness`, `radius`
- **Spacing:** `space`, `indent`, `endIndent`

**Minimal Material 3 Example:**
```dart
ThemeData(
  dividerTheme: DividerThemeData(
    color: Colors.grey[300],
    thickness: 1,
    space: 16,
    indent: 16,
    endIndent: 16,
  ),
)
```

---

### 12. ListTileThemeData

**Property:** `listTileTheme`
**Type:** `ListTileThemeData?`
**Class Status:** Current (non-deprecated)

**Constructor:**
```dart
ListTileThemeData({
  bool? dense,
  ShapeBorder? shape,
  ListTileStyle? style,
  Color? selectedColor,
  Color? iconColor,
  Color? textColor,
  TextStyle? titleTextStyle,
  TextStyle? subtitleTextStyle,
  TextStyle? leadingAndTrailingTextStyle,
  EdgeInsetsGeometry? contentPadding,
  Color? tileColor,
  Color? selectedTileColor,
  double? horizontalTitleGap,
  double? minVerticalPadding,
  double? minLeadingWidth,
  bool? enableFeedback,
  WidgetStateProperty<MouseCursor?>? mouseCursor,
  VisualDensity? visualDensity,
  double? minTileHeight,
  ListTileTitleAlignment? titleAlignment,
  ListTileControlAffinity? controlAffinity,
  bool? isThreeLine
})
```

**Key Properties:**
- **Colors:** `selectedColor`, `iconColor`, `textColor`, `tileColor`, `selectedTileColor`
- **Text Styles:** `titleTextStyle`, `subtitleTextStyle`, `leadingAndTrailingTextStyle`
- **Styling:** `shape`, `style`, `dense`, `isThreeLine`
- **Layout:** `contentPadding`, `horizontalTitleGap`, `minVerticalPadding`, `minLeadingWidth`, `minTileHeight`, `titleAlignment`, `controlAffinity`
- **Interaction:** `enableFeedback`, `mouseCursor`, `visualDensity`

**Minimal Material 3 Example:**
```dart
ThemeData(
  listTileTheme: ListTileThemeData(
    dense: false,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    tileColor: Colors.white,
    selectedTileColor: Colors.blue[50],
    selectedColor: Colors.blue,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    minTileHeight: 56,
  ),
)
```

---

### 13. CardThemeData

**Property:** `cardTheme`
**Type:** `CardThemeData?`
**Class Status:** Current (non-deprecated) — **NOT** CardTheme or CardThemeData

**Constructor:**
```dart
CardThemeData({
  Clip? clipBehavior,
  Color? color,
  Color? shadowColor,
  Color? surfaceTintColor,
  double? elevation,
  EdgeInsetsGeometry? margin,
  ShapeBorder? shape
})
```

**Key Properties:**
- **Colors:** `color`, `shadowColor`, `surfaceTintColor`
- **Styling:** `shape`, `elevation`, `clipBehavior`
- **Layout:** `margin`

**Minimal Material 3 Example:**
```dart
ThemeData(
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: EdgeInsets.all(16),
    clipBehavior: Clip.antiAlias,
  ),
)
```

---

## Deprecation Status Summary

| Component Theme | Current Class Name | Deprecated? | Migration Notes |
|---|---|---|---|
| Filled Button | FilledButtonThemeData | ❌ No | Current |
| Outlined Button | OutlinedButtonThemeData | ❌ No | Current |
| Text Button | TextButtonThemeData | ❌ No | Current |
| FAB | FloatingActionButtonThemeData | ❌ No | Current |
| Chip | ChipThemeData | ❌ No | Current |
| Dialog | **DialogThemeData** | ❌ No | NOT DialogTheme |
| Bottom Nav Bar | BottomNavigationBarThemeData | ❌ No | Current |
| Navigation Bar | NavigationBarThemeData | ❌ No | Material 3 only |
| Bottom Sheet | BottomSheetThemeData | ❌ No | Current |
| SnackBar | SnackBarThemeData | ❌ No | Current |
| Divider | DividerThemeData | ❌ No | Current |
| ListTile | ListTileThemeData | ❌ No | Current |
| Card | **CardThemeData** | ❌ No | NOT CardTheme or CardTheme |

---

## Code Generation Notes

### Pattern-Based Naming Convention
All component themes follow: `ThemeData.propertyName` → `PropertyNameThemeData`

**Generator Algorithm:**
1. Take ThemeData property: `filledButtonTheme`
2. PascalCase the prefix: `FilledButton`
3. Append `ThemeData`: `FilledButtonThemeData`

### Null Safety
- All component theme types are nullable (`?`)
- All constructor parameters are nullable
- Default behavior: unspecified properties use Material Design 3 system defaults

### Material 3 Compliance
- Generated code must use Material Design 3 colors from `ColorScheme`
- Use `WidgetStateProperty` for state-dependent styling (not `MaterialStateProperty`)
- For navigation: `NavigationBar` (new M3) not `BottomNavigationBar` (legacy)

### Import Statement
```dart
import 'package:flutter/material.dart';
```

---

## Sources

- [ThemeData class - material library - Dart API](https://api.flutter.dev/flutter/material/ThemeData-class.html)
- [FilledButtonThemeData class - material library - Dart API](https://api.flutter.dev/flutter/material/FilledButtonThemeData-class.html)
- [OutlinedButtonThemeData class - material library - Dart API](https://api.flutter.dev/flutter/material/OutlinedButtonThemeData-class.html)
- [TextButtonThemeData class - material library - Dart API](https://api.flutter.dev/flutter/material/TextButtonThemeData-class.html)
- [FloatingActionButtonThemeData class - material library - Dart API](https://api.flutter.dev/flutter/material/FloatingActionButtonThemeData-class.html)
- [ChipThemeData class - material library - Dart API](https://api.flutter.dev/flutter/material/ChipThemeData-class.html)
- [DialogThemeData class - material library - Dart API](https://api.flutter.dev/flutter/material/DialogThemeData-class.html)
- [BottomNavigationBarThemeData class - material library - Dart API](https://api.flutter.dev/flutter/material/BottomNavigationBarThemeData-class.html)
- [NavigationBarThemeData class - material library - Dart API](https://api.flutter.dev/flutter/material/NavigationBarThemeData-class.html)
- [BottomSheetThemeData class - material library - Dart API](https://api.flutter.dev/flutter/material/BottomSheetThemeData-class.html)
- [SnackBarThemeData class - material library - Dart API](https://api.flutter.dev/flutter/material/SnackBarThemeData-class.html)
- [DividerThemeData class - material library - Dart API](https://api.flutter.dev/flutter/material/DividerThemeData-class.html)
- [ListTileThemeData class - material library - Dart API](https://api.flutter.dev/flutter/material/ListTileThemeData-class.html)
- [CardThemeData class - material library - Dart API](https://api.flutter.dev/flutter/material/CardThemeData-class.html)
- [Component theme normalization | Flutter](https://docs.flutter.dev/release/breaking-changes/component-theme-normalization)
