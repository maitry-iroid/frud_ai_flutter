// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:io';

import 'package:Freud_AI_app/api/api_repository.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import '../models/response/common_response.dart';

class InAppPurchaseHelper extends GetxController {
  final InAppPurchase inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> subscription;

  List<String> notFoundIds = [];
  var products = <ProductDetails>[].obs;
  List<PurchaseDetails> purchases = [];
  List<String> consumables = [];
  var isAvailable = false.obs;
  var purchasePending = false.obs;
  var loading = true.obs;
  var yearlySubscriptionMonthlyPrice = 0.0.obs;
  String? queryProductError;
  Function()? onPressedPremiumSucess;
  static List<String> productIds = [
    'com.financielle.mobile.app.subscription.mothly1',
    'com.financielle.mobile.app.subscription.quarterly2',
    'com.financielle.mobile.app.subscription.yearly1',
  ];
  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    subscription.cancel();
    super.dispose();
  }

  @override
  void onInit() {
    initIAP();
    // clearTransactionsIos();
    super.onInit();
  }

  Future<void> initIAP() async {
    if (Platform.isIOS) {
      var paymentWrapper = SKPaymentQueueWrapper();
      var transactions = await paymentWrapper.transactions();
      for (var transaction in transactions) {
        await paymentWrapper.finishTransaction(transaction);
      }
    }

    /// EasyLoading.show(status: 'Loading...');
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        inAppPurchase.purchaseStream;
    subscription = purchaseUpdated.listen(
        (List<PurchaseDetails> purchaseDetailsList) async {
      await listenToSubscriptionPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      printInfo(info: "HereIAPDone");
      //  EasyLoading.dismiss();
      subscription.cancel();
    }, onError: (Object error) {
      subscription.cancel();
      EasyLoading.dismiss();
      // handle error here.
    });
    await initStoreInfo();
  }

  Future<void> listenToSubscriptionPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      printInfo(info: 'purchaseDetails.status : ${purchaseDetails.status}');
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          EasyLoading.dismiss();
          //  handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          printInfo(info: 'productID : ${purchaseDetails.productID}');
          printInfo(
              info: 'purchaseDetails : ${purchaseDetails.transactionDate}');
          printInfo(
              info:
                  'purchaseDetails : ${purchaseDetails.verificationData.localVerificationData}');
          printInfo(
              info:
                  'purchaseDetails : ${purchaseDetails.verificationData.serverVerificationData}');
          printInfo(
              info:
                  'purchaseDetails : ${purchaseDetails.verificationData.source}');
          // if (purchaseDetails.status == PurchaseStatus.purchased) {
          EasyLoading.dismiss();
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            // DependencyInjection.userCoachmarkUpdate(coachmarkId: '1');
            // //Get.offAllNamed(Routes.subscriptionView + Routes.subscriptionSuccess);
            // Get.to(SubscriptionSuccess(
            //   onPressed: onPressedPremiumSucess,
            // ));
            // Get.toNamed(Routes.subscriptionView + Routes.subscriptionSuccess);
            EasyLoading.showToast('You now a premium member',
                maskType: EasyLoadingMaskType.clear);
            //CommonWidget.successToast("You now a premium member");
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
          // }
        } else if (purchaseDetails.status == PurchaseStatus.canceled) {
          EasyLoading.dismiss();
        }

        if (Platform.isAndroid) {
          for (var i = 0; i < productIds.length; i++) {
            if (purchaseDetails.productID == productIds[i]) {
              final InAppPurchaseAndroidPlatformAddition androidAddition =
                  inAppPurchase.getPlatformAddition<
                      InAppPurchaseAndroidPlatformAddition>();
              await androidAddition.consumePurchase(purchaseDetails);
            }
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  restorePurchase() async {
    await inAppPurchase.restorePurchases();
  }

  GooglePlayPurchaseDetails? getOldSubscription(
      ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
    // This is just to demonstrate a subscription upgrade or downgrade.
    // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
    // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
    // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
    // Please remember to replace the logic of finding the old subscription Id as per your app.
    // The old subscription is only required on Android since Apple handles this internally
    // by using the subscription group feature in iTunesConnect.
    GooglePlayPurchaseDetails? oldSubscription;
    // if (productDetails.id == yearlySubscription &&
    //     purchases[monthlySubscription] != null) {
    //   oldSubscription =
    //       purchases[monthlySubscription] as GooglePlayPurchaseDetails;
    // } else if (productDetails.id == monthlySubscription &&
    //     purchases[yearlySubscription] != null) {
    //   oldSubscription =
    //       purchases[yearlySubscription] as GooglePlayPurchaseDetails;
    // }
    return oldSubscription;
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.transactionDate != null) {
      // int planId = Get.find<SubscriptionController>().selectedPlanId.value;
      // if (planId != 0) {
      //   bool result = await callCheckEmailAssociateApi(planId, purchaseDetails);
      //   // bool result = await callSubscribePlanApi(planId, purchaseDetails);
      //   return Future<bool>.value(result);
      // } else {
      return Future<bool>.value(false);
      // }
    } else {
      return Future<bool>.value(false);
    }
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
  }

  // Future<bool> callSubscribePlanApi(
  //     int planId, PurchaseDetails purchaseDetails) async {
  //   try {
  //     Map<String, dynamic> dataMap = {
  //       'packageName': 'com.financielle.mobile.app',
  //       'productId': purchaseDetails.productID,
  //       'purchaseToken':
  //           purchaseDetails.verificationData.serverVerificationData,
  //       'platform': Platform.isAndroid ? 'Android' : 'iOS',
  //       'isTestEnvironment': true
  //     };

  //     //  return true;

  //     ApiRepository apiRepository = Get.find();
  //     CommonResponse? commonResponse =
  //         await apiRepository.subscribePlan(planId: planId, data: dataMap);

  //     printInfo(info: 'commonResponse : ${commonResponse?.data}');
  //     if (commonResponse != null && commonResponse.data != null) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (ex) {
  //     printInfo(info: 'Exception ==> ${ex.toString()}');
  //     return false;
  //   }
  // }

  // Future<bool> callCheckEmailAssociateApi(
  //     int planId, PurchaseDetails purchaseDetails) async {
  //   try {
  //     Map<String, dynamic> dataMap = {
  //       "transactionId": purchaseDetails.purchaseID,
  //       "purchaseToken":
  //           purchaseDetails.verificationData.serverVerificationData,
  //       "platform": Platform.isAndroid ? "Android" : "iOS",
  //       "isTestEnvironment": true
  //     };

  //     //  return true;

  //     ApiRepository apiRepository = Get.find();
  //     var res = await apiRepository.checkEmailAssociateAPI(data: dataMap);

  //     printInfo(info: 'res : ${res?.email} ${res?.isPurchased}');
  //     if (res != null && res.email != null) {
  //       EasyLoading.showToast(
  //           'You are already purchase this item with ${res.email}} account');
  //       return true;
  //     } else {
  //       bool result = await callSubscribePlanApi(planId, purchaseDetails);
  //       return result;
  //     }
  //   } catch (ex) {
  //     printInfo(info: 'Exception ==> ${ex.toString()}');
  //     return false;
  //   }
  // }

  void getPremium(ProductDetails productDetails) {
    print('selectedPlan::${productDetails.id}');
    late PurchaseParam purchaseParam;

    if (Platform.isAndroid) {
      // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
      // verify the latest status of you your subscription by using server side receipt validation
      // and update the UI accordingly. The subscription purchase status shown
      // inside the app may not be accurate.
      Map<String, PurchaseDetails> purchasesData = Map.fromEntries(
        purchases.map(
          (PurchaseDetails purchase) {
            if (purchase.pendingCompletePurchase) {
              inAppPurchase.completePurchase(purchase);
            }
            return MapEntry<String, PurchaseDetails>(
                purchase.productID, purchase);
          },
        ),
      );
      final oldSubscription = getOldSubscription(productDetails, purchasesData);
      //print('object:::$oldSubscription');
      purchaseParam = GooglePlayPurchaseParam(
        productDetails: productDetails,
        applicationUserName: null,
        changeSubscriptionParam: (oldSubscription != null)
            ? ChangeSubscriptionParam(
                oldPurchaseDetails: oldSubscription,
                prorationMode: ProrationMode.immediateWithoutProration,
              )
            : null,
      );
    } else {
      purchaseParam = PurchaseParam(
        productDetails: productDetails,
      );
    }
    // inAppPurchase.completePurchase(purchaseParam.productDetails);
    // printInfo(info: '======${purchaseParam.productDetails.id}');
    inAppPurchase
        .buyNonConsumable(
      purchaseParam: purchaseParam,
    )
        .catchError((error) async {
      if (Platform.isIOS) {
        var paymentWrapper = SKPaymentQueueWrapper();
        var transactions = await paymentWrapper.transactions();
        for (var transaction in transactions) {
          await paymentWrapper.finishTransaction(transaction);
        }
      }
      //   printInfo(info: error);
      // if (error is PlatformException &&
      //     error.code == "storekit_duplicate_product_object") {
      // EasyLoading.dismiss();
      // EasyLoading.showToast(StringConstant.serverError);
      // Map.fromEntries(
      //   purchases.map(
      //     (PurchaseDetails purchase) {
      //       if (purchase.pendingCompletePurchase) {
      //         inAppPurchase.completePurchase(purchase);
      //       }
      //       return MapEntry<String, PurchaseDetails>(
      //           purchase.productID, purchase);
      //     },
      //   ),
      // );
      //   await inAppPurchase.completePurchase(purchaseDetails);
      EasyLoading.showToast(error.message);
      printInfo(info: 'hereecvc : ${error.message}');
      printInfo(info: 'hereecvc : ${error.code}');
      // var transactions = await SKPaymentQueueWrapper().transactions();
      // // printInfo(info: 'hereecvc : $transactions');
      // for (var skPaymentTransactionWrapper in transactions) {
      //   SKPaymentQueueWrapper().finishTransaction(skPaymentTransactionWrapper);
      // }
      // // }
    });
  }

  Future<void> clearTransactionsIos() async {
    if (Platform.isIOS) {
      final transactions = await SKPaymentQueueWrapper().transactions();
      for (var transaction in transactions) {
        await SKPaymentQueueWrapper().finishTransaction(transaction);
      }
    }
  }

  void handleError(IAPError error) {
    purchasePending.value = false;
  }

  void showPendingUI() {
    EasyLoading.show(status: 'Please wait');
    purchasePending.value = true;
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  Future<void> initStoreInfo() async {
    final bool isProductAvailable = await inAppPurchase.isAvailable();

    if (!isProductAvailable) {
      isAvailable.value = isProductAvailable;

      products.value = [];
      purchases = [];
      notFoundIds = [];

      purchasePending.value = false;
      loading.value = false;
      EasyLoading.dismiss();
      return;
    }

    if (Platform.isIOS) {
      var iosPlatformAddition = inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    ProductDetailsResponse productDetailResponse =
        await inAppPurchase.queryProductDetails(productIds.toSet());
    if (productDetailResponse.error == null && isProductAvailable) {
      isAvailable.value = isProductAvailable;
      products.value = productDetailResponse.productDetails;
      notFoundIds = productDetailResponse.notFoundIDs;
      // yearlySubscripltionMonthlyPrice.value = products
      //         .firstWhere((element) => element.id == yearlySubscription)
      //         .rawPrice /
      //     12;
      consumables = consumables;
      purchasePending.value = false;
      loading.value = false;
      //EasyLoading.dismiss();
      // print('Products:${products.map((element) => element.p).toList()}');
      // print(
      //     'Here:${productDetailResponse.productDetails.map((e) => e.id).toList()}');
    }

    // print('Error:${productDetailResponse.error}');
    if (productDetailResponse.error != null) {
      queryProductError = productDetailResponse.error!.message;
      isAvailable.value = isProductAvailable;
      products.value = productDetailResponse.productDetails;
      purchases = [];
      notFoundIds = productDetailResponse.notFoundIDs;

      purchasePending.value = false;
      loading.value = false;
      EasyLoading.dismiss();
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      queryProductError = null;
      isAvailable.value = isProductAvailable;
      products.value = productDetailResponse.productDetails;
      purchases = [];
      notFoundIds = productDetailResponse.notFoundIDs;

      purchasePending.value = false;
      loading.value = false;
      EasyLoading.dismiss();
      return;
    }
  }
}

/// Example implementation of the
/// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
///
/// The payment queue delegate can be implementated to provide information
/// needed to complete transactions.
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
