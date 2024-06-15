import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/constants/enums/gender.dart';
import 'package:ecommerce_app/core/error/api_exception.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/repositories/interfaces/user_repository_interface.dart';
import 'package:ecommerce_app/services/call_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final userRepository = GetIt.I.get<IUserRepository>();

  UserBloc() : super(const UserState(status: UserStatus.initial)) {
    on<LoadUser>(_onLoadUser);
    on<ReloadUser>(_onReloadUser);
    on<UpdateUser>(_onUpdateUser);
    on<ProductClicked>(_onProductClicked);
  }

  _onLoadUser(event, emit) async {
    try {
      final UserProfile user = await userRepository.fetchUser();
      if (user.id != null) {
        await userRepository.updateFcmToken(user.id!);
      }
      await CallService().initCallService(user);
      emit(state.copyWith(status: UserStatus.loaded, user: user));
    } on ApiException catch (e) {
      if (e.errorCode == "USER_NOT_FOUND") {
        print("Load user error: User not found");
      }

      emit(state.copyWith(status: UserStatus.error, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.error, message: e.toString()));
    }
  }

  _onReloadUser(event, emit) async {
    try {
      final UserProfile user = await userRepository.fetchUser();
      if (state.status == UserStatus.loaded) {
        emit(state.copyWith(status: UserStatus.loaded, user: user));
      }
    } catch (e) {
      print("Load user error: $e");
    }
  }

  _onUpdateUser(UpdateUser event, emit) async {
    if (state.status == UserStatus.loaded && state.user != null) {
      try {
        await userRepository.updateUser(
            name: event.name != state.user!.name ? event.name : null,
            age: event.age != state.user!.age ? event.age : null,
            gender: event.gender != state.user!.gender ? event.gender.name : null,
            email: event.email != state.user!.email ? event.email : null,
            image: event.image);
      } catch (e) {
        emit(state.copyWith(status: UserStatus.error, message: e.toString()));
        emit(state.copyWith(status: UserStatus.loaded, user: state.user));
        return;
      }

      // Reload user
      final UserProfile user = await userRepository.fetchUser();
      if (state.status == UserStatus.loaded && state.user != null) {
        emit(state.copyWith(status: UserStatus.updated));
        emit(state.copyWith(status: UserStatus.loaded, user: user));
      }
    }
  }

  _onProductClicked(ProductClicked event, emit) {
    userRepository.recordUserClick(event.product);
  }
}
