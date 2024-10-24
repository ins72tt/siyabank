import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_images.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/core/utils/style.dart';
import 'package:viser_bank/data/controller/transfer/transfer_controller.dart';
import 'package:viser_bank/data/repo/transfer_repo/transfer_repo.dart';
import 'package:viser_bank/data/services/api_service.dart';
import 'package:viser_bank/views/components/buttons/rounded_button.dart';
import 'package:viser_bank/views/components/will_pop_widget.dart';

import 'widget/transfer_card.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TransferRepo(apiClient: Get.find()));
    final controller = Get.put(TransferController(repo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.checkWireTransferStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.bottomNavBar,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.lScreenBgColor1,
          appBar: AppBar(
            title: Text(MyStrings.transfer, style: interRegularLarge.copyWith(color: MyColor.colorWhite)),
            backgroundColor: MyColor.primaryColor,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          body: GetBuilder<TransferController>(
            builder: (controller) => SingleChildScrollView(
              padding: Dimensions.screenPaddingHV,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Show only if own bank transfer is enabled
                      controller.isOwnBankTransferEnable
                          ? Expanded(
                              child: TransferCard(
                                  press: () {
                                    controller.changeIndex(1);
                                  },
                                  icon: MyImages.myBankTransferIcon,
                                  title: MyStrings.transferWithinViserBank,
                                  isSelected: controller.selectedIndex == 1),
                            )
                          : const SizedBox.shrink(),
                      controller.isOwnBankTransferEnable
                          ? const SizedBox(width: Dimensions.space15)
                          : const SizedBox.shrink(),
                      // Show only if others bank transfer is enabled
                      controller.isOthersbankTransferEnable
                          ? Expanded(
                              child: TransferCard(
                                  press: () {
                                    controller.changeIndex(2);
                                  },
                                  icon: MyImages.otherBankTransferIcon,
                                  title: MyStrings.otherBank,
                                  isSelected: controller.selectedIndex == 2),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  const SizedBox(height: Dimensions.space15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Show only if wire transfer is enabled
                      controller.isWireTransferEnable
                          ? Expanded(
                              child: TransferCard(
                                  press: () {
                                    controller.changeIndex(3);
                                  },
                                  icon: MyImages.wireTransferIcon,
                                  title: MyStrings.wireTransfer,
                                  isSelected: controller.selectedIndex == 3),
                            )
                          : const SizedBox.shrink(),
                      controller.isWireTransferEnable
                          ? const SizedBox(width: Dimensions.space15)
                          : const SizedBox.shrink(),
                      Expanded(
                        child: TransferCard(
                            press: () {
                              controller.changeIndex(4);
                            },
                            icon: MyImages.transferHistoryIcon,
                            title: MyStrings.transferHistory,
                            isSelected: controller.selectedIndex == 4),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  RoundedButton(
                    press: () {
                      if (controller.selectedIndex == 1) {
                        Get.toNamed(RouteHelper.myBankTransferScreen);
                      } else if (controller.selectedIndex == 2) {
                        Get.toNamed(RouteHelper.otherBankTransferScreen);
                      } else if (controller.selectedIndex == 3) {
                        Get.toNamed(RouteHelper.wireTransferScreen);
                      } else if (controller.selectedIndex == 4) {
                        Get.toNamed(RouteHelper.transferHistoryScreen);
                      }
                    },
                    text: MyStrings.next,
                  ),
                  const SizedBox(height: Dimensions.space30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
