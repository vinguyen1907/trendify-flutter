import 'package:ecommerce_app/blocs/e_wallet_cards_bloc/e_wallet_cards_bloc.dart';
import 'package:ecommerce_app/blocs/e_wallet_transactions_bloc/e_wallet_transactions_bloc.dart';
import 'package:ecommerce_app/blocs/user_bloc/user_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/extensions/string_extensions.dart';
import 'package:ecommerce_app/models/e_wallet_transaction.dart';
import 'package:ecommerce_app/models/payment_information.dart';
import 'package:ecommerce_app/repositories/e_wallet_repository.dart';
import 'package:ecommerce_app/common_widgets/primary_background.dart';
import 'package:ecommerce_app/screens/e_wallet_add_card_screen/e_wallet_add_card_screen.dart';
import 'package:ecommerce_app/screens/e_wallet_screen/e_wallet_screen.dart';
import 'package:ecommerce_app/utils/passcode_utils.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EWalletCardsScreen extends StatefulWidget {
  const EWalletCardsScreen({
    super.key,
    required this.amount,
  });

  final double amount;

  static const String routeName = "/e-wallet-cards-screen";

  @override
  State<EWalletCardsScreen> createState() => _EWalletCardsScreenState();
}

class _EWalletCardsScreenState extends State<EWalletCardsScreen> {
  PaymentInformation? selectedCard;

  @override
  void initState() {
    super.initState();
    context.read<EWalletCardsBloc>().add(LoadEWalletCards());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        children: [
          BlocBuilder<EWalletCardsBloc, EWalletCardsState>(
            builder: (context, state) {
              if (state is EWalletCardsLoaded) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.eWalletCards.length,
                    itemBuilder: (_, index) {
                      final card = state.eWalletCards[index];
                      final bool isSelected = selectedCard == card;
                      return InkWell(
                        onTap: () => _onSelectCard(card: card),
                        child: PrimaryBackground(
                          backgroundColor: isSelected
                              ? Theme.of(context).colorScheme.tertiaryContainer
                              : Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                          margin: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.defaultPadding,
                              vertical: 10),
                          child: ListTile(
                            title: Text(
                              card.cardNumber!.maskCardNumber(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: isSelected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onTertiaryContainer
                                          : Theme.of(context)
                                              .colorScheme
                                              .onSecondaryContainer),
                            ),
                          ),
                        ),
                      );
                    });
              } else if (state is EWalletCardsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is EWalletCardsError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 20),
          MyButton(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultPadding),
              backgroundColor: AppColors.greyColor,
              onPressed: () => _navigateToAddCardScreen(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.addNewCard,
                      style: AppStyles.labelLarge),
                ],
              )),
          const Spacer(),
          MyButton(
            margin: const EdgeInsets.symmetric(
                horizontal: AppDimensions.defaultPadding),
            isEnable: selectedCard != null,
            onPressed: _onContinue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.continueButton,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: AppColors.whiteColor)),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _navigateToAddCardScreen(BuildContext context) {
    Navigator.pushNamed(context, EWalletAddCardScreen.routeName);
  }

  void _onSelectCard({required PaymentInformation card}) {
    setState(() {
      selectedCard = card;
    });
  }

  void _onContinue() async {
    if (selectedCard == null) return;

    PasscodeUtils().getPasscode().then((passcode) {
      if (passcode != null) {
        Utils().showEnterPasscodeBottomSheet(
          context: context,
          passcode: passcode,
          onTruePasscode: _onTruePasscode,
        );
      } else {}
    });
  }

  void _onTruePasscode() {
    Navigator.pop(context);
    Utils().showPayingDialog(context: context);

    List<Future> tasks = [
      Future.delayed(const Duration(seconds: 2)),
      EWalletRepository().topUp(
        topUpTransaction: TopUpTransaction(
          id: "",
          type: EWalletTransactionType.topUp,
          createdTime: DateTime.now(),
          amount: widget.amount,
          cardNumber: selectedCard!.cardNumber!,
        ),
      ),
    ];
    Future.wait(tasks).then((_) {
      Navigator.popUntil(context, ModalRoute.withName(EWalletScreen.routeName));
      context.read<UserBloc>().add(ReloadUser());
      context.read<EWalletTransactionsBloc>().add(ReloadEWalletTransactions());
    });
  }
}
