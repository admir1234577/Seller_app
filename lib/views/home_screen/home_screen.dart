import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/services/store_services.dart';
import 'package:seller_app/views/widgets/appBar_widget.dart';
import 'package:seller_app/views/widgets/dashboard_button.dart';
import 'package:seller_app/views/widgets/text_style.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

import '../products_screen/product_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(dashboard),
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
            data = data.sortedBy((a, b) => b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashboardButton(context, title: products, count: "${data.length}", icon: icProducts),
                      dashboardButton(context, title: orders, count: "15", icon: icOrders),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashboardButton(context, title: rating, count: "60", icon: icStar),
                      dashboardButton(context, title: totalSales, count: "15", icon: icOrders),
                    ],
                  ),
                  10.heightBox,
                  const Divider(),
                  10.heightBox,
                  boldText(text: popular, color: fontGrey, size: 16.0),
                  20.heightBox,
                  ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap:true,
                      children: List.generate(data.length, (index) => data[index]['p_wishlist'].length == 0 ? SizedBox() :  ListTile(
                        onTap: (){
                          Get.to(()=>  ProductDetails(data: data[index],));
                        },
                        leading: Image.network(data[index]['p_imgs'][0], width: 100, height: 100,
                            fit:BoxFit.cover),
                        title: boldText(text: "${data[index]['p_name']}", color: fontGrey),
                        subtitle: normalText(text: "${data[index]['p_price']}", color:darkGrey),
                      ))
                  )


                ],
              ),
            );
          }
        },
      )
    );
  }
}
