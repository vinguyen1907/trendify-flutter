import 'package:ecommerce_app/blocs/search_filter_bloc/search_filter_bloc.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/screens/filter_screen/widgets/rating_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RatingBar extends StatelessWidget {
  const RatingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchFilterBloc, SearchFilterState>(
      builder: (context, state) {
        final currentState = state as SearchFilterLoaded;
        List<Widget> listItems = List.generate(
            4,
            (index) => RatingItem(
                onTap: () {
                  context
                      .read<SearchFilterBloc>()
                      .add(ChooseRatting(ratting: 5 - index));
                },
                isSelected: 5 - index == currentState.filterItem.ratingSelected,
                value: 5 - index));
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScreenNameSection(
                label: 'Ratting',
                margin: EdgeInsets.symmetric(vertical: 15),
              ),
              Column(
                children: listItems,
              ),
            ],
          ),
        );
      },
    );
  }
}
