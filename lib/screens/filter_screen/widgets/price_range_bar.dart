import 'package:ecommerce_app/blocs/search_filter_bloc/search_filter_bloc.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/extensions/screen_extensions.dart';
import 'package:ecommerce_app/screens/filter_screen/widgets/custom_thump_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import "dart:math";

class PriceRangeBar extends StatefulWidget {
  const PriceRangeBar({super.key});

  @override
  State<PriceRangeBar> createState() => _PriceRangeBarState();
}

class _PriceRangeBarState extends State<PriceRangeBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchFilterBloc, SearchFilterState>(
      builder: (context, state) {
        final currentState = state as SearchFilterLoaded;
        final double maxValue = currentState.filterItem.priceValues!.end;
        final double stepSize = pow(10, maxValue.countDigits() - 2).toDouble();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ScreenNameSection(
              label: 'Price Range',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultPadding - 15),
              child: SfRangeSlider(
                min: currentState.filterItem.priceValues!.start,
                max: currentState.filterItem.priceValues!.end,
                values: currentState.filterItem.priceValuesSelected!,
                activeColor: AppColors.primaryColor,
                inactiveColor: AppColors.greyColor,
                stepSize: stepSize,
                thumbShape: CustomThumbShape(
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    values: currentState.filterItem.priceValuesSelected!),
                onChanged: (SfRangeValues newValues) {
                  context
                      .read<SearchFilterBloc>()
                      .add(ChoosePriceValues(priceValues: newValues));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
