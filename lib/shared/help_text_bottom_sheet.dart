import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coxswain/shared/constants.dart';

class HelpTextBottomSheet extends StatelessWidget {
  final String helpTextOne;
  final helpTextTwo;

  HelpTextBottomSheet({required this.helpTextOne, this.helpTextTwo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(Icons.help_outline),
      onTap: () => Get.bottomSheet(
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: kColorBlue,
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                blurRadius: 0,
                spreadRadius: 0,
                color: Colors.blue[300]!,
              )
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text(helpTextOne),
                ),
                ListTile(
                  title: Text(helpTextTwo),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
