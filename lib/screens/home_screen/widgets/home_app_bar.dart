import 'package:ecommerce_app/blocs/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constants.dart';
import '../../screens.dart';
import '../../search_screen/widgets/widgets.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, required this.height, required this.isScrolled});
  final double height;
  final bool isScrolled;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => _navigateCategoryScreen(context),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                radius: 18,
                child: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
            ),
            !isScrolled
                ? BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserLoading) {
                        return const CircleAvatar(
                          backgroundColor: AppColors.greyColor,
                          radius: 22,
                        );
                      } else if (state is UserLoaded) {
                        return (state.user.imageUrl != null && state.user.imageUrl!.isNotEmpty)
                            ? CircleAvatar(
                                backgroundImage:
                                    NetworkImage(state.user.imageUrl!),
                                radius: 22,
                              )
                            : const CircleAvatar(
                                backgroundColor: AppColors.greyColor,
                                radius: 22,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              );
                      } else {
                        return Container();
                      }
                    },
                  )
                : IconButton(
                    onPressed: () {
                      showSearch(
                          context: context, delegate: CustomSearchDelegate());
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                    )),
          ],
        ),
      ),
    );
  }

  _navigateCategoryScreen(BuildContext context) {
    Navigator.pushNamed(context, CategoryScreen.routeName);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}
