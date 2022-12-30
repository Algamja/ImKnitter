import 'package:flutter/material.dart';
import 'package:im_knitter/enum/filter_type.dart';
import 'package:im_knitter/provider/pattern_list_provider.dart';
import 'package:im_knitter/provider/pattern_save_provider.dart';
import 'package:im_knitter/screen/pattern_save_screen.dart';
import 'package:im_knitter/style/app_color.dart';
import 'package:im_knitter/widget/common/custom_appbar_widget.dart';
import 'package:im_knitter/widget/common/search_bar_widget.dart';
import 'package:im_knitter/widget/common/small_img_list_item_widget.dart';
import 'package:provider/provider.dart';

class PatternListScreen extends StatefulWidget {
  const PatternListScreen({Key? key}) : super(key: key);

  @override
  State<PatternListScreen> createState() => _PatternListScreenState();
}

class _PatternListScreenState extends State<PatternListScreen> {
  late PatternListProvider _patternListProvider;
  final TextEditingController _textEditingController = TextEditingController();

  List<String> list = <String>[FilterType.newest.enumToText, FilterType.oldest.enumToText];
  String dropdownValue = '';

  @override
  void initState() {
    super.initState();

    _patternListProvider = Provider.of<PatternListProvider>(context, listen: false);
    _patternListProvider.getPatterns();

    dropdownValue = list.first;
  }

  @override
  void dispose() {
    _patternListProvider.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(63.0),
        child: CustomAppbarWidget(title: '패턴 목록'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (_) => PatternSaveProvider(),
                child: const PatternSaveScreen(),
              ),
            ),
          );
        },
        backgroundColor: AppColors.pointColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<PatternListProvider>(
            builder: (context, patternProvider, child) => Column(
              children: [
                // 검색바
                SearchBarWidget(
                  onSubmit: (searchText) {
                    patternProvider.searchPatterns(searchText!);
                  },
                  searched: patternProvider.searched,
                  textEditingController: _textEditingController,
                  cancelSearched: () {
                    patternProvider.setSearchCancel();
                  },
                ),
                const SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 100.0,
                    padding: const EdgeInsets.symmetric(horizontal: 7.5),
                    margin: const EdgeInsets.only(right: 20.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: DropdownButton<String>(
                      value: patternProvider.filterType.enumToText,
                      icon: const Icon(Icons.arrow_drop_down_outlined),
                      isExpanded: true,
                      style: const TextStyle(color: Colors.black),
                      underline: const SizedBox(),
                      onChanged: (String? value) {
                        patternProvider.changeFilter(textToFilterType(value!));
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                // 패턴 리스트
                patternProvider.searched
                    ? Column(
                        children: List.generate(patternProvider.searchedPatterns.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
                            child: SmallImgListItemWidget(
                              imgUrl: patternProvider.searchedPatterns[index].patternImg,
                              title: patternProvider.searchedPatterns[index].patternName,
                              body: patternProvider.searchedPatterns[index].patternWriter,
                            ),
                          );
                        }),
                      )
                    : Column(
                        children: List.generate(patternProvider.patterns.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
                            child: SmallImgListItemWidget(
                              imgUrl: patternProvider.patterns[index].patternImg,
                              title: patternProvider.patterns[index].patternName,
                              body: patternProvider.patterns[index].patternWriter,
                            ),
                          );
                        }),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
