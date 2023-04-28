import 'package:Freud_AI_app/models/auth/facebook_response_model.dart';
import 'package:Freud_AI_app/shared/constants/string_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialLoginHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookSignIn = FacebookAuth.instance;
  static String faceBookAccessToken = "";
  static String googleAccessToken = "";
  static String googleUserId = "";
  Future<UserCredential?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      googleUserId = googleSignInAccount.id;
      await googleSignInAccount.authentication.then(
        (value) {
          if (value.accessToken != null) {
            googleAccessToken = value.idToken!;
          }
        },
      );
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      return _auth.signInWithCredential(credential);
    } on PlatformException catch (e) {
      if (e.code == 'network_error') {
        EasyLoading.showToast(StringConstant.networkError,
            maskType: EasyLoadingMaskType.clear);
        // CommonWidget.errorToast(StringConstant.networkError);
      }
      print("e.message : ${e.code}");
      rethrow;
    }
  }

  Future<FaceBookModel> signInWithFacebook() async {
    FaceBookModel facebookResponse = FaceBookModel();
    final LoginResult result = await _facebookSignIn.login();
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      await FacebookAuth.instance.accessToken.then((value) {
        if (value != null) {
          faceBookAccessToken = value.token;
        }
      });
      print("Facebook User : $userData");

      facebookResponse = FaceBookModel.fromJson(userData);

      // await loginAfterFacebookLogin(
      //     context: context, result: result, dataModel: facebookResponse);
    } else if (result.status == LoginStatus.cancelled) {
      EasyLoading.showToast('Cancelled', maskType: EasyLoadingMaskType.clear);
      // CommonWidget.errorToast("Cancelled");
    } else if (result.status == LoginStatus.failed) {
      print(result.message);
      if (result.message == 'CONNECTION_FAILURE: CONNECTION_FAILURE') {
        EasyLoading.showToast(StringConstant.networkError,
            maskType: EasyLoadingMaskType.clear);
        // CommonWidget.errorToast(StringConstant.networkError);
      } else {
        EasyLoading.showToast(StringConstant.serverError,
            maskType: EasyLoadingMaskType.clear);
        // CommonWidget.errorToast(StringConstant.serverError);
      }
    } else if (result.status == LoginStatus.operationInProgress) {
      EasyLoading.showToast('Loading...', maskType: EasyLoadingMaskType.clear);
      //CommonWidget.normalToast("Loading...");
    }
    return facebookResponse;
  }

  Future<AuthorizationCredentialAppleID> signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    print("APPPLECRED : $credential");
    return credential;
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<void> signOutFromFaceBook() async {
    await _facebookSignIn.logOut();
    await _auth.signOut();
  }
}
