import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_app/const/colors.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/controllers/orders_controller.dart';
import 'package:seller_app/views/orders_screen/components/order_place.dart';
import 'package:seller_app/views/widgets/our_button.dart';
import 'package:seller_app/views/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data });

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.find<OrdersController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.ondelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
  }
  @override
  Widget build(BuildContext context) {



    return Obx(
        ()=> Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Get.back();
          },icon: Icon(Icons.arrow_back), color: darkGrey,),
          title: boldText(text: "Detalji narudžbe", color: fontGrey, size: 16.0),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: ourButton(
              color: green,
              onPress: (){
                controller.confirmed(true);
                controller.changeStatus(title: "order_confirmed", status: true, docID: widget.data.id);
              },
              title: "Potvrdi narudžbu"
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Visibility(
                  visible: controller.confirmed.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText(text: "Status narudžbe:", color: purpleColor, size: 16.0),
                      SwitchListTile(
                        activeColor: green,
                        value: true,
                        onChanged: (value){},
                        title: boldText(text: "Izvršeno", color: fontGrey),),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.confirmed.value,
                          onChanged: (value){
                          controller.confirmed.value=value;
                          },
                        title: boldText(text: "Potvrđeno", color: fontGrey),),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.ondelivery.value,
                        onChanged: (value){
                          controller.ondelivery.value=value;

                          controller.changeStatus(title: "order_on_delivery", status: value, docID: widget.data.id);
                        },
                        title: boldText(text: "Pri dostavi", color: fontGrey),),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.delivered.value,
                        onChanged: (value){
                          controller.delivered.value=value;

                          controller.changeStatus(title: "order_delivered", status: value, docID: widget.data.id);
                        },
                        title: boldText(text: "Poslato", color: fontGrey),),
                    ],

                  ).box.padding(const EdgeInsets.all(8)).outerShadowMd.border(color: lightGrey).roundedSM.white.make(),
                ),

                orderPlaceDetails(d1: "${widget.data['order_code']}", d2: "${widget.data['shipping_method']}",
                    title1: "Kod narudžbe", title2: "Način dostave"),
                orderPlaceDetails(d1: intl.DateFormat().add_yMd().format(widget.data['order_date'].toDate()),
                    d2: "${widget.data['payment_method']}",
                    title1: "Datum narudžbe", title2: "Način plaćanja"),
                orderPlaceDetails(d1: "Neplaćeno", d2: "Narudžba napravljena",
                    title1: "Status plaćanja", title2: "Status dostave"),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //"Adresa dostave".text.fontFamily(semibold).make(),
                              boldText(text: "Adresa dostave", color: purpleColor),
                              "${widget.data['order_by_name']}".text.make(),
                              "${widget.data['order_by_email']}".text.make(),
                              "${widget.data['order_by_address']}".text.make(),
                              "${widget.data['order_by_city']}".text.make(),
                              "${widget.data['order_by_state']}".text.make(),
                              "${widget.data['order_by_phone']}".text.make(),
                              "${widget.data['order_by_postalcode']}".text.make(),
                            ],
                          ),
                          SizedBox(
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                boldText(text: "Ukupno", color: purpleColor),
                                boldText(text: "${widget.data['total_amount']}", color: red, size: 16.0),
                              //  "Ukupno".text.fontFamily(semibold).make(),
                               // "${data['total_amount']}".text.color(redColor).fontFamily(bold).make(),

                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ).box.outerShadowMd.border(color: lightGrey).roundedSM.white.make(),

                Divider(),
                10.heightBox,
              boldText(text: "Naručeni proizvodi", color: fontGrey, size: 16.0),
                10.heightBox,
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children:
                  List.generate(controller.orders.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDetails(
                            title1: "${controller.orders[index]['title']}",
                            title2: "${controller.orders[index]['tprice']}",
                            d1: "${controller.orders[index]['qty']}x",
                            d2: "Moguća refundacija"
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(

                            width: 30,
                            height: 20,
                            color: Color(controller.orders[index]['color']),
                          ),
                        ),
                        Divider(),


                      ],
                    );
                  }).toList(),


                ).box.outerShadowMd.white.margin(EdgeInsets.only(bottom: 4)).make(),
                20.heightBox,




              ],
            ),
          ),
        ),
      ),
    );
  }
}
