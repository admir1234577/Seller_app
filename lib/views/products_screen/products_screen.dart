import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_app/const/colors.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/const/images.dart';
import 'package:seller_app/const/strings.dart';
import 'package:seller_app/controllers/products_controller.dart';
import 'package:seller_app/services/store_services.dart';
import 'package:seller_app/views/products_screen/add_product.dart';
import 'package:seller_app/views/products_screen/product_details.dart';
import 'package:seller_app/views/widgets/appBar_widget.dart';
import 'package:seller_app/views/widgets/text_style.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductsController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
        onPressed: () async{
         await controller.getCategories();
          controller.populateCategoryList();
          Get.to(()=> const AddProduct());

        },
        child: Icon(Icons.add),),
      appBar: appBarWidget(products),
      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(purpleColor),
              ),
            );
          }
          else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(data.length, (index) => Card(
                    child: ListTile(
                      onTap: (){
                        Get.to(()=>  ProductDetails(data: data[index],));
                      },
                      leading: Image.network(data[index]['p_imgs'][0], width: 100, height: 100,
                          fit:BoxFit.cover),
                      title: boldText(text: "${data[index]['p_name']}", color: fontGrey),
                      subtitle: Row(
                        children: [
                          normalText(text: "${data[index]['p_price']}", color:darkGrey),
                          10.widthBox,
                          boldText(text: data[index]['is_featured']==true ? "Istaknut" : "", color: green)
                        ],
                      ),
                      trailing: VxPopupMenu(
                        arrowSize: 0.0,
                        menuBuilder: ()=> Column(
                          children:
                          List.generate(popupMenuIcons.length, (i) =>
                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                      children: [
                                        Icon(popupMenuIcons[i],
                                        color: data[index]['featured_id'] == currentUser!.uid && i==0 ? green : darkGrey,),
                                        5.widthBox,
                                        normalText(
                                            text: data[index]['featured_id'] == currentUser!.uid && i==0 ? "Ukloni istaknuto" : popupMenuTitles[i], color: darkGrey
                                        )
                                      ]
                                  ).onTap(() {
                                    switch (i) {
                                      case 0:
                                    if (data[index]['is_featured'] == true) {
                                      controller.removeFeatured(data[index].id);
                                      VxToast.show(context, msg: "Uklonjeno");
                                    }
                                    else {
                                      controller.addFeatured(data[index].id);
                                      VxToast.show(context, msg: "Dodano");
                                    }

                                    break;
                                      case 1 :
                                        break;
                                      case 2:
                                        controller.removeProduct(data[index].id);
                                        VxToast.show(context, msg: "Proizvod uklonjen");
                                        break;
                                    default:
                                    }

                                  }),
                                ),
                              )
                          )
                          ,
                        ).box.white.rounded.width(200).make(),
                        clickType: VxClickType.singleClick,
                        child: Icon(Icons.more_vert_rounded),),
                    ),
                  )),
                ),
              ),
            );
          }

        },
      )
    );
  }
}