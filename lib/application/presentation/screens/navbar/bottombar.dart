import 'package:beachdu/application/presentation/screens/home/home_screen.dart';
import 'package:beachdu/application/presentation/screens/order/my_orders_screen.dart';
import 'package:beachdu/application/presentation/screens/product/product_screen.dart';
import 'package:beachdu/application/presentation/screens/profile/profile_screen.dart';
import 'package:beachdu/application/presentation/utils/colors.dart';
import 'package:flutter/material.dart';

ValueNotifier<int> bottomBarNotifier = ValueNotifier(0);

class ScreenBottomNavigation extends StatelessWidget {
  final List<Widget> body = [
    const ScreenHome(),
    const ScreenProductSelection(),
    const ScreenMyOrders(),
    const ScreenProfile()
  ];
  ScreenBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: bottomBarNotifier,
        builder: (context, currentIndex, _) {
          return Scaffold(
            body: body[currentIndex],
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              child: ColoredBox(
                color: kBlack,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 15),
                  child: BottomNavigationBar(
                      onTap: (value) {
                        bottomBarNotifier.value = value;
                        bottomBarNotifier.notifyListeners();
                      },
                      backgroundColor: kBlack,
                      currentIndex: currentIndex,
                      selectedItemColor: kGreenPrimary,
                      showUnselectedLabels: true,
                      items: const [
                        BottomNavigationBarItem(
                            backgroundColor: kBlack,
                            icon: Icon(Icons.home_filled),
                            label: ''),
                        BottomNavigationBarItem(
                            backgroundColor: kBlack,
                            icon: Icon(Icons.phone_android),
                            label: ''),
                        BottomNavigationBarItem(
                            backgroundColor: kBlack,
                            icon: Icon(Icons.format_list_bulleted_rounded),
                            label: ''),
                        BottomNavigationBarItem(
                            backgroundColor: kBlack,
                            icon: Icon(Icons.person),
                            label: '')
                      ]),
                ),
              ),
            ),
          );
        });
  }
}