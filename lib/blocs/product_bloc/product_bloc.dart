import 'package:ecommerce_app/blocs/show_notification/show_notification_bloc.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/models/product_detail.dart';
import 'package:ecommerce_app/repositories/cart_repository.dart';
import 'package:ecommerce_app/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required this.showNotificationBloc}) : super(ProductInitial()) {
    on<LoadProductDetails>(_onLoadProductDetails);
    on<ChooseSize>(_onChooseSize);
    on<ChooseColor>(_onChooseColor);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
    on<AddToCart>(_onAddToCart);
    on<UndoAddToCart>(_onUndoAddToCart);
  }
  final ShowNotificationBloc showNotificationBloc;
  _onLoadProductDetails(LoadProductDetails event, Emitter emit) async {
    try {
      emit(ProductLoading());
      final List<ProductDetail> productDetails =
          await ProductRepository().fetchProductDetails(event.product);
      productDetails.sort(customSizeSort);
      final Map<String, List<ProductDetail>> sizeGroups =
          groupBy(productDetails, (ProductDetail detail) => detail.size!);
      final String sizeSelected = sizeGroups.keys.elementAt(0);
      final List<ProductDetail> productDetailSelected =
          sizeGroups[sizeSelected]!..sort(customColorSort);
      final String colorSelected = productDetailSelected[0].color!;
      int quantity = 1;
      emit(ProductLoaded(
          productId: event.product.id,
          productDetails: productDetails,
          sizeGroups: sizeGroups,
          sizeSelected: sizeSelected,
          colorSelected: colorSelected,
          quantity: quantity));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  _onChooseSize(ChooseSize event, Emitter emit) {
    final currentState = state as ProductLoaded;
    final Map<String, List<ProductDetail>> sizeGroups = currentState.sizeGroups;
    final String sizeSelected = event.size;
    final List<ProductDetail> productDetailSelected = sizeGroups[sizeSelected]!
      ..sort(customColorSort);
    final String colorSelected = productDetailSelected[0].color!;
    emit(ProductLoaded(
        productId: currentState.productId,
        productDetails: currentState.productDetails,
        sizeGroups: sizeGroups,
        sizeSelected: sizeSelected,
        colorSelected: colorSelected,
        quantity: currentState.quantity));
  }

  _onChooseColor(ChooseColor event, Emitter emit) {
    final currentState = state as ProductLoaded;
    final String colorSelected = event.color;
    emit(ProductLoaded(
        productId: currentState.productId,
        productDetails: currentState.productDetails,
        sizeGroups: currentState.sizeGroups,
        sizeSelected: currentState.sizeSelected,
        colorSelected: colorSelected,
        quantity: currentState.quantity));
  }

  int customSizeSort(ProductDetail a, ProductDetail b) {
    final orderMap = {
      'S': 0,
      'M': 1,
      'L': 2,
      '6': 3,
      '6.5': 4,
      '7': 5,
      '7.5': 6,
      '8': 7,
      '8.5': 8,
      '9': 9,
    };
    return orderMap[a.size]! - orderMap[b.size]!;
  }

  int customColorSort(ProductDetail a, ProductDetail b) {
    return int.parse(a.color!.substring(1, 7), radix: 16) -
        int.parse(b.color!.substring(1, 7), radix: 16);
  }

  _onIncreaseQuantity(IncreaseQuantity event, Emitter emit) {
    final currentState = state as ProductLoaded;
    int quantity = currentState.quantity;
    final temp = currentState.sizeGroups[currentState.sizeSelected]!
        .where((element) => element.color == currentState.colorSelected)
        .elementAt(0);
    if (quantity + 1 <= temp.stock) {
      quantity += 1;
    }
    emit(ProductLoaded(
        productId: currentState.productId,
        productDetails: currentState.productDetails,
        sizeGroups: currentState.sizeGroups,
        sizeSelected: currentState.sizeSelected,
        colorSelected: currentState.colorSelected,
        quantity: quantity));
  }

  _onDecreaseQuantity(DecreaseQuantity event, Emitter emit) {
    final currentState = state as ProductLoaded;
    int quantity = currentState.quantity;
    if (quantity - 1 > 0) {
      quantity -= 1;
    }
    emit(ProductLoaded(
        productId: currentState.productId,
        productDetails: currentState.productDetails,
        sizeGroups: currentState.sizeGroups,
        sizeSelected: currentState.sizeSelected,
        colorSelected: currentState.colorSelected,
        quantity: quantity));
  }

  _onAddToCart(AddToCart event, Emitter<ProductState> emit) async {
    final currentState = state as ProductLoaded;
    await CartRepository().addCartItem(
        productId: currentState.productId,
        size: currentState.sizeSelected,
        color: currentState.colorSelected,
        quantity: currentState.quantity);
    showNotificationBloc.add(const ShowAddToCartSuccess());
    emit(ProductLoaded(
        productId: currentState.productId,
        productDetails: currentState.productDetails,
        sizeGroups: currentState.sizeGroups,
        sizeSelected: currentState.sizeSelected,
        colorSelected: currentState.colorSelected,
        quantity: currentState.quantity));
  }

  _onUndoAddToCart(UndoAddToCart event, Emitter<ProductState> emit) async {
    final currentState = state as ProductLoaded;
    await CartRepository().undoAddCartItem(cartItem: currentState);
    showNotificationBloc.add(const ShowUndoAddToCartSuccess());
    emit(ProductLoaded(
        productId: currentState.productId,
        productDetails: currentState.productDetails,
        sizeGroups: currentState.sizeGroups,
        sizeSelected: currentState.sizeSelected,
        colorSelected: currentState.colorSelected,
        quantity: currentState.quantity));
  }
}
