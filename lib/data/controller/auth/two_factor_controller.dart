import 'dart:convert';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/data/model/authorization/authorization_response_model.dart';
import 'package:viser_bank/data/model/global/response_model/response_model.dart';
import 'package:viser_bank/data/repo/auth/two_factor_repo.dart';
import 'package:viser_bank/views/components/snackbar/show_custom_snackbar.dart';

import '../../model/auth/two_factor/two_factor_data_model.dart';
import '../../services/push_notification_service.dart';

class TwoFactorController extends GetxController {

  TwoFactorRepo repo;
  TwoFactorController({required this.repo});
  bool isProfileCompleteEnable = false;

  bool submitLoading=false;
  String currentText='';
  verifyYourSms(String currentText) async {

    if (currentText.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.otpFieldEmptyMsg]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await repo.verify(currentText);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {

        CustomSnackBar.success(successList:model.message?.success ?? [MyStrings.requestSuccess]);
        Get.offAndToNamed(isProfileCompleteEnable? RouteHelper.profileCompleteScreen : RouteHelper.homeScreen);

      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.requestFail]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
    submitLoading = false;
    update();

  }



  void verify2FACode(String currentText) async {
    if (currentText.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.otpFieldEmptyMsg]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await repo.verify(currentText);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        PushNotificationService(apiClient: Get.find()).sendUserToken();
        Get.offAndToNamed(RouteHelper.bottomNavBar);
        CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.requestSuccess]);
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.requestFail]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    submitLoading = false;
    update();
  }


  bool isLoading = false;
  TwoFactorCodeModel twoFactorCodeModel = TwoFactorCodeModel();
  void get2FaCode() async {
    isLoading = true;
    update();

    ResponseModel responseModel = await repo.get2FaData();

    if (responseModel.statusCode == 200) {
      TwoFactorCodeModel model = twoFactorCodeModelFromJson(responseModel.responseJson);

      if (model.status.toString() == MyStrings.success.toString().toLowerCase()) {
        twoFactorCodeModel = model;
        isLoading = false;
        update();
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.requestFail]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
    isLoading = false;
    update();
  }

  void enable2fa(String key, String code) async {
    if (code.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.otpFieldEmptyMsg]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await repo.enable2fa(key, code);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status.toString() == MyStrings.success.toString().toLowerCase()) {
        Get.back();
        CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.requestSuccess]);
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.requestFail]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
    submitLoading = false;
    update();
  }

  void disable2fa(String code) async {
    if (code.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.otpFieldEmptyMsg]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await repo.disable2fa(code);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if (model.status.toString() == MyStrings.success.toString().toLowerCase()) {
        Get.back();
        CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.requestSuccess]);
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.requestFail]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
    submitLoading = false;
    update();
  }

}