import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_app/const/colors.dart';
import 'package:seller_app/const/images.dart';
import 'package:seller_app/const/strings.dart';
import 'package:seller_app/controllers/profile_controller.dart';
import 'package:seller_app/views/widgets/custom_textfield.dart';
import 'package:seller_app/views/widgets/text_style.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({Key? key, this.username}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();
  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Obx(
      ()=> Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: editProfile, size: 16.0,),
          actions: [
            controller.isloading.value ? Center(
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(white),
              ),
            ) :
            TextButton(onPressed: ()async{
              controller.isloading(true);

              //if image is not slected

              if (controller.profileImgPath.value.isNotEmpty) {
                await controller.uploadProfileImage();
              }
              else {
                controller.profileImageLink = controller.snapshotData['imageUrl'];
              }

              //if old pass maches database
              if(controller.snapshotData['password'] == controller.oldpassController.text) {
                await controller.changeAuthPassword(
                    email: controller.snapshotData['email'],
                    password: controller.oldpassController.text,
                    newpassword: controller.newpassController.text
                );


                await controller.updateProfile(
                    imgUrl: controller.profileImageLink,
                    name: controller.nameController.text,
                    password: controller.newpassController.text
                );
                VxToast.show(context, msg: "Ažurirano");
              }
              else if (controller.oldpassController.text.isEmptyOrNull && controller.oldpassController.text.isEmptyOrNull) {
                await controller.updateProfile(
                    imgUrl: controller.profileImageLink,
                    name: controller.nameController.text,
                    password: controller.snapshotData['password']
                );

              }
              else {
                VxToast.show(context, msg: "Desila se greška");
                controller.isloading(false);
              }

            }, child: normalText(text: save, ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:  Column(
              children: [
                //if data url and controller path is empty
                controller.snapshotData['imageUrl']== '' && controller.profileImgPath.isEmpty ?
                Image.asset(imgProduct, width: 120, fit: BoxFit.cover).
                box.roundedFull.clip(Clip.antiAlias).make() :
                //if data is not empty
                controller.snapshotData['imageUrl']!= '' && controller.profileImgPath.isEmpty ?
                Image.network(controller.snapshotData['imageUrl'],
                  width: 120,
                  fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make() :
                //else if controller path is not empty
                Image.file(
                  File(controller.profileImgPath.value),
                  width: 120,
                  fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),
                 //Image.asset(imgProduct, width: 150,).box.roundedFull.
                //clip(Clip.antiAlias).make(),
                10.heightBox,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: white
                  ),
                    onPressed: (){
                    controller.changeImage(context);

                    }, child: normalText(text: changeImage, color: darkGrey)),
                10.heightBox,
                const Divider(color: white,),

                customTextField(label: name, hint: "ImePrezime", controller: controller.nameController),
                30.heightBox,
                Align(
                    alignment: Alignment.centerLeft,
                    child: boldText(text: "Promijenite lozinku")),
                10.heightBox,
                customTextField(label: password, hint: passwordHint, controller: controller.oldpassController),
                10.heightBox,
                customTextField(label: confirmPass, hint: passwordHint, controller: controller.newpassController),

              ],
            ),

        ),

      ),
    );
  }
}
