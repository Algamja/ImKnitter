import 'package:flutter/material.dart';
import 'package:im_knitter/enum/filter_type.dart';
import 'package:im_knitter/screen/yarn_detail_screen.dart';

class YarnListScreen extends StatefulWidget {
  const YarnListScreen({Key? key}) : super(key: key);

  @override
  State<YarnListScreen> createState() => _YarnListScreenState();
}

class _YarnListScreenState extends State<YarnListScreen> {
  String selectedDropDown = FilterType.newest.enumToText;
  List<String> filterType = [(FilterType.newest.enumToText), (FilterType.oldest.enumToText)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("실 목록", style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffF6C6BD),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(Icons.search),
              Divider(),
            ],
          ),
          DropdownButton(
            value: selectedDropDown,
            items: filterType.map((String item) {
              return DropdownMenuItem<String>(
                child: Text(item),
                value: item,
              );
            }).toList(),
            onChanged: (dynamic value) {
              setState(() {
                selectedDropDown = value;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (BuildContext context, int i) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)
                      =>
                          YarnDetailScreen(title: '$i',))
                      );
                    },
                    child: Row(
                      children: [Icon(Icons.square, size: 50), const SizedBox(width: 10), Text('YARN $i')],
                    ),
                  );
                }),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: Color(0xffF4978E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
