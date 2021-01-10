import 'dart:math' as math;

import 'package:flutter/material.dart';

ThemeData createLightTheme() {
  const MaterialColor _lightThemeColor = Colors.red;
  const Brightness _lightPrimaryColorBrightness = Brightness.dark;
  const Brightness _lightAccentColorBrightness = Brightness.dark;
  const Color _lightCardColor = Colors.white;

  // User w300 as Normal weight, w400 as medium and w200 as thin
  final primaryTextTheme = TextTheme(
    bodyText1: TextStyle(
      fontWeight: FontWeight.w400,
    ),
    bodyText2: TextStyle(
      fontWeight: FontWeight.w300,
    ),
    button: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    subtitle1: TextStyle(
      fontWeight: FontWeight.w300,
    ),
    subtitle2: TextStyle(
      fontWeight: FontWeight.w400,
    ),
    headline1: TextStyle(
      fontWeight: FontWeight.w200,
    ),
    headline2: TextStyle(
      fontWeight: FontWeight.w300,
    ),
    headline3: TextStyle(
      fontWeight: FontWeight.w300,
    ),
    headline4: TextStyle(
      fontWeight: FontWeight.w300,
    ),
    headline5: TextStyle(
      fontWeight: FontWeight.w300,
    ),
    headline6: TextStyle(
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
    overline: TextStyle(
      fontWeight: FontWeight.w300,
    ),
    caption: TextStyle(
      fontWeight: FontWeight.w300,
    ),
  );

  return ThemeData(
    brightness: Brightness.light,
    primarySwatch: _lightThemeColor,
    primaryColor: _lightThemeColor.shade600,
    primaryColorLight: _lightThemeColor.shade400,
    primaryColorDark: _lightThemeColor.shade900,
    primaryColorBrightness: _lightPrimaryColorBrightness,
    accentColor: _lightThemeColor.shade500,
    accentColorBrightness: _lightAccentColorBrightness,
    canvasColor: _lightCardColor,
    cardColor: _lightCardColor,
    scaffoldBackgroundColor: _lightCardColor,
    focusColor: ThemeData.light().focusColor,
    hoverColor: ThemeData.light().hoverColor,
    highlightColor: ThemeData.light().highlightColor,
    splashColor: ThemeData.light().splashColor,
    splashFactory: InkSplash.splashFactory,
    buttonTheme: ButtonThemeData(
      buttonColor: _lightThemeColor.shade600,
      height: 50,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: primaryTextTheme,
    primaryTextTheme: primaryTextTheme,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
      hintStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      contentTextStyle: TextStyle(
        fontWeight: FontWeight.w300,
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      },
    ),
    cardTheme: CardTheme(
      shape: const RoundedRectangleBorder(),
      elevation: 3,
      margin: EdgeInsets.zero,
    ),
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(
        color: Colors.black,
      ),
      color: Colors.white,
      elevation: 0,
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
  );
}

// ------------
// ---
// ------------

const Duration _kUnconfirmedSplashDuration = Duration(milliseconds: 250);
const Duration _kSplashFadeDuration = Duration(milliseconds: 200);

const double _kSplashInitialSize = 0.0; // logical pixels
const double _kSplashConfirmedVelocity = 1.0; // logical pixels per millisecond

RectCallback _getClipCallback(
    RenderBox referenceBox, bool containedInkWell, RectCallback rectCallback) {
  if (rectCallback != null) {
    assert(containedInkWell);
    return rectCallback;
  }
  if (containedInkWell) return () => Offset.zero & referenceBox.size;
  return null;
}

double _getTargetRadius(RenderBox referenceBox, bool containedInkWell,
    RectCallback rectCallback, Offset position) {
  if (containedInkWell) {
    final Size size =
        rectCallback != null ? rectCallback().size : referenceBox.size;
    return _getSplashRadiusForPositionInSize(size, position);
  }
  return Material.defaultSplashRadius;
}

double _getSplashRadiusForPositionInSize(Size bounds, Offset position) {
  final double d1 = (position - bounds.topLeft(Offset.zero)).distance;
  final double d2 = (position - bounds.topRight(Offset.zero)).distance;
  final double d3 = (position - bounds.bottomLeft(Offset.zero)).distance;
  final double d4 = (position - bounds.bottomRight(Offset.zero)).distance;
  return math.max(math.max(d1, d2), math.max(d3, d4)).ceilToDouble();
}

class _InkSplashFactory extends InteractiveInkFeatureFactory {
  const _InkSplashFactory();

  @override
  InteractiveInkFeature create({
    @required MaterialInkController controller,
    @required RenderBox referenceBox,
    @required Offset position,
    @required Color color,
    @required TextDirection textDirection,
    bool containedInkWell = false,
    RectCallback rectCallback,
    BorderRadius borderRadius,
    ShapeBorder customBorder,
    double radius,
    VoidCallback onRemoved,
  }) {
    return InkSplash(
      controller: controller,
      referenceBox: referenceBox,
      position: position,
      color: color,
      containedInkWell: containedInkWell,
      rectCallback: rectCallback,
      borderRadius: borderRadius,
      customBorder: customBorder,
      radius: radius,
      onRemoved: onRemoved,
      textDirection: textDirection,
    );
  }
}

/// A visual reaction on a piece of [Material] to user input.
///
/// A circular ink feature whose origin starts at the input touch point
/// and whose radius expands from zero.
///
/// This object is rarely created directly. Instead of creating an ink splash
/// directly, consider using an [InkResponse] or [InkWell] widget, which uses
/// gestures (such as tap and long-press) to trigger ink splashes.
///
/// See also:
///
///  * [InkRipple], which is an ink splash feature that expands more
///    aggressively than this class does.
///  * [InkResponse], which uses gestures to trigger ink highlights and ink
///    splashes in the parent [Material].
///  * [InkWell], which is a rectangular [InkResponse] (the most common type of
///    ink response).
///  * [Material], which is the widget on which the ink splash is painted.
///  * [InkHighlight], which is an ink feature that emphasizes a part of a
///    [Material].
class InkSplash extends InteractiveInkFeature {
  /// Begin a splash, centered at position relative to [referenceBox].
  ///
  /// The [controller] argument is typically obtained via
  /// `Material.of(context)`.
  ///
  /// If `containedInkWell` is true, then the splash will be sized to fit
  /// the well rectangle, then clipped to it when drawn. The well
  /// rectangle is the box returned by `rectCallback`, if provided, or
  /// otherwise is the bounds of the [referenceBox].
  ///
  /// If `containedInkWell` is false, then `rectCallback` should be null.
  /// The ink splash is clipped only to the edges of the [Material].
  /// This is the default.
  ///
  /// When the splash is removed, `onRemoved` will be called.
  InkSplash({
    @required MaterialInkController controller,
    @required RenderBox referenceBox,
    @required TextDirection textDirection,
    Offset position,
    Color color,
    bool containedInkWell = false,
    RectCallback rectCallback,
    BorderRadius borderRadius,
    ShapeBorder customBorder,
    double radius,
    VoidCallback onRemoved,
  })  : assert(textDirection != null),
        _position = position,
        _borderRadius = borderRadius ?? BorderRadius.zero,
        _customBorder = customBorder,
        _targetRadius = radius ??
            _getTargetRadius(
                referenceBox, containedInkWell, rectCallback, position),
        _clipCallback =
            _getClipCallback(referenceBox, containedInkWell, rectCallback),
        _repositionToReferenceBox = !containedInkWell,
        _textDirection = textDirection,
        super(
            controller: controller,
            referenceBox: referenceBox,
            color: color,
            onRemoved: onRemoved) {
    assert(_borderRadius != null);
    _radiusController = AnimationController(
        duration: _kUnconfirmedSplashDuration, vsync: controller.vsync)
      ..addListener(controller.markNeedsPaint)
      ..forward();
    _radius = _radiusController.drive(Tween<double>(
      begin: _kSplashInitialSize,
      end: _targetRadius,
    ));
    _alphaController = AnimationController(
        duration: _kSplashFadeDuration, vsync: controller.vsync)
      ..addListener(controller.markNeedsPaint)
      ..addStatusListener(_handleAlphaStatusChanged);
    _alpha = _alphaController.drive(IntTween(
      begin: color.alpha,
      end: 0,
    ));

    controller.addInkFeature(this);
  }

  final Offset _position;
  final BorderRadius _borderRadius;
  final ShapeBorder _customBorder;
  final double _targetRadius;
  final RectCallback _clipCallback;
  final bool _repositionToReferenceBox;
  final TextDirection _textDirection;

  Animation<double> _radius;
  AnimationController _radiusController;

  Animation<int> _alpha;
  AnimationController _alphaController;

  /// Used to specify this type of ink splash for an [InkWell], [InkResponse]
  /// or material [Theme].
  static const InteractiveInkFeatureFactory splashFactory = _InkSplashFactory();

  @override
  void confirm() {
    final int duration = (_targetRadius / _kSplashConfirmedVelocity).floor();
    _radiusController
      ..duration = Duration(milliseconds: duration)
      ..forward();
    _alphaController.forward();
  }

  @override
  void cancel() {
    _alphaController?.forward();
  }

  void _handleAlphaStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) dispose();
  }

  @override
  void dispose() {
    _radiusController.dispose();
    _alphaController.dispose();
    _alphaController = null;
    super.dispose();
  }

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {
    final Paint paint = Paint()..color = color.withAlpha(_alpha.value);
    Offset center = _position;
    if (_repositionToReferenceBox)
      center = Offset.lerp(center, referenceBox.size.center(Offset.zero),
          _radiusController.value);
    paintInkCircle(
      canvas: canvas,
      transform: transform,
      paint: paint,
      center: center,
      textDirection: _textDirection,
      radius: _radius.value,
      customBorder: _customBorder,
      borderRadius: _borderRadius,
      clipCallback: _clipCallback,
    );
  }
}
