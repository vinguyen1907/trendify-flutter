import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class CustomThumbShape extends SfThumbShape {
  final double textScaleFactor;
  final SfRangeValues values;
  final TextPainter _textPainter;
  TextSpan _textSpan;
  final double verticalSpacing = 5.0;

  CustomThumbShape({required this.textScaleFactor, required this.values})
      : _textSpan = const TextSpan(),
        _textPainter = TextPainter();

  @override
  Size getPreferredSize(SfSliderThemeData themeData) {
    _textSpan = TextSpan(text: values.start.toInt().toString());
    _textPainter
      ..text = _textSpan
      ..textDirection = TextDirection.ltr
      ..textScaleFactor = textScaleFactor
      ..layout();
    return Size(themeData.thumbRadius * 2,
        (themeData.thumbRadius + _textPainter.height + verticalSpacing) * 2);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
      required RenderBox? child,
      required SfSliderThemeData themeData,
      SfRangeValues? currentValues,
      dynamic currentValue,
      required Paint? paint,
      required Animation<double> enableAnimation,
      required TextDirection textDirection,
      required SfThumb? thumb}) {
    final Canvas canvas = context.canvas;

    final Paint borderPaint = Paint()
      ..color = AppColors.primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final Paint fillPaint = Paint()
      ..color = AppColors.whiteColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 10, borderPaint);
    canvas.drawCircle(center, 10 - 1, fillPaint);
    String text = currentValues!.end.toStringAsFixed(0);
    if (thumb != null) {
      text = (thumb == SfThumb.start ? currentValues.start : currentValues.end)
          .toStringAsFixed(0);
    }
    _textSpan = TextSpan(
      text: '\$$text',
      style: AppStyles.labelLarge,
    );
    _textPainter
      ..text = _textSpan
      ..textDirection = textDirection
      ..textScaleFactor = textScaleFactor
      ..layout()
      ..paint(
        context.canvas,
        // To show the label below the thumb, we had added it with thumb radius
        // and constant vertical spacing.
        Offset(center.dx - _textPainter.width / 2,
            center.dy + verticalSpacing + themeData.thumbRadius + 5),
      );
  }
}
