import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/data/controller/loan/loan_controller.dart';
import 'package:viser_bank/data/controller/loan/loan_list_controller.dart';
import 'package:viser_bank/data/controller/loan/loan_plan_controller.dart';
import 'package:viser_bank/data/repo/loan/loan_repo.dart';
import 'package:viser_bank/data/services/api_service.dart';
import 'package:viser_bank/views/components/appbar/custom_appbar.dart';
import 'package:viser_bank/views/components/tab/tab_container.dart';
import 'package:viser_bank/views/components/will_pop_widget.dart';
import 'package:viser_bank/views/screens/loan/loan-plan/loan_plan_screen.dart';
import 'package:viser_bank/views/screens/loan/my-loan-list/loan_list_screen.dart';

import '../../../../core/utils/my_color.dart';

class LoanScreen extends StatefulWidget {
  const LoanScreen({Key? key}) : super(key: key);

  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {

  @override
  void initState() {

    final  arg = Get.arguments??'';
    Get.put(ApiClient(sharedPreferences: Get.find()));
    final controller = Get.put(LoanController());
    if(arg.toString().isNotEmpty){
      controller.isPlan = false;
    }
    Get.put(LoanRepo(apiClient: Get.find()));
    final planController = Get.put(LoanPlanController(loanRepo: Get.find()));
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoanRepo(apiClient: Get.find()));
    final planListController = Get.put(LoanListController(loanRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      planController.loadLoanPlan();
      planListController.initialSelectedValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoanController>(builder: (controller)=>Scaffold(
      backgroundColor: MyColor.getScreenBgColor(),
      appBar: const CustomAppBar(title: MyStrings.loan),
      body: Padding(
        padding: Dimensions.screenPaddingHV,
        child: Column(
          children: [
           TabContainer(
             firstText:  MyStrings.loanPlan,
             firstTabPress:(){
               controller.changeTab(true);
             },
             isFirstSelected: controller.isPlan,
             secondText:  MyStrings.myLoanList,
             secondTabPress: (){
               controller.changeTab(false);
             },
            ),
            const SizedBox(height: Dimensions.space15),
            Expanded(
              child: controller.isPlan? const LoanPlanScreen() : const LoanListScreen(),
            ),
          ],
        ),
      ),
    ));
  }
}
