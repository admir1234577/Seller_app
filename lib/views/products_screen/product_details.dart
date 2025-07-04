import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_app/const/colors.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/views/widgets/text_style.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        },icon: Icon(Icons.arrow_back), color: darkGrey,),
        title: boldText(text: "${data['p_name']}", color: fontGrey, size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
                autoPlay: true,
                height: 350,
                aspectRatio: 16/9,
                viewportFraction: 1.0,
                itemCount: data['p_imgs'].length,
                itemBuilder: (context, index) {

                  return Image.network(
                      data['p_imgs'][0],
                      //data['p_imgs'][index],
                      width: double.infinity, fit:BoxFit.cover);
                }),
            10.heightBox,
            //title and details
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(text: "${data['p_name']}", color: fontGrey, size: 16.0),

                  10.heightBox,
                  Row(
                    children: [
                      boldText(text: "${data['p_category']}", color: fontGrey, size: 16.0),
                      10.widthBox,
                      normalText(text: "${data['p_subcategory']}", color: fontGrey, size: 16.0)
                    ],
                  ),
                  10.heightBox,
                  //rating
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value){},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    size: 25,
                    maxRating: 5,
                  ),
                  10.heightBox,
                  boldText(text: "${data['p_price']}", color: red, size: 18.0),
                  20.heightBox,

                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: boldText(text: "Boja", color: fontGrey),
                                //child: "Boja".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(3,
                                        (index) =>
                                        VxBox().size(40, 40).
                                        roundedFull.
                                        color(Color(data['p_colors'][index])).
                                        margin(const EdgeInsets.symmetric(horizontal: 4))
                                            .make()
                                            .onTap(() {


                                        }),

                                      ),
                              )
                            ],
                          ),
                          10.heightBox,
                          //quantity
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: boldText(text: "Kvantitet", color: fontGrey),
                              ),
                              normalText(text: "${data['p_quantity']} proizvoda", color: fontGrey)



                            ],
                          ),
                          //total

                        ],
                      ).box.white.shadowSm.padding(const EdgeInsets.all(8)).make(),
                  const Divider(),
                  20.heightBox,
                 boldText(text: "Opis", color: fontGrey),

                  10.heightBox,
                  normalText(text: "${data['p_desc']}", color: fontGrey)

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
