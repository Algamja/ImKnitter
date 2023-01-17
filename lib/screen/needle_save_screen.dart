import 'package:flutter/material.dart';
import 'package:im_knitter/screen/yarn_save_screen.dart';

class NeedleSaveScreen extends StatefulWidget {
  const NeedleSaveScreen({required this.title, Key? key}) : super(key: key);
  final String title;

  @override
  State<NeedleSaveScreen> createState() => _NeedleSaveScreenState();
}

class _NeedleSaveScreenState extends State<NeedleSaveScreen> {
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                          '바늘 이름',
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: textField('바늘 이름을 입력해주세요'),
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
                          '구매처',
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(child: textField('구매처 사이트 주소를 입력해주세요'))
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
                      Expanded(child: textField('구매 시기를 입력하세요'))
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
                      Expanded(child: textField('가격을 입력하세요'))
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
                              crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
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
                        Navigator.push(context, MaterialPageRoute(builder: (builder) => YarnSaveScreen(title: widget.title)));
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
      ),
    );
  }

  Widget textField(String hintText){
    return TextField(
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}
