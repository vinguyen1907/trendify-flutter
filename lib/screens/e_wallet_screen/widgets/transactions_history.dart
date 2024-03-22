import 'package:ecommerce_app/blocs/e_wallet_transactions_bloc/e_wallet_transactions_bloc.dart';
import 'package:ecommerce_app/models/e_wallet_transaction.dart';
import 'package:ecommerce_app/screens/e_wallet_screen/widgets/transaction_item_widget.dart';
import 'package:ecommerce_app/screens/e_wallet_transaction_screen/e_wallet_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsHistory extends StatelessWidget {
  const TransactionsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EWalletTransactionsBloc, EWalletTransactionsState>(
      builder: (context, state) {
        if (state is EWalletTransactionsLoaded) {
          return Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.eWalletTransactions.length,
                itemBuilder: (_, index) {
                  final transaction = state.eWalletTransactions[index];
                  return InkWell(
                    onTap: () => _onSelectTransaction(
                        context: context, transaction: transaction),
                    child: TransactionItemWidget(transaction: transaction),
                  );
                }),
          );
        } else if (state is EWalletTransactionsError) {
          return Center(
            // child: Text("Something went wrong."),
            child: Text(state.message),
          );
        }
        return const SizedBox();
      },
    );
  }

  _onSelectTransaction(
      {required BuildContext context,
      required EWalletTransaction transaction}) {
    Navigator.pushNamed(context, TransactionDetailsScreen.routeName,
        arguments: transaction);
  }
}
