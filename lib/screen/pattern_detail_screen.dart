import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_knitter/provider/pattern_detail_provider.dart';
import 'package:im_knitter/provider/pattern_save_provider.dart';
import 'package:im_knitter/screen/pattern_save_screen.dart';
import 'package:im_knitter/style/app_color.dart';
import 'package:im_knitter/widget/common/custom_appbar_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PatternDetailScreen extends StatefulWidget {
  final String patternKey;

  const PatternDetailScreen({Key? key, required this.patternKey}) : super(key: key);

  @override
  State<PatternDetailScreen> createState() => _PatternDetailScreenState();
}

class _PatternDetailScreenState extends State<PatternDetailScreen> {
  late PatternDetailProvider _patternDetailProvider;

  @override
  void initState() {
    super.initState();

    _patternDetailProvider = Provider.of<PatternDetailProvider>(context, listen: false);
    _patternDetailProvider.getPattern(widget.patternKey);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PatternDetailProvider>(
      builder: (context, patternProvider, child) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(63.0),
          child: CustomAppbarWidget(
            title: patternProvider.pattern.patternName,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                children: [
                  const SizedBox(height: 23.0),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      patternProvider.pattern.patternImg.isEmpty
                          ? 'https://firebasestorage.googleapis.com/v0/b/imknitter.appspot.com/o/KakaoTalk_Photo_2022-12-29-13-33-59.jpeg?alt=media&token=32c79d63-6437-4697-aa21-8a304cb581d7'
                          : patternProvider.pattern.patternImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 100.0,
                        child: Text(
                          '구매처',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              Uri uri = Uri.parse(patternProvider.pattern.patternShopLink);
                              await launchUrl(uri);
                            } catch (e) {
                              Fluttertoast.showToast(msg: '유효하지 않은 Url입니다');
                            }
                          },
                          child: Text(
                            patternProvider.pattern.patternShopLink,
                            style: TextStyle(
                              color: AppColors.pointColor,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  Row(
                    children: [
                      const SizedBox(
                        width: 100.0,
                        child: Text(
                          '작가',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Text(
                          patternProvider.pattern.patternWriter,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  Row(
                    children: [
                      const SizedBox(
                        width: 100.0,
                        child: Text(
                          '가격',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Text(
                          patternProvider.pattern.patternPrice,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 100.0,
                        child: Text(
                          '원작실',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: patternProvider.pattern.patternOriginYarn.map((name) {
                            return Text(
                              name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  Row(
                    children: [
                      const SizedBox(
                        width: 100.0,
                        child: Text(
                          '원작 게이지',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Text(
                          patternProvider.pattern.patternOriginGauge,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 100.0,
                        child: Text(
                          '사용 실',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: patternProvider.pattern.patternYarn.map((name) {
                            return Text(
                              name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  Row(
                    children: [
                      const SizedBox(
                        width: 100.0,
                        child: Text(
                          '게이지',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Text(
                          patternProvider.pattern.patternGauge,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Navigator.of(context).pop();
                          await patternProvider.removePattern(widget.patternKey);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 100.0,
                          height: 35.0,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: const Text(
                            '삭제',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SafeArea(
                                child: ChangeNotifierProvider(
                                  create: (_) => PatternSaveProvider(),
                                  child: PatternSaveScreen(patternKey: widget.patternKey),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 100.0,
                          height: 35.0,
                          decoration: BoxDecoration(
                            color: AppColors.pointColor,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: const Text(
                            '수정',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
