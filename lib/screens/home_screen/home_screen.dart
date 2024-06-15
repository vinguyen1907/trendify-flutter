import 'package:ecommerce_app/blocs/home_bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    // context.read<HomeBloc>().add(const LoadHome());
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > 100) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
      context.read<HomeBloc>().add(const LoadMoreRecommendedProducts());
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: HomeAppBar(
            height: size.height * 0.09,
            isScrolled: _isScrolled,
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HomeLoaded) {
                return SingleChildScrollView(
                  controller: _scrollController,
                  child: const Column(
                    children: [
                      HeaderHome(),
                      PromotionsHome(),
                      RecommendedProducts(),
                      // PopularHome()
                    ],
                  ),
                );
              } else if (state is HomeError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Container();
              }
            },
          )),
    );
  }
}
