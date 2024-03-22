import 'package:ecommerce_app/blocs/search_filter_bloc/search_filter_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/screens/filter_screen/widgets/categories_bar.dart';
import 'package:ecommerce_app/screens/filter_screen/widgets/price_range_bar.dart';
import 'package:ecommerce_app/screens/filter_screen/widgets/rating_bar.dart';
import 'package:ecommerce_app/screens/filter_screen/widgets/sort_type_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});
  static const String routeName = '/filter-screen';
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CategoriesBar(),
            const PriceRangeBar(),
            const SortTypeBar(),
            const RatingBar(),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
                width: size.width,
                height: size.height * 0.07,
                margin: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.defaultPadding, vertical: 20),
                child: MyButton(
                    child: Text(
                      "Apply Now",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: AppColors.whiteColor),
                    ),
                    onPressed: () => _applyFilter()))
          ],
        ),
      ),
    );
  }

  _applyFilter() {
    context.read<SearchFilterBloc>().add(const ApplyFilter());
    Navigator.pop(context);
  }
}
