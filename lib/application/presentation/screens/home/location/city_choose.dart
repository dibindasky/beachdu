import 'package:beachdu/application/business_logic/location/location_bloc.dart';
import 'package:beachdu/application/presentation/routes/routes.dart';
import 'package:beachdu/application/presentation/utils/colors.dart';
import 'package:beachdu/application/presentation/utils/constants.dart';
import 'package:beachdu/application/presentation/utils/custom_button.dart';
import 'package:beachdu/application/presentation/utils/loading_indicators/loading_indicator.dart';
import 'package:beachdu/data/secure_storage/secure_fire_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class ScreenLocations extends StatelessWidget {
  const ScreenLocations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<LocationBloc>()
        .add(const LocationEvent.locationSearch(searchQuery: ''));
    return GestureDetector(
      onTap: () {
        FocusScopeNode focusScopeNode = FocusScope.of(context);
        if (!focusScopeNode.hasPrimaryFocus) {
          focusScopeNode.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(locationbackgropundImage),
                fit: BoxFit.cover,
              ),
            ),
            child: BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Align(
                    alignment: Alignment.center,
                    child: LoadingAnimation(width: 50),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kHeight40,
                      Text(
                        'Select City',
                        style: textHeadBold1.copyWith(fontSize: sWidth * .04),
                      ),
                      kHeight10,
                      CupertinoTextField(
                        cursorWidth: 3,
                        cursorColor: kWhite,
                        onChanged: (value) {
                          context.read<LocationBloc>().add(
                              LocationEvent.locationSearch(searchQuery: value));
                        },
                        style: textHeadMedium1.copyWith(
                          color: kWhite,
                        ),
                        suffix: Container(
                          padding: const EdgeInsets.only(right: 13),
                          height: 20,
                          child: Image.asset(
                            'assets/images/location_list_png.png',
                          ),
                        ),
                        prefix: const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Iconsax.search_favorite,
                            color: kWhite,
                            size: 18,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: kBlueLight,
                          borderRadius: kRadius5,
                        ),
                        placeholder: 'Search...',
                        placeholderStyle: textHeadInter.copyWith(
                          color: klightwhite,
                        ),
                      ),
                      kHeight20,
                      Expanded(
                        child: BlocBuilder<LocationBloc, LocationState>(
                          builder: (context, state) {
                            if (state.hasError) {
                              return const Center(
                                child: Text('Some error'),
                              );
                            } else {
                              if (state.filteredLocations == null ||
                                  state.filteredLocations!.isEmpty) {
                                return Center(
                                  child: Lottie.asset(emptyLottie),
                                );
                              } else {
                                return GridView.builder(
                                  itemCount: state.filteredLocations!.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 1 / .4,
                                  ),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        context.read<LocationBloc>().add(
                                            LocationEvent.pinCodePick(
                                                cityName:
                                                    state.filteredLocations![
                                                        index]));
                                        await SecureSotrage.setLocation(
                                          location:
                                              state.filteredLocations![index],
                                        );
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                Routes.pincode,
                                                arguments: state
                                                    .filteredLocations![index]);
                                      },
                                      child: ClipRRect(
                                        borderRadius: kRadius5,
                                        child: ColoredBox(
                                          color: kWhiteextra,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    Colors.green[50],
                                                radius: 7,
                                                child: const CircleAvatar(
                                                  backgroundColor:
                                                      Colors.lightGreen,
                                                  radius: 3,
                                                ),
                                              ),
                                              kWidth10,
                                              Text(
                                                state.filteredLocations![index],
                                                style: textHeadSemiBold1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                          },
                        ),
                      ),
                      kHeight10,
                      const Spacer(),
                      Center(
                        child: CustomButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          text: 'Go back',
                        ),
                      ),
                      kHeight40,
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}