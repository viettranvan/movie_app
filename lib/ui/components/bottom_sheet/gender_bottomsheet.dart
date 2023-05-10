import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/index.dart';
import 'package:movie_app/ui/components/index.dart';

import 'views/index.dart';

enum GenderOption {
  male(AppStrings.male),
  female(AppStrings.female),
  other(AppStrings.others),
  ;

  final String gender;
  const GenderOption(this.gender);
}

class GenderBottomSheet extends StatefulWidget {
  const GenderBottomSheet({super.key, this.gender});

  final GenderOption? gender;

  static show({
    required BuildContext context,
    GenderOption? gender,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => SizedBox(
        height: 330,
        child: GenderBottomSheet(gender: gender),
      ),
    );
  }

  @override
  State<GenderBottomSheet> createState() => _GenderBottomSheetState();
}

class _GenderBottomSheetState extends State<GenderBottomSheet> {
  GenderOption? _gerderSelected;

  @override
  void initState() {
    setState(() {
      _gerderSelected = widget.gender;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BottomSheetAppBar(title: AppStrings.gender),
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, index) => itemBuilder(context, index),
              separatorBuilder: separatorBuilder,
              itemCount: GenderOption.values.length,
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: AppButton(
              title: AppStrings.confirm,
              onPressed: () {},
              buttonStyle: _gerderSelected == null
                  ? ButtonStyles.disable
                  : ButtonStyles.elevated,
            ),
          ),
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var item = GenderOption.values[index];
    return GestureDetector(
      onTap: () => selectGender(item),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                item.gender,
                style: AppStyles.body02.copyWith(
                  color: _gerderSelected == item
                      ? AppColors.redPrimary
                      : AppColors.textPrimary,
                ),
              ),
            ),
            Visibility(
              visible: _gerderSelected == item,
              child: Image.asset(
                ImagesPath.tickIcon.assetName,
                height: 16,
                color: AppColors.redPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return Container(
      height: 1,
      color: AppColors.divider,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  void selectGender(GenderOption values) {
    setState(() {
      _gerderSelected = values;
    });
  }
}
