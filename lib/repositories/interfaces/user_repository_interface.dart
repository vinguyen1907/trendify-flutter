import 'package:image_picker/image_picker.dart';

import '../../models/models.dart';

abstract class IUserRepository {
  Future<UserProfile> fetchUser();

  Future<void> updateUser({
    String? name,
    String? gender,
    int? age,
    String? email,
    XFile? image,
  });

  Future<void> createNewUser({
    required String id,
    required String email,
    required String name,
  });

  Future<void> updateDefaultShippingAddress({required ShippingAddress newDefaultAddress});

  Future<void> updateFcmToken(String userId);
}
