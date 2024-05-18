import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/models/user_profile.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:ecommerce_app/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository implements IAuthRepository {
  final SharedPreferences sharedPreferences = GetIt.I.get<SharedPreferences>();

  @override
  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Create user profile on Firestore
      UserProfile user = UserProfile(
          id: firebaseAuth.currentUser!.uid,
          name: name,
          gender: null,
          age: null,
          email: email,
          eWalletBalance: 0);
      await currentUserRef.set(user.toMap());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw FirebaseAuthException(
            message: 'The password provided is too weak.', code: e.code);
      } else if (e.code == 'email-already-in-use') {
        throw FirebaseAuthException(
            message: 'The account already exists for that email.',
            code: e.code);
      }
    } catch (e) {
      throw Exception('Sign Up Failure');
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw FirebaseAuthException(
            message: 'No user found for that email.', code: e.code);
      } else if (e.code == 'wrong-password') {
        throw FirebaseAuthException(
            message: 'Wrong password provided for that user.', code: e.code);
      }
    } catch (e) {
      throw Exception('Sign In Failure');
    }
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // Check if this user is already have profile on database
    // Don't have => Create user profile on Firestore
    final DocumentSnapshot doc =
        await usersRef.doc(userCredential.user?.uid).get();
    if (!doc.exists) {
      await UserRepository().createNewUser(
          id: firebaseAuth.currentUser!.uid,
          name: userCredential.user?.displayName ?? "",
          email: userCredential.user?.email ?? "");
    }

    return userCredential;
  }

  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   // final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   // final OAuthCredential facebookAuthCredential =
  //   //     FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //   //
  //   // // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }

  @override
  Future<void> logOut() async {
    await sharedPreferences.setBool(SharedPreferencesKeys.alreadyAuthenticated, false);
    await firebaseAuth.signOut();
  }
}
