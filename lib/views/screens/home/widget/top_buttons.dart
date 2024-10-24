import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/data/controller/home/home_controller.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      
      // Ensure safe list access
      int moduleCount = controller.moduleList.length;

      return moduleCount >= 8
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < 4; i++) Expanded(child: controller.moduleList[i]),
                  ],
                ),
                const SizedBox(height: Dimensions.space20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 4; i < 8; i++) Expanded(child: controller.moduleList[i]),
                  ],
                )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                moduleCount > 4
                    ? Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: [
                          // Safely get the first 4 items
                          for (int i = 0; i < 4 && i < moduleCount; i++)
                            SizedBox(
                              width: (MediaQuery.of(context).size.width - 32 - 24) / 4,
                              child: controller.moduleList[i],
                            ),
                          // Safely get the remaining items if they exist
                          for (int i = 4; i < moduleCount; i++)
                            SizedBox(
                              width: (MediaQuery.of(context).size.width - 32 - 24) / 4,
                              child: controller.moduleList[i],
                            ),
                        ],
                      )
                    : moduleCount == 4
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int i = 0; i < 4; i++) Expanded(child: controller.moduleList[i]),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: controller.moduleList[0]),
                              Expanded(child: moduleCount > 1 ? controller.moduleList[1] : const SizedBox()),
                              Expanded(child: moduleCount > 2 ? controller.moduleList[2] : const SizedBox()),
                              const Expanded(child: SizedBox()), // Filling up space for alignment
                            ],
                          ),
              ],
            );
    });
  }
}
