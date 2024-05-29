import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/constants/enums/gender.dart';
import 'package:ecommerce_app/core/error/api_exception.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/models/user_profile.dart';
import 'package:ecommerce_app/repositories/interfaces/user_repository_interface.dart';
import 'package:ecommerce_app/services/call_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final userRepository = GetIt.I.get<IUserRepository>();

  UserBloc() : super(UserInitial()) {
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
      emit(UserLoaded(user: user));
    } on ApiException catch (e) {
      if (e.errorCode == "USER_NOT_FOUND") {
        print("Load user error: User not found");
      }
      emit(const UserError(message: "Error when loading user"));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  _onReloadUser(event, emit) async {
    try {
      final UserProfile user = await userRepository.fetchUser();
      if (state is UserLoaded) {
        emit((state as UserLoaded).copyWith(user: user));
      }
    } catch (e) {
      print("Load user error: $e");
    }
  }

  _onUpdateUser(UpdateUser event, emit) async {
    if (state is UserLoaded) {
      try {
        await userRepository.updateUser(
            name: event.name != (state as UserLoaded).user.name ? event.name : null,
            age: event.age != (state as UserLoaded).user.age ? event.age : null,
            gender: event.gender != (state as UserLoaded).user.gender ? genderToString[event.gender] : null,
            email: event.email != (state as UserLoaded).user.email ? event.email : null,
            image: event.image);
      } catch (e) {
        print("Update user error: $e");
        print("User updated");
      }

      // Reload user
      final UserProfile user = await userRepository.fetchUser();
      if (state is UserLoaded) {
        emit(UserUpdated());
        emit(UserLoaded(user: user));
      }
    }
  }

  _onProductClicked(ProductClicked event, emit) {
    userRepository.recordUserClick(event.product);
  }
}
