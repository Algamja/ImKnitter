import 'package:flutter/material.dart';

class SmallImgListItemWidget extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String? body;
  final Function() onTap;
  const SmallImgListItemWidget({Key? key, required this.imgUrl, required this.title, this.body, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
        children: [
          Image.network(
            imgUrl,
            width: 59.0,
            height: 59.0,
            fit: BoxFit.cover,
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
      ),
    );
  }
}
