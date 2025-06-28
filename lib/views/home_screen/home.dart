import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/const/images.dart';
import 'package:seller_app/controllers/home_controller.dart';
import 'package:seller_app/views/home_screen/home_screen.dart';
import 'package:seller_app/views/orders_screen/orders_screen.dart';
import 'package:seller_app/views/products_screen/products_screen.dart';
import 'package:seller_app/views/profile_screen/profile_screen.dart';
import 'package:seller_app/views/widgets/text_style.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(HomeController());

    var navScreens = [
      const HomeScreen(), const ProductsScreen(), const OrdersScreen(), const ProfileScreen()

    ];

    var bottomNavbar= [
      const BottomNavigationBarItem(
          icon: Icon(Icons.home), label: dashboard),
       BottomNavigationBarItem(
        icon: Image.asset(icProducts , color: darkGrey, width: 24,), label: products),
       BottomNavigationBarItem(
        icon: Image.asset(icOrders, color: darkGrey, width: 24), label: orders),
       BottomNavigationBarItem(
        icon: Image.asset(icGeneralSettings, width: 24, color: darkGrey, ), label: settings),
    ];
    return Scaffold(
      bottomNavigationBar: Obx(()=>
        BottomNavigationBar(
          onTap: (index){
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkGrey,
          items: bottomNavbar,),
      ),
      body: Obx(()=>
         Column(
          children: [
             Expanded(child: navScreens.elementAt(controller.navIndex.value))
          ],
        ),
      )
    );
  }
}
