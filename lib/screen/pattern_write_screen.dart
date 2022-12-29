import 'package:flutter/material.dart';
import 'package:im_knitter/widget/common/custom_appbar_widget.dart';

class PatternWriteScreen extends StatefulWidget {
  final bool isNew;
  const PatternWriteScreen({Key? key, required this.isNew}) : super(key: key);

  @override
  State<PatternWriteScreen> createState() => _PatternWriteScreenState();
}

class _PatternWriteScreenState extends State<PatternWriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(63.0),
        child: CustomAppbarWidget(title: widget.isNew ? '패턴 등록' : '패턴 수정'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 23.0),
              GestureDetector(
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
