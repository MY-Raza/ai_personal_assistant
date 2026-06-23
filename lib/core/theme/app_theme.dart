import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  // ── Public entry points ───────────────────────────────────────────────────────

  static ThemeData get darkTheme => _buildDark();
  static ThemeData get lightTheme => _buildLight();

  // ── Dark theme ────────────────────────────────────────────────────────────────

  static ThemeData _buildDark() {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: AppColors.primaryForeground,
      primaryContainer: Color(0xFF4338CA), // indigo-700
      onPrimaryContainer: AppColors.primaryForeground,
      secondary: AppColors.secondary,
      onSecondary: AppColors.secondaryForeground,
      secondaryContainer: Color(0xFF0F766E), // teal-700
      onSecondaryContainer: AppColors.secondaryForeground,
      tertiary: AppColors.accent,
      onTertiary: AppColors.accentForeground,
      tertiaryContainer: Color(0xFF0D9488), // teal-600
      onTertiaryContainer: AppColors.accentForeground,
      error: AppColors.destructive,
      onError: AppColors.destructiveForeground,
      errorContainer: Color(0xFF991B1B), // red-800
      onErrorContainer: AppColors.destructiveForeground,
      surface: AppColors.cardSolid,
      onSurface: AppColors.foreground,
      onSurfaceVariant: AppColors.mutedForeground,
      outline: AppColors.border,
      outlineVariant: AppColors.white10,
      shadow: Colors.black,
      scrim: Colors.black54,
      inverseSurface: AppColors.foreground,
      onInverseSurface: AppColors.background,
      inversePrimary: AppColors.primary,
    );

    final textTheme = AppTypography.buildTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.background,
      cardColor: AppColors.cardSolid,
      dividerColor: AppColors.border,
      textTheme: textTheme,
      primaryTextTheme: textTheme,

      // ── AppBar ──────────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.foreground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: textTheme.titleLarge,
        iconTheme: const IconThemeData(
          color: AppColors.foreground,
          size: AppSpacing.iconLg,
        ),
        actionsIconTheme: const IconThemeData(
          color: AppColors.mutedForeground,
          size: AppSpacing.iconLg,
        ),
      ),

      // ── Bottom navigation ───────────────────────────────────────────────────
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.cardSolid,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.mutedForeground,
        showUnselectedLabels: true,
        selectedLabelStyle: textTheme.labelSmall,
        unselectedLabelStyle: textTheme.labelSmall,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // ── Navigation bar (Material 3) ─────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.cardSolid,
        indicatorColor: AppColors.primary.withOpacity(0.2),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primary, size: AppSpacing.iconLg);
          }
          return const IconThemeData(color: AppColors.mutedForeground, size: AppSpacing.iconLg);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return textTheme.labelSmall?.copyWith(color: AppColors.primary);
          }
          return textTheme.labelSmall?.copyWith(color: AppColors.mutedForeground);
        }),
        elevation: 0,
        height: 64,
      ),

      // ── Navigation drawer ───────────────────────────────────────────────────
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.sidebar,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        width: 280,
      ),

      // ── Card ─────────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: AppColors.cardSolid,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
      ),

      // ── Dialog ───────────────────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.popover,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
      ),

      // ── Bottom sheet ─────────────────────────────────────────────────────────
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.cardSolid,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        modalBackgroundColor: AppColors.cardSolid,
        modalElevation: 0,
        showDragHandle: true,
        dragHandleColor: AppColors.mutedForeground,
        dragHandleSize: Size(32, 4),
      ),

      // ── Elevated button ──────────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.primaryForeground,
          disabledBackgroundColor: AppColors.muted,
          disabledForegroundColor: AppColors.mutedForeground,
          elevation: 0,
          shadowColor: Colors.transparent,
          minimumSize: const Size(double.minPositive, AppSpacing.buttonHeight),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s6,
            vertical: AppSpacing.s3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      // ── Outlined button ──────────────────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.foreground,
          disabledForegroundColor: AppColors.mutedForeground,
          minimumSize: const Size(double.minPositive, AppSpacing.buttonHeight),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s6,
            vertical: AppSpacing.s3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          side: const BorderSide(color: AppColors.border),
          textStyle: textTheme.labelLarge,
        ),
      ),

      // ── Text button ──────────────────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.mutedForeground,
          minimumSize: const Size(double.minPositive, AppSpacing.buttonHeight),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s4,
            vertical: AppSpacing.s2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      // ── FilledButton ─────────────────────────────────────────────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.primaryForeground,
          disabledBackgroundColor: AppColors.muted,
          disabledForegroundColor: AppColors.mutedForeground,
          elevation: 0,
          minimumSize: const Size(double.minPositive, AppSpacing.buttonHeight),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s6,
            vertical: AppSpacing.s3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      // ── Input decoration ─────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.input,
        hoverColor: AppColors.white10,
        focusColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s4,
          vertical: AppSpacing.s3,
        ),
        constraints: const BoxConstraints(minHeight: AppSpacing.inputHeight),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.ring, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.destructive),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.destructive, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: AppColors.border.withOpacity(0.5)),
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.mutedForeground),
        labelStyle: textTheme.bodyMedium?.copyWith(color: AppColors.mutedForeground),
        floatingLabelStyle: textTheme.bodySmall?.copyWith(color: AppColors.primary),
        errorStyle: textTheme.bodySmall?.copyWith(color: AppColors.destructive),
        prefixIconColor: AppColors.mutedForeground,
        suffixIconColor: AppColors.mutedForeground,
        iconColor: AppColors.mutedForeground,
      ),

      // ── Chip ─────────────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.muted,
        labelStyle: textTheme.labelMedium,
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s3,
          vertical: AppSpacing.s1,
        ),
        selectedColor: AppColors.primary.withOpacity(0.2),
        checkmarkColor: AppColors.primary,
        deleteIconColor: AppColors.mutedForeground,
        labelPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.s1),
      ),

      // ── Switch ───────────────────────────────────────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primaryForeground;
          return AppColors.mutedForeground;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return AppColors.switchBackground;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // ── Checkbox ─────────────────────────────────────────────────────────────
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.primaryForeground),
        side: const BorderSide(color: AppColors.border, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.s1),
        ),
      ),

      // ── Radio ────────────────────────────────────────────────────────────────
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return AppColors.mutedForeground;
        }),
      ),

      // ── Slider ───────────────────────────────────────────────────────────────
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.border,
        thumbColor: AppColors.primary,
        overlayColor: AppColors.primary.withOpacity(0.12),
        valueIndicatorColor: AppColors.primary,
        valueIndicatorTextStyle: textTheme.labelSmall?.copyWith(
          color: AppColors.primaryForeground,
        ),
        trackHeight: 4,
      ),

      // ── Progress indicator ───────────────────────────────────────────────────
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.border,
        circularTrackColor: AppColors.border,
        linearMinHeight: 4,
      ),

      // ── Tab bar ──────────────────────────────────────────────────────────────
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.mutedForeground,
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: textTheme.labelLarge,
        unselectedLabelStyle: textTheme.labelLarge,
        dividerColor: AppColors.border,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // ── List tile ────────────────────────────────────────────────────────────
      listTileTheme: ListTileThemeData(
        tileColor: Colors.transparent,
        selectedTileColor: AppColors.primary.withOpacity(0.1),
        selectedColor: AppColors.primary,
        iconColor: AppColors.mutedForeground,
        textColor: AppColors.foreground,
        subtitleTextStyle: textTheme.bodySmall,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
        minVerticalPadding: AppSpacing.s3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
      ),

      // ── Divider ──────────────────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),

      // ── Icon ─────────────────────────────────────────────────────────────────
      iconTheme: const IconThemeData(
        color: AppColors.mutedForeground,
        size: AppSpacing.iconLg,
      ),
      primaryIconTheme: const IconThemeData(
        color: AppColors.primary,
        size: AppSpacing.iconLg,
      ),

      // ── Tooltip ──────────────────────────────────────────────────────────────
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.popover,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          border: Border.all(color: AppColors.border),
        ),
        textStyle: textTheme.bodySmall,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s3,
          vertical: AppSpacing.s2,
        ),
      ),

      // ── Popup menu ───────────────────────────────────────────────────────────
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.popover,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          side: const BorderSide(color: AppColors.border),
        ),
        textStyle: textTheme.bodyMedium,
        labelTextStyle: WidgetStateProperty.all(textTheme.bodyMedium),
        iconColor: AppColors.mutedForeground,
      ),

      // ── Floating action button ────────────────────────────────────────────────
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.primaryForeground,
        elevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
      ),

      // ── Snack bar ─────────────────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.cardSolid,
        contentTextStyle: textTheme.bodyMedium,
        actionTextColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          side: const BorderSide(color: AppColors.border),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
      ),

      // ── Expansion tile ────────────────────────────────────────────────────────
      expansionTileTheme: const ExpansionTileThemeData(
        iconColor: AppColors.mutedForeground,
        collapsedIconColor: AppColors.mutedForeground,
        textColor: AppColors.foreground,
        collapsedTextColor: AppColors.foreground,
        tilePadding: EdgeInsets.symmetric(horizontal: AppSpacing.s4),
        childrenPadding: EdgeInsets.symmetric(horizontal: AppSpacing.s4),
      ),
    );
  }

  // ── Light theme (stub for future use) ────────────────────────────────────────

  static ThemeData _buildLight() {
    // The source CSS defines a dark-first design.
    // Light theme mirrors the dark theme until a light palette is designed.
    return _buildDark().copyWith(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.primaryForeground,
        secondary: AppColors.secondary,
        onSecondary: AppColors.secondaryForeground,
        error: AppColors.destructive,
        onError: AppColors.destructiveForeground,
        surface: Color(0xFFFFFFFF),
        onSurface: Color(0xFF0F172A),
      ),
    );
  }
}