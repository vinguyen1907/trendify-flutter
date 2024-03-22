import 'dart:io';

import 'package:ecommerce_app/blocs/user_bloc/user_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.pickedImage,
    required this.onPressed,
  });
  final XFile? pickedImage;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return Stack(
            children: [
              Container(
                height: 80,
                width: 80,
                margin: const EdgeInsets.only(bottom: 20, right: 20),
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(12),
                  image: pickedImage != null
                      ? DecorationImage(
                          image: FileImage(File(pickedImage!.path)),
                          fit: BoxFit.cover)
                      : state.user.imageUrl.isEmpty
                          ? null
                          : DecorationImage(
                              image: NetworkImage(state.user.imageUrl),
                              fit: BoxFit.cover,
                            ),
                ),
                alignment: Alignment.center,
                child: state.user.imageUrl.isEmpty && pickedImage == null
                    ? const MyIcon(
                        icon: AppAssets.icUser,
                        height: 30,
                      )
                    : const SizedBox(),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                    onPressed: onPressed,
                    icon: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      AppColors.darkGreyColor.withOpacity(0.5),
                                  blurRadius: 2,
                                  offset: const Offset(0, 2))
                            ]),
                        alignment: Alignment.center,
                        child: const MyIcon(
                            icon: AppAssets.icEditBold, height: 14))),
              )
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
