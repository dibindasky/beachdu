import 'package:beachdu/application/business_logic/place_order/place_order_bloc.dart';
import 'package:beachdu/application/presentation/screens/order/widgets/cancel_order_dailog.dart';
import 'package:beachdu/application/presentation/screens/order/widgets/row_data.dart';
import 'package:beachdu/application/presentation/screens/product_selection/widgets/custom_button.dart';
import 'package:beachdu/application/presentation/utils/colors.dart';
import 'package:beachdu/application/presentation/utils/constants.dart';
import 'package:beachdu/application/presentation/utils/snackbar/snackbar.dart';
import 'package:beachdu/domain/model/order_model/order_cancelation_request_model/order_cancelation_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class MyOrderContainer extends StatelessWidget {
  const MyOrderContainer({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlaceOrderBloc, PlaceOrderState>(
      listener: (context, state) {
        if (state.orderCancelationResponceModel != null) {
          showSnack(
            context: context,
            message: '${state.message}',
          );
        }
      },
      builder: (context, state) {
        final data = state.getAllOrderResponceModel!.orders![index];
        final type = data.payment!.type!;

        return Container(
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: kRadius10,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight5,
              Row(
                children: [
                  kWidth10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${data.productDetails!.name}',
                        style: textHeadMedium1,
                      ),
                      Text(
                        "₹ ${data.productDetails!.price}",
                        style: textHeadBold1,
                      ),
                    ],
                  ),
                  const Spacer(),
                  data.status == 'new'
                      ? Row(
                          children: [
                            ClipRRect(
                              borderRadius: kRadius5,
                              child: ColoredBox(
                                color: kRedLight.withOpacity(0.2),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  child: Text(
                                    '${data.status}',
                                    style: textHeadRegular1.copyWith(
                                      color: kRedLight.withOpacity(0.9),
                                      fontSize: sWidth * .03,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kWidth10,
                          ],
                        )
                      : ClipRRect(
                          borderRadius: kRadius5,
                          child: ColoredBox(
                            color: kRedLight.withOpacity(0.2),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: Text(
                                '${data.status}',
                                style: textHeadRegular1.copyWith(
                                  color: kRedLight.withOpacity(0.9),
                                  fontSize: sWidth * .03,
                                ),
                              ),
                            ),
                          ),
                        ),
                  kWidth10
                ],
              ),
              kHeight10,
              RowDatas(
                isRow: false,
                heading: 'Pickup Partner',
                imageFirst: 'assets/images/order_hand.png',
                subHead: 'Mukesh Sharma',
                date: '${data.pickUpDetails!.date}',
              ),
              kHeight10,
              RowDatas(
                isRow: false,
                heading: 'Pickup Location',
                imageFirst: pickupLocationhand,
                lastImage: pickupLocationIcon,
                subHead: '${data.user!.address}',
                date: '${data.pickUpDetails!.date}',
              ),
              kHeight10,
              RowDatas(
                isRow: true,
                heading: 'Pickup Date',
                subHead: '${data.pickUpDetails!.time}',
                imageFirst: pickupclock,
                date: '${data.pickUpDetails!.date}',
              ),
              kHeight20,
              RowDatas(
                isRow: true,
                heading: 'Payment Method',
                subHead: type,
                imageFirst: paymentMethodIcon,
                date: '',
              ),
              kHeight10,
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                  fontSize: 11,
                  height: 30,
                  width: 100,
                  text: 'Cancel order',
                  onPressed: () {
                    cancelOrder(
                      context,
                      onPressed: () {
                        if (context
                                .read<PlaceOrderBloc>()
                                .cancelationReasonController
                                .length >
                            10) {
                          //Order cancelation event
                          OrderCancelationRequestModel
                              orderCancelationRequestModel =
                              OrderCancelationRequestModel(
                            cancellationReason: context
                                .read<PlaceOrderBloc>()
                                .cancelationReasonController
                                .text,
                          );
                          context.read<PlaceOrderBloc>().add(
                                PlaceOrderEvent.orderCancel(
                                  orderCancelationRequestModel:
                                      orderCancelationRequestModel,
                                  orderId: data.id!,
                                ),
                              );
                          context
                              .read<PlaceOrderBloc>()
                              .cancelationReasonController
                              .clear();
                          Navigator.of(context).pop();
                        } else {
                          showSnack(
                            context: context,
                            message:
                                'Cancellation reason must have atleast 10 charectors',
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              kHeight10
            ],
          ),
        );
      },
    );
  }
}
