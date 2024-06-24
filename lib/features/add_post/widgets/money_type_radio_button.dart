import 'package:coonch/features/add_post/controllers/add_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoneyTypeRadioButton extends StatelessWidget {
  const MoneyTypeRadioButton({
    super.key,
    required this.value,
    required this.title,
  });

  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPostController>(builder: (radioController) {
      return InkWell(
        onTap: () {
          radioController.setOrderType(value);
          debugPrint(value);
        },
        child: Row(
          children: [
            Radio(
              value: value,
              groupValue: radioController.orderType,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (String? value){
                radioController.setOrderType(value!);
                debugPrint(value);
              },
              activeColor: Theme.of(context).primaryColor,
            ),

            const SizedBox(width: 10),

            Text(title,),
          ],
        ),
      );
    },);
  }
}
