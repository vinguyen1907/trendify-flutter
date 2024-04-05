import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:ecommerce_app/models/user_profile.dart';
import 'package:ecommerce_app/repositories/interfaces/user_repository_interface.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository implements IUserRepository {
  @override
  Future<void> createNewUser({required String id, required String email, required String name}) {
    // TODO: implement createNewUser
    throw UnimplementedError();
  }

  @override
  Future<UserProfile> fetchUser() {
    // TODO: implement fetchUser
    throw UnimplementedError();
  }

  @override
  Future<void> updateDefaultShippingAddress({required ShippingAddress newDefaultAddress}) {
    // TODO: implement updateDefaultShippingAddress
    throw UnimplementedError();
  }

  @override
  Future<void> updateFcmToken() {
    // TODO: implement updateFcmToken
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser({String? name, String? gender, int? age, String? email, XFile? image}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
