import 'package:e_shop/data/repositories/banners/banner_repository.dart';
import 'package:e_shop/data/repositories/categories/category_repository.dart';
import 'package:e_shop/data/repositories/products/product_repository.dart';
import 'package:e_shop/data/repositories/user/user_repository.dart';
import 'package:e_shop/features/authentication/view/login/login.dart';
import 'package:e_shop/features/authentication/view/onboarding/onboarding.dart';
import 'package:e_shop/features/authentication/view/signup/verify_email.dart';
import 'package:e_shop/features/shop/models/category_model.dart';
import 'package:e_shop/navigation_menu.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/local_storage/storage_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  ///Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  //Return Authenticated User Data
  User? get authUser => _auth.currentUser;

  final productRepository = ProductRepository();

  //called automatically from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
    productRepository.uploadDummyProducts();
  }

  //Function to switch to relevant Screen
  void screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        //Initialise user specific local storage
        await AppLocalStorage.init(user.uid);

        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      //check local storage if it is furst login of user
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  ///--------------------Email and Password Sign In---------------------
  ///
  ///[Email Authentication] -  login

  Future<UserCredential> loginWithEmailAndPassowrd(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///
  /// ///[Email Authentication] - Register
  Future<UserCredential> registerWithEmailAndPassowrd(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[Email Verification] - Mail verification
  Future<void> sendVerificationEmail() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[Email Authentication] - FORGOT PASSWORD
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [GoogleAuthentication] -- log in with google account
  Future<UserCredential?> signInWithGoogle() async {
    try {
      //Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      //obtain the auth details
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      //create a new credential
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      // Once signed in , return user Credential
      return await _auth.signInWithCredential(credentials);

      //
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[ReAuthentication] - Re authenticate user
  Future<void> reAuthenticationWithEmailAndPassword(
      String email, String password) async {
    try {
      //create a credential
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      //reauthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[Logout User] - valid for any authentication
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[Delete Account] - delete user Account
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
