import 'package:ecommerce_app/blocs/e_wallet_transactions_bloc/e_wallet_transactions_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/models/e_wallet_transaction.dart';
import 'package:ecommerce_app/screens/e_wallet_screen/widgets/transaction_item_widget.dart';
import 'package:ecommerce_app/screens/e_wallet_transaction_screen/e_wallet_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllTransactionHistoryScreen extends StatefulWidget {
  const AllTransactionHistoryScreen({super.key});

  static const String routeName = "/all-transactions-history-screen";

  @override
  State<AllTransactionHistoryScreen> createState() =>
      _AllTransactionHistoryScreenState();
}

class _AllTransactionHistoryScreenState
    extends State<AllTransactionHistoryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context
            .read<EWalletTransactionsBloc>()
            .add(LoadMoreEWalletTransactions());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenNameSection(label: "Transaction History"),
          BlocBuilder<EWalletTransactionsBloc, EWalletTransactionsState>(
            builder: (context, state) {
              if (state is EWalletTransactionsLoaded) {
                return Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: state.eWalletTransactions.length,
                    itemBuilder: (_, index) {
                      final transaction = state.eWalletTransactions[index];
                      return InkWell(
                        onTap: () => _onSelectTransaction(
                            context: context, transaction: transaction),
                        child: TransactionItemWidget(transaction: transaction),
                      );
                    },
                  ),
                );
              } else if (state is EWalletTransactionsError) {
                return const Center(
                  child: Text("Something went wrong."),
                );
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }

  _onSelectTransaction(
      {required BuildContext context,
      required EWalletTransaction transaction}) {
    Navigator.pushNamed(context, TransactionDetailsScreen.routeName,
        arguments: transaction);
  }
}
