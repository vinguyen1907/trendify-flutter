import 'package:ecommerce_app/blocs/search_filter_bloc/search_filter_bloc.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/screens/filter_screen/widgets/sort_type_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortTypeBar extends StatelessWidget {
  const SortTypeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchFilterBloc, SearchFilterState>(
      builder: (context, state) {
        final currentState = state as SearchFilterLoaded;
        List<SortTypeItem> listItem = currentState.filterItem.sortTypes!
            .map((e) => SortTypeItem(
                onTap: () {
                  context
                      .read<SearchFilterBloc>()
                      .add(ChooseSortType(sortType: e));
                },
                sortType: e,
                isSelected: e == currentState.filterItem.sortTypeSelected))
            .toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ScreenNameSection(label: 'Sort By'),
            Padding(
              padding:
                  const EdgeInsets.only(left: AppDimensions.defaultPadding),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 8.0,
                runSpacing: 8.0,
                children: listItem,
              ),
            ),
          ],
        );
      },
    );
  }
}
