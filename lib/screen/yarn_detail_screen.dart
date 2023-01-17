import 'package:flutter/material.dart';
import 'package:im_knitter/screen/yarn_save_screen.dart';

class YarnDetailScreen extends StatefulWidget {
  const YarnDetailScreen({required this.title, Key? key}) : super(key: key);
  final String title;

  @override
  State<YarnDetailScreen> createState() => _YarnDetailScreenState();
}

class _YarnDetailScreenState extends State<YarnDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffF6C6BD),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 184,
                  color: Colors.black12,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 130,
                      child: Text(
                        '구매처',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '구매처 링크',
                      style: TextStyle(fontSize: 20, color: Color(0xffF4978E)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 132,
                      child: Text(
                        '가격',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '8,000원',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 131,
                      child: Text(
                        '추천 바늘',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '5.0mm',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 130,
                      child: Text(
                        '예상 게이지',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '10cm 27코 33단',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 130,
                      child: Text(
                        '실제 게이지',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '10cm 28코 33단',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffF6C6BD),
                      minimumSize: Size(100, 35),
                    ),
                    child: Text(
                      '삭제',
                      style: TextStyle(color: Colors.white),
                    )),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (builder) => YarnSaveScreen(title: widget.title)));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffF4978E),
                      minimumSize: Size(100, 35),
                    ),
                    child: Text(
                      '수정',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
