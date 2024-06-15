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
        if (state.user != null) {
          return Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.1),
                      Theme.of(context).primaryColor.withOpacity(0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white, // Màu trắng giữa viền gradient và ảnh
                    shape: BoxShape.circle,
                    image: pickedImage != null
                        ? DecorationImage(
                            image: FileImage(File(pickedImage!.path)),
                            fit: BoxFit.contain,
                          )
                        : state.user!.imageUrl == null || state.user!.imageUrl!.isEmpty
                            ? null
                            : DecorationImage(
                                image: NetworkImage(state.user!.imageUrl!),
                                fit: BoxFit.cover,
                              ),
                  ),
                  alignment: Alignment.center,
                  child: (state.user!.imageUrl == null || state.user!.imageUrl!.isEmpty) && pickedImage == null
                      ? const MyIcon(
                          icon: AppAssets.icUser,
                          height: 50,
                        )
                      : const SizedBox(),
                  // child: CircleAvatar(
                  //   backgroundImage: NetworkImage(imageUrl),
                  //   radius: 50.0, // Bán kính của ảnh
                  // ),
                ),
              ),
              // Container(
              //   height: 80,
              //   width: 80,
              //   margin: const EdgeInsets.only(bottom: 20, right: 20),
              //   decoration: BoxDecoration(
              //     color: AppColors.greyColor,
              //     borderRadius: BorderRadius.circular(12),
              //     image: pickedImage != null
              //         ? DecorationImage(
              //             image: FileImage(File(pickedImage!.path)),
              //             fit: BoxFit.cover)
              //         : state.user.imageUrl == null || state.user.imageUrl!.isEmpty
              //             ? null
              //             : DecorationImage(
              //                 image: NetworkImage(state.user.imageUrl!),
              //                 fit: BoxFit.cover,
              //               ),
              //   ),
              //   alignment: Alignment.center,
              //   child: (state.user.imageUrl == null || state.user.imageUrl!.isEmpty) && pickedImage == null
              //       ? const MyIcon(
              //           icon: AppAssets.icUser,
              //           height: 30,
              //         )
              //       : const SizedBox(),
              // ),
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
                            boxShadow: [BoxShadow(color: AppColors.darkGreyColor.withOpacity(0.5), blurRadius: 2, offset: const Offset(0, 2))]),
                        alignment: Alignment.center,
                        child: const MyIcon(icon: AppAssets.icEditBold, height: 14))),
              )
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
