import 'package:ecommerce_app/blocs/search_filter_bloc/search_filter_bloc.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/screens/filter_screen/filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final searchFilterBloc = BlocProvider.of<SearchFilterBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.defaultPadding, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ScreenNameSection(
                label: title,
                margin: EdgeInsets.zero,
              ),
              InkWell(
                onTap: () {
                  searchFilterBloc.originalList.length > 1
                      ? Navigator.pushNamed(context, FilterScreen.routeName)
                      : null;
                },
                child: const Icon(Icons.tune),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          SvgPicture.asset(
            AppAssets.imgNotFound,
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Not Found",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            "Sorry, the keyword you entered cannot be found, please check again or search with another keyword.",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
