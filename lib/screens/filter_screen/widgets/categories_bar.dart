import 'package:ecommerce_app/blocs/search_filter_bloc/search_filter_bloc.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/screens/filter_screen/widgets/category_filter_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBar extends StatelessWidget {
  const CategoriesBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchFilterBloc, SearchFilterState>(
      builder: (context, state) {
        final currentState = state as SearchFilterLoaded;
        List<CategoryFilerItem> listItem = List.generate(
            currentState.filterItem.categories!.length,
            (index) => CategoryFilerItem(
                  category: currentState.filterItem.categories![index],
                  isSelected: currentState.filterItem.categories![index] ==
                      currentState.filterItem.categorySelected,
                  onTap: () {
                    context.read<SearchFilterBloc>().add(ChooseCategory(
                        category: currentState.filterItem.categories![index]));
                  },
                ));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ScreenNameSection(label: 'Category'),
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
