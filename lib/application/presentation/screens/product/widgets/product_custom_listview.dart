import 'package:beachdu/application/presentation/utils/colors.dart';
import 'package:beachdu/application/presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 840,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 260,
        ),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: kBlack),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: 100,
                    child: Image.network(
                      'https://www.designinfo.in/wp-content/uploads/2023/01/Apple-iPhone-14-Pro-Mobile-Phone-493177786-i-4-1200Wx1200H-485x485-optimized.jpeg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.error,
                        );
                      },
                    ),
                  ),
                ),
                kHeight10,
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: ksmalLight,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'New',
                    style: textHeadBold1.copyWith(
                      color: kYellowLight,
                      fontSize: sWidth * .034,
                    ),
                  ),
                ),
                kHeight10,
                Text('I phone 12', style: textHeadBold1),
                Text(
                  'Upto ₹20,000/-',
                  style: textHeadMedium1.copyWith(fontSize: sWidth * .034),
                ),
                kHeight5,
                Text(
                  '12 mobiles sold in last 22 Hrs',
                  style: textHeadMedium1.copyWith(fontSize: sWidth * .029),
                )
              ],
            ),
          );
        },
        itemCount: 11,
      ),
    );
  }
}