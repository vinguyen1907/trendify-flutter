import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/repositories/cart_repository.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository _cartRepository = GetIt.I.get();

  CartBloc() : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<RemoveItem>(_onRemoveItem);
    on<UpdateItem>(_onUpdateItem);
    on<UpdateCart>(_onUpdateCart);
    on<InitConnection>(_onInitConnection);
  }

  _onLoadCart(event, emit) async {
    try {
      emit(CartLoading());
      final Cart cart = await CartRepository().fetchMyCart();
      emit(CartLoaded(cart: cart));
    } catch (e) {
      print("Load cart error: $e");
      emit(CartError(e.toString()));
    }
  }

  _onRemoveItem(event, emit) async {
    try {
      await _cartRepository.removeCartItem(cartItemId: event.cartItemId);
      if (state is CartLoaded) {
        final List<CartItem> cartItems = (state as CartLoaded).cart.cartItems;
        final List<CartItem> newCartItems = cartItems.where((element) => element.id != event.cartItemId).toList();
        emit(CartLoaded(cart: Cart(cartItems: newCartItems)));
      }
    } catch (e) {
      print("Remove item error: $e");
    }
  }

  _onUpdateItem(event, emit) async {
    try {
      if (state is CartLoaded) {
        // final List<CartItem> cartItems = (state as CartLoaded).cart.cartItems;
        // final List<CartItem> newCartItems = cartItems.map((e) {
        //   if (e.id == event.cartItemId) {
        //     return e.copyWith(quantity: event.quantity);
        //   }
        //   return e;
        // }).toList();
        // emit(CartLoaded(cart: Cart(cartItems: newCartItems)));

        await _cartRepository.updateCartItem(cartItemId: event.cartItemId, quantity: event.quantity);
      }
    } catch (e) {
      print("Update item error: $e");
    }
  }

  _onUpdateCart(event, emit) {
    emit(CartLoaded(cart: event.cart));
  }

  _onInitConnection(event, emit) {
    _cartRepository.connect(event.updateCart);
  }
}
