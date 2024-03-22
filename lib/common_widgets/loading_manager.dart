import 'package:ecommerce_app/common_widgets/plane_loading_widget.dart';
import 'package:flutter/material.dart';

class LoadingManager extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  const LoadingManager({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: const Center(
              child: PlaneLoadingWidget(),
            ),
          ),
      ],
    );
  }
}

class Loading1Manager {
  static Loading1Manager? _instance;
  static bool isShowing = false;

  static Loading1Manager get instance {
    _instance ??= Loading1Manager();
    return _instance!;
  }

  Future<void> showLoadingDialog(BuildContext context) async {
    if (isShowing) {
      closeLoadingDialog(context);
    }
    isShowing = true;
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return PopScope(
          canPop: true,
          child: Container(
            color: Colors.black.withOpacity(0.3),
            child: const Center(
              child: PlaneLoadingWidget(),
            ),
          ),
        );
      },
    );
  }

  void closeLoadingDialog(BuildContext context) {
    if (isShowing) {
      isShowing = false;
      Navigator.pop(context);
    }
  }
}
