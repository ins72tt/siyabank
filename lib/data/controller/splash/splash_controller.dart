import 'dart:convert';
import 'package:get/get.dart';
import 'package:viser_bank/core/helper/shared_preference_helper.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/core/utils/messages.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/data/controller/localization/localization_controller.dart';
import 'package:viser_bank/data/model/general_setting/general_settings_response_model.dart';
import 'package:viser_bank/data/model/global/response_model/response_model.dart';
import 'package:viser_bank/data/repo/auth/general_setting_repo.dart';
import 'package:viser_bank/views/components/snackbar/show_custom_snackbar.dart';

import '../../services/push_notification_service.dart';

class SplashController extends GetxController  {

  GeneralSettingRepo repo;
  LocalizationController localizationController;

  SplashController({required this.repo,required this.localizationController});


  bool isLoading = true;
  gotoNextPage() async {
    await loadLanguage();
    bool isRemember = repo.apiClient.sharedPreferences.getBool(SharedPreferenceHelper.rememberMeKey) ?? false;
    noInternet = false;
    update();

    // PushNotificationService(apiClient: Get.find()).sendUserToken();

    storeLangDataInLocalStorage();
    loadAndSaveGeneralSettingsData(isRemember);
  }

  bool noInternet = false;
  void loadAndSaveGeneralSettingsData(bool isRemember) async {
    ResponseModel response = await repo.getGeneralSetting();

    if (response.statusCode == 200) {
      GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        repo.apiClient.storeGeneralSetting(model);
      } else {
        List<String> message = [MyStrings.somethingWentWrong];
        CustomSnackBar.error(errorList: model.message?.error ?? message);
      }
    } else {
      if (response.statusCode == 503) {
        noInternet = true;
        update();
      }
      CustomSnackBar.error(errorList: [response.message]);
    }

    isLoading = false;
    update();


    bool appOpeningStatus = repo.apiClient.sharedPreferences.getBool(SharedPreferenceHelper.firstTimeAppOpeningStatus) ?? true;


    if(appOpeningStatus){
      Get.toNamed(RouteHelper.onBoardScreen);
    }else{
      if (isRemember) {
        Future.delayed(const Duration(seconds: 1), () {
          PushNotificationService(apiClient: Get.find()).sendUserToken();
          Get.offAndToNamed(RouteHelper.bottomNavBar);
        });
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAndToNamed(RouteHelper.loginScreen);
        });
      }
    }
  }

  Future<bool> storeLangDataInLocalStorage() {
    if (!repo.apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.countryCode)) {
      return repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.countryCode, MyStrings.myLanguages[0].countryCode);
    }
    if (!repo.apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.languageCode)) {
      return repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageCode, MyStrings.myLanguages[0].languageCode);
    }
    return Future.value(true);
  }

  Future<void> loadLanguage() async {
    localizationController.loadCurrentLanguage(); 
    String languageCode = localizationController.locale.languageCode;

    ResponseModel response = await repo.getLanguage(languageCode);
    if (response.statusCode == 200) {
      try {
        Map<String, Map<String, String>> language = {};
        var resJson = jsonDecode(response.responseJson);

        saveLanguageList(response.responseJson);
        var value = resJson['data']['file'].toString() == '[]' ? {} : resJson['data']['file'];
        Map<String, String> json = {};
        value.forEach((key, value) {
          json[key] = value.toString();
        });
        language['${localizationController.locale.languageCode}_${localizationController.locale.countryCode}'] = json;
        Get.addTranslations(Messages(languages: language).keys);
      } catch (e) {
        CustomSnackBar.error(errorList: [e.toString()]);
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
  }

  void saveLanguageList(String languageJson) async {
    await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageListKey, languageJson);
    return;
  }

}