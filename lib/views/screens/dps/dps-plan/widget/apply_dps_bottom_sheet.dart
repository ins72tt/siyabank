import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/data/controller/dps/dps_plan_controller.dart';
import 'package:viser_bank/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:viser_bank/views/components/buttons/rounded_button.dart';
import 'package:viser_bank/views/components/buttons/rounded_loading_button.dart';
import 'package:viser_bank/views/components/row_item/bottom_sheet_top_row.dart';
import 'package:viser_bank/views/components/text-field/custom_drop_down_button_with_text_field.dart';
import 'package:viser_bank/views/components/text/label_text.dart';
import 'apply_plan_msg_widget.dart';

class ApplyDPSBottomSheet{

 void bottomSheet(BuildContext context, int index){

    CustomBottomSheet(child:GetBuilder<DPSPlanController>(
      builder: (controller) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BottomSheetTopRow(header: MyStrings.applyToOpenDPS),
            controller.authorizationList.length>1?Visibility(
                visible: controller.authorizationList.length>1,
                child: Column(
                  children: [
                    LabelText(text: MyStrings.authorizationMethod.tr,required: true,),
                    const SizedBox(height: 8),
                    CustomDropDownTextField(selectedValue:controller.selectedAuthorizationMode,list: controller.authorizationList,onChanged:(dynamic value) {
                      controller.changeAuthorizationMode(value);
                    },)
                  ],
                )):const ApplyPlanMsgWidget(),
            const SizedBox(height: 20,),
            controller.submitLoading? const RoundedLoadingBtn():
            RoundedButton(
              press: (){
                String planId = controller.planList[index].id.toString();
                controller.submitDpsPlan(planId);
              },
              text: MyStrings.applyNow.tr,
            )
          ],
        ),
      ),
    )).customBottomSheet(context);

  }
}