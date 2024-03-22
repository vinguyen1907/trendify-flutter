import 'package:ecommerce_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:ecommerce_app/blocs/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});
  static const String routeName = '/test-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  return Text(state.user.toJson());
                }
                return const Text("Error");
              },
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LogOut());
                },
                child: const Text("Sign out"))
          ],
        ),
      ),
    );
  }
}
