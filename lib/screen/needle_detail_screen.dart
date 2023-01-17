import 'package:flutter/material.dart';
import 'package:im_knitter/screen/needle_save_screen.dart';
import 'package:im_knitter/screen/yarn_save_screen.dart';

class NeedleDetailScreen extends StatefulWidget {
  const NeedleDetailScreen({required this.title, Key? key}) : super(key: key);
  final String title;

  @override
  State<NeedleDetailScreen> createState() => _NeedleDetailScreenState();
}

class _NeedleDetailScreenState extends State<NeedleDetailScreen> {
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
                        '구매 시기',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '22.11.10(목)',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 130,
                      child: Text(
                        '바늘 사이즈',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 180,
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 0.22, //item 의 가로 1, 세로 2 의 비율
                            mainAxisSpacing: 15, //수평 Padding
                            crossAxisSpacing: 15,
                          ),
                          itemBuilder: (BuildContext context, int i) {
                            return Container(
                              child: Center(child: Text('4.0mm $i')),
                              decoration: BoxDecoration(color: Color(0xffF6C6BD), borderRadius: BorderRadius.circular(10.0)),
                            );
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 130,
                      child: Text(
                        '바늘 종류',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 180,
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 2,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,  //1 개의 행에 보여줄 item 개수
                            childAspectRatio: 1 / 0.22, //item 의 가로 1, 세로 2 의 비율
                            mainAxisSpacing: 15, //수평 Padding
                            crossAxisSpacing: 15,
                          ),
                          itemBuilder: (BuildContext context, int i) {
                            return Container(
                              child: Center(child: Text('대바늘 $i')),
                              decoration: BoxDecoration(color: Color(0xffF6C6BD), borderRadius: BorderRadius.circular(10.0)),
                            );
                          }),
                    ),
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
                    child: const Text(
                      '삭제',
                      style: TextStyle(color: Colors.white),
                    )),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (builder) => NeedleSaveScreen(title: widget.title)));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffF4978E),
                      minimumSize: Size(100, 35),
                    ),
                    child: const Text(
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
