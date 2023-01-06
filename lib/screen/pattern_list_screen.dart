import 'package:flutter/material.dart';
import 'package:im_knitter/enum/filter_type.dart';
import 'package:im_knitter/provider/pattern_detail_provider.dart';
import 'package:im_knitter/provider/pattern_list_provider.dart';
import 'package:im_knitter/provider/pattern_save_provider.dart';
import 'package:im_knitter/screen/pattern_detail_screen.dart';
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
    return Consumer<PatternListProvider>(
      builder: (context, patternProvider, child) => Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(63.0),
          child: CustomAppbarWidget(title: '패턴 목록'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SafeArea(
                  child: ChangeNotifierProvider(
                    create: (_) => PatternSaveProvider(),
                    child: const PatternSaveScreen(),
                  ),
                ),
              ),
            );

            patternProvider.getPatterns();
          },
          backgroundColor: AppColors.pointColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
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
                        children: patternProvider.searchedPatterns.keys.map((patternKey) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
                            child: SmallImgListItemWidget(
                              imgUrl: patternProvider.searchedPatterns[patternKey]!.patternImg,
                              title: patternProvider.searchedPatterns[patternKey]!.patternName,
                              body: patternProvider.searchedPatterns[patternKey]!.patternWriter,
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SafeArea(
                                      child: ChangeNotifierProvider(
                                        create: (_) => PatternDetailProvider(),
                                        child: PatternDetailScreen(patternKey: patternKey),
                                      ),
                                    ),
                                  ),
                                );

                                patternProvider.getPatterns();
                              },
                            ),
                          );
                        }).toList(),
                      )
                    : Column(
                        children: patternProvider.patterns.keys.map((patternKey) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
                            child: SmallImgListItemWidget(
                              imgUrl: patternProvider.patterns[patternKey]!.patternImg,
                              title: patternProvider.patterns[patternKey]!.patternName,
                              body: patternProvider.patterns[patternKey]!.patternWriter,
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SafeArea(
                                      child: ChangeNotifierProvider(
                                        create: (_) => PatternDetailProvider(),
                                        child: PatternDetailScreen(patternKey: patternKey),
                                      ),
                                    ),
                                  ),
                                );

                                patternProvider.getPatterns();
                              },
                            ),
                          );
                        }).toList(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
