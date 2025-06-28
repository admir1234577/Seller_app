import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_app/const/colors.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/const/strings.dart';
import 'package:seller_app/controllers/products_controller.dart';
import 'package:seller_app/views/products_screen/components/product_dropdown.dart';
import 'package:seller_app/views/products_screen/components/product_images.dart';
import 'package:seller_app/views/widgets/custom_textfield.dart';
import 'package:seller_app/views/widgets/text_style.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProductsController>();

    return Obx(
      ()=> Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Get.back();
          },icon: Icon(Icons.arrow_back)),
          title: boldText(text: "Dodavanje proizvoda",  size: 16.0),
          actions: [
            controller.isLoading.value ? Center(
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(white),
              ),
            ) : TextButton(onPressed: () async{
              controller.isLoading(true);
              await controller.uploadImages();
              await controller.uploadProduct(context);
              Get.back();
            }, child: boldText(text: save, color: white))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(hint: "pr. BMW", label: "Naziv proizvoda", controller: controller.pnameController),
                10.heightBox,
                customTextField(hint: "pr. dobar auto", label: "Opis", isDesc: true, controller: controller.pdescController),
                10.heightBox,
                customTextField(hint: "pr. \$100", label: "Cijena", controller: controller.ppriceController),
                10.heightBox,
                customTextField(hint: "pr. 20", label: "Kvantitet", controller: controller.pquantityController),
                10.heightBox,
                productDropdown("Kategorije", controller.categoryList, controller.categoryvalue, controller),
                10.heightBox,
                productDropdown("Podkategorije", controller.subcategoryList, controller.subcategoryvalue, controller),
                10.heightBox,
                const Divider(color: white,),
                boldText(text: "Izaberite slike proizvoda", color: lightGrey),
                10.heightBox,
                Obx(
                  ()=> Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(3, (index) => controller.pImagesList[index] !=null ?
                        Image.file(controller.pImagesList[index], width: 100 ,).onTap(() {
                          controller.pickImage(index, context);
                        }) :
                        productImages(label: "${index+1}").onTap(() {
                      controller.pickImage(index, context);
                    })),
                  ),
                ),
                5.heightBox,
                normalText(text: "Prva slika će biti  glavna", color: lightGrey),
                const Divider(color: white,),
                10.heightBox,
                boldText(text: "Izaberite boje proizvoda", color: lightGrey),
                10.heightBox,
                Obx(
                  ()=> Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(9, (index) =>
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        VxBox().color(Vx.randomPrimaryColor).roundedFull.size(65, 65).make().onTap(() {
                          controller.selectedColorIndex.value=index;
                        }),
                        controller.selectedColorIndex.value == index ?
                        const Icon(Icons.done, color: white,) : SizedBox(),
                      ],
                    )),
                  ),
                )


              ],

            ),
          ),
        ),
      ),
    );
  }
}
