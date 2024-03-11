import 'package:beachdu/application/business_logic/brands_bloc/category_bloc_bloc.dart';
import 'package:beachdu/application/presentation/screens/product_selection/product_choose_drop_downs/drop_down_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenProductSelectionProductFindDropdownGridView
    extends StatelessWidget {
  const ScreenProductSelectionProductFindDropdownGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBlocBloc, CategoryBlocState>(
      builder: (context, state) {
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.models.length,
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1 / .2,
          ),
          itemBuilder: (context, index) {
            List<String> hints = [
              'Model',
              'Storage',
            ];
            return DropDownBuilder(
              index: index,
              searchHint: hints[index],
              optionsList: ['vivo', 'oppo'],
            );
          },
        );
      },
    );
  }

  List<List<String>> getDynamicOptions(List<String> dummy) {
    return dummy.map((option) => [option]).toList();
  }
}
