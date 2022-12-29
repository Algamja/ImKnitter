import 'package:flutter/material.dart';
import 'package:im_knitter/style/app_color.dart';

class CustomAppbarWidget extends StatelessWidget {
  final Widget? leading;
  final String title;
  const CustomAppbarWidget({Key? key, this.leading, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 21.0),
      color: AppColors.mainColor,
      child: Row(
        children: [
          leading ??
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
              ),
          const SizedBox(width: 14.0),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
