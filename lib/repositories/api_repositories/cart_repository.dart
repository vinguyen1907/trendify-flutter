import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/blocs/product_bloc/product_bloc.dart';
import 'package:ecommerce_app/constants/api_constants.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class CartRepository implements ICartRepository {
  // late final WebSocketChannel channel;
  late final StompClient _stompClient;
  final Dio dio = Dio();
  final FlutterSecureStorage secureStorage = GetIt.I.get<FlutterSecureStorage>();

  CartRepository({required String url});

  @override
  void connect(Function(Cart) updateCart) {
    print("WebSocket -- Connecting ...");
    _stompClient = StompClient(
      config: StompConfig(
        url: ApiConstants.webSocketUrl,
        stompConnectHeaders: {
          'Authorization':
              "Bearer eyJhbGciOiJIUzM4NCJ9.eyJ1c2VySWQiOjg1Miwic3ViIjoiYWJjZEBnbWFpbC5jb20iLCJpYXQiOjE3MTYxMDY2MjN9.u_idNMENuJzipZkpoUsjPx9_6SHDaNz8magDq1c-m1ba3w2L1JBVuIIkckELSD8a"
        },
        webSocketConnectHeaders: {
          'Authorization':
              "Bearer eyJhbGciOiJIUzM4NCJ9.eyJ1c2VySWQiOjg1Miwic3ViIjoiYWJjZEBnbWFpbC5jb20iLCJpYXQiOjE3MTYxMDY2MjN9.u_idNMENuJzipZkpoUsjPx9_6SHDaNz8magDq1c-m1ba3w2L1JBVuIIkckELSD8a"
        },
        onConnect: (frame) {
          _onConnect(frame, updateCart);
        },
        onWebSocketDone: () {
          print('WebSocket -- onWebSocketDone!');
        },
        onWebSocketError: (dynamic error) => print("WebSocket -- ERROR: $error"),
        onStompError: (error) => print("Stomp -- ERROR: ${error.command} ${error.headers} ${error.body}"),
        heartbeatOutgoing: const Duration(seconds: 10), // Send pings every 10 seconds
        heartbeatIncoming: const Duration(seconds: 10), // Expect pings every 10 seconds
      ),
    );

    _stompClient.activate();
  }

  void _onConnect(StompFrame frame, Function(Cart) updateCart) {
    print("Websocket -- CONNECTED");
    int userId = 852;
    _stompClient.subscribe(
      destination: '/topic/cart/$userId',
      callback: (message) {
        print("Websocket -- RECEIVED MESSAGE: ${message.body}");
        String? body = message.body;
        if (body == null) return;

        List<dynamic> maps = jsonDecode(body);
        List<CartItem> cartItems = maps.map((e) => CartItem.fromMap(e)).toList();
        Cart cart = Cart(cartItems: cartItems);

        updateCart(cart);
      },
    );
    _stompClient.send(
        destination: "/app/cart/get",
        body: jsonEncode({
          "user_id": 852,
        }));
  }

  @override
  void dispose() {
    _stompClient.deactivate();
  }

  @override
  Future<void> addCartItem({required String productId, required String size, required String color, required int quantity}) async {
    _stompClient.send(
        destination: "/app/cart/add",
        body: jsonEncode({
          "user_id": 852,
          "product_id": productId,
          "quantity": quantity,
          "size": size,
          "color": color,
        }));
  }

  @override
  Future<void> removeCartItem({required String cartItemId}) {
    // TODO: implement removeCartItem
    throw UnimplementedError();
  }

  @override
  Future<void> undoAddCartItem({required ProductLoaded cartItem}) {
    // TODO: implement undoAddCartItem
    throw UnimplementedError();
  }

  @override
  Future<void> updateCartItem({required String cartItemId, required int quantity}) {
    // TODO: implement updateCartItem
    throw UnimplementedError();
  }
}
