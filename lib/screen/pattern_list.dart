import 'package:flutter/material.dart';
import 'package:im_knitter/widget/common/custom_appbar.dart';

class PatternListScreen extends StatefulWidget {
  const PatternListScreen({Key? key}) : super(key: key);

  @override
  State<PatternListScreen> createState() => _PatternListScreenState();
}

class _PatternListScreenState extends State<PatternListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(63.0),
        child: CustomAppbarWidget(title: '프로젝트 목록'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(),
        ),
      ),
    );
  }
}
