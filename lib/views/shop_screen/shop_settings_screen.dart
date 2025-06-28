import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_app/const/colors.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/const/strings.dart';
import 'package:seller_app/controllers/profile_controller.dart';
import 'package:seller_app/views/widgets/custom_textfield.dart';
import 'package:seller_app/views/widgets/text_style.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      ()=> Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: shopSettings, size: 16.0,),
          actions: [
            controller.isloading.value ? Center(
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(white),
              ),
            ) :
            TextButton(onPressed: () async{
              controller.isloading(true);
             await controller.updateShop(
                  shopname: controller.shopNameController.text,
                  shopaddress: controller.shopAddressController.text,
                  shopmobile: controller.shopMobileController.text,
                  shopwebsite: controller.shopWebsiteController.text,
                  shopdesc: controller.shopDescController.text);
             VxToast.show(context, msg: "Ažurirano");
            }, child: normalText(text: save, ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextField(
                label: shopName, hint: nameHint , controller: controller.shopNameController
              ),
              10.heightBox,
              customTextField(
                  label: address, hint: shopAddressHint, controller: controller.shopAddressController
              ),
              10.heightBox,
              customTextField(
                  label: mobile, hint: shopMobileHint, controller: controller.shopMobileController
              ),
              10.heightBox,
              customTextField(
                  label: website, hint: shopWebsiteHint, controller: controller.shopWebsiteController
              ),
              10.heightBox,
              customTextField(
                isDesc: true,
                  label: description, hint: shopDescHint, controller: controller.shopDescController
              ),

            ],
          ),
        ),

      ),
    );
  }
}
