import 'package:ecommerce_app/blocs/user_bloc/user_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/screens/top_up_screen/top_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin:
          const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Your balance",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer)),
          const SizedBox(height: 10),
          Wrap(
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return Expanded(
                    child: Text(
                      "\$${(state is UserLoaded) ? state.user.eWalletBalance : 0}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  );
                },
              ),
              const Spacer(),
              MyButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  onPressed: () => _navigateToTopUpScreen(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyIcon(
                        icon: AppAssets.icTopUp,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.onSecondaryContainer,
                            BlendMode.srcIn),
                      ),
                      const SizedBox(width: 5),
                      Text("Top Up",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer))
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToTopUpScreen(BuildContext context) {
    Navigator.pushNamed(context, TopUpScreen.routeName);
  }
}
