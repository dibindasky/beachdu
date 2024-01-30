import 'package:beachdu/application/presentation/screens/home/recomended/recomented_home.dart';
import 'package:beachdu/application/presentation/screens/home/widgets/caurosal_offers_home.dart';
import 'package:beachdu/application/presentation/screens/home/widgets/custom_search_field.dart';
import 'package:beachdu/application/presentation/screens/home/widgets/join_our_team.dart';
import 'package:beachdu/application/presentation/screens/home/widgets/hot_deals.dart';
import 'package:beachdu/application/presentation/screens/home/widgets/location_picker.dart';
import 'package:beachdu/application/presentation/screens/home/widgets/stack_background_home.dart';
import 'package:beachdu/application/presentation/screens/home/widgets/what_to_sell.dart';
import 'package:beachdu/application/presentation/utils/clippers/custom_shape_home.dart';
import 'package:beachdu/application/presentation/utils/clippers/wave_bottom.dart';
import 'package:beachdu/application/presentation/utils/clippers/wave_top.dart';
import 'package:beachdu/application/presentation/utils/colors.dart';
import 'package:beachdu/application/presentation/utils/constants.dart';
import 'package:beachdu/application/presentation/utils/exit_app_daillogue/exit_app_dailogue.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode focusScopeNode = FocusScope.of(context);
        if (!focusScopeNode.hasPrimaryFocus) {
          focusScopeNode.unfocus();
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          bool shouldPop = await showExitConfirmationDialog(context);
          return shouldPop;
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                StackBackgroundHomePage(
                  color: kGreenPrimary,
                  path: TopWaveClipper(),
                ),
                StackBackgroundHomePage(
                  color: kBluePrimary,
                  path: BottomWavwClipper(),
                ),
                StackBackgroundHomePage(
                  color: kGreenPrimary,
                  path: CustomShapeClipper(),
                ),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //LocationChooser(),
                    kHeight30,
                    kHeight30,
                    CustomSearchFieldHome(),
                    kHeight30,
                    CaurosalViewHomePageOffers(),
                    kHeight30,
                    WhatToSellWidget(),
                    kHeight30,
                    RecommendedMobile(),
                    kHeight30,
                    JoinOurTeam(),
                    kHeight20,
                    HotDealsSession(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
