import 'package:flutter/material.dart';
import 'package:im_knitter/provider/pattern_list_provider.dart';
import 'package:im_knitter/widget/common/custom_appbar.dart';
import 'package:im_knitter/widget/common/search_bar.dart';
import 'package:im_knitter/widget/common/small_img_list_item.dart';
import 'package:provider/provider.dart';

class PatternListScreen extends StatefulWidget {
  const PatternListScreen({Key? key}) : super(key: key);

  @override
  State<PatternListScreen> createState() => _PatternListScreenState();
}

class _PatternListScreenState extends State<PatternListScreen> {
  late PatternListProvider _patternListProvider;

  @override
  void initState() {
    super.initState();

    _patternListProvider = Provider.of<PatternListProvider>(context, listen: false);
    _patternListProvider.getPatterns();
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
        child: CustomAppbarWidget(title: '프로젝트 목록'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SearchBarWidget(),
              Consumer<PatternListProvider>(
                builder: (context, patternProvider, child) => Column(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
