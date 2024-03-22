import 'package:ecommerce_app/blocs/user_bloc/user_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/common_widgets/primary_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInformationCard extends StatelessWidget {
  const ProfileInformationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return PrimaryBackground(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: AppColors.greyColor,
                      borderRadius: BorderRadius.circular(10),
                      image: state.user.imageUrl.isEmpty
                          ? null
                          : DecorationImage(
                              image: NetworkImage(state.user.imageUrl),
                              fit: BoxFit.cover,
                            ),
                    ),
                    alignment: Alignment.center,
                    child: state.user.imageUrl.isEmpty
                        ? const MyIcon(
                            icon: AppAssets.icUser,
                            height: 30,
                          )
                        : const SizedBox(),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.user.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor),
                        ),
                        Text(state.user.email,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  )
                ],
              ));
        }
        return Container();
      },
    );
  }
}
