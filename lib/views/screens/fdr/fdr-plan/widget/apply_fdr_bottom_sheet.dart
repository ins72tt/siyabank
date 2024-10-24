import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/helper/string_format_helper.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/data/controller/fdr/fdr_plan_controller.dart';
import 'package:viser_bank/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:viser_bank/views/components/buttons/rounded_button.dart';
import 'package:viser_bank/views/components/buttons/rounded_loading_button.dart';
import 'package:viser_bank/views/components/row_item/bottom_sheet_top_row.dart';
import 'package:viser_bank/views/components/row_item/warning_row.dart';
import 'package:viser_bank/views/components/text-field/custom_amount_text_field.dart';
import 'package:viser_bank/views/components/text-field/custom_drop_down_button_with_text_field.dart';
import 'package:viser_bank/views/components/text/label_text.dart';

class ApplyFDRBottomSheet{

   void bottomSheet(BuildContext context, int index){
     Get.find<FDRPlanController>().clearBottomSheetData();
     CustomBottomSheet(child: GetBuilder<FDRPlanController>(builder: (controller)=>SafeArea(
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           const BottomSheetTopRow(header: MyStrings.applyToOpenFDR),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               CustomAmountTextField(
                   controller: controller.amountController,
                   currency: controller.currency,
                   labelText: MyStrings.amount,
                   hintText: MyStrings.enterAmount,
                   onChanged: (value){}
               ),
               WarningRow(text: '${MyStrings.limit.tr}: ${controller.currencySymbol}${Converter.formatNumber(controller.planList[index].minimumAmount??'0')} - ${controller.currencySymbol}${Converter.formatNumber(controller.planList[index].maximumAmount??'0')}',),
               Visibility(
                   visible: controller.authorizationList.length>1,
                   child: Column(
                     children: [
                       const SizedBox(height: Dimensions.space15),
                       LabelText(text: MyStrings.authorizationMethod.tr,required: true,),
                       const SizedBox(height: 8),
                       CustomDropDownTextField(selectedValue:controller.selectedAuthorizationMode,list: controller.authorizationList,onChanged:(dynamic value) {
                         controller.changeAuthorizationMode(value);
                       },)
                     ],
                   )),
               const SizedBox(height: Dimensions.space30),
               controller.isSubmitLoading?const RoundedLoadingBtn():RoundedButton(
                 press: (){
                   String planId = controller.planList[index].id.toString();
                   controller.submitFDRPlan(planId,index);
                 },
                 text: MyStrings.applyNow,
               )
             ],
           )
         ],
       ),
     ))).customBottomSheet(context);
  }
}