import 'package:flutter/material.dart';
import 'package:im_knitter/style/app_color.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String?) onSubmit;
  final bool searched;
  final Function() cancelSearched;
  final TextEditingController textEditingController;
  const SearchBarWidget({Key? key, required this.onSubmit, required this.searched, required this.cancelSearched, required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      height: 57.0,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.grey),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: AppColors.grey,
          ),
          const SizedBox(width: 18.0),
          Expanded(
            child: SizedBox(
              height: 57.0,
              child: TextFormField(
                controller: textEditingController,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onFieldSubmitted: (text) {
                  onSubmit(text);
                },
              ),
            ),
          ),
          if (searched)
            Row(
              children: [
                const SizedBox(width: 18.0),
                GestureDetector(
                  onTap: () {
                    cancelSearched();
                    textEditingController.clear();
                  },
                  child: Icon(
                    Icons.close,
                    color: AppColors.grey,
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
