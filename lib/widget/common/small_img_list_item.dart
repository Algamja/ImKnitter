import 'package:flutter/material.dart';

class SmallImgListItemWidget extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String? body;
  const SmallImgListItemWidget({Key? key, required this.imgUrl, required this.title, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          imgUrl,
          width: 59.0,
          height: 59.0,
        ),
        const SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
            if (body != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  body!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ),
          ],
        )
      ],
    );
  }
}
