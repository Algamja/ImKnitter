import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_knitter/provider/pattern_save_provider.dart';
import 'package:im_knitter/style/app_color.dart';
import 'package:im_knitter/widget/common/custom_appbar_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PatternSaveScreen extends StatefulWidget {
  final String? patternKey;
  const PatternSaveScreen({Key? key, this.patternKey}) : super(key: key);

  @override
  State<PatternSaveScreen> createState() => _PatternSaveScreenState();
}

class _PatternSaveScreenState extends State<PatternSaveScreen> {
  late PatternSaveProvider _patternSaveProvider;

  TextEditingController patternNameController = TextEditingController();
  TextEditingController patternShopLinkController = TextEditingController();
  TextEditingController patternWriterController = TextEditingController();
  TextEditingController patternPriceController = TextEditingController();
  TextEditingController patternOriginGaugeController = TextEditingController();
  TextEditingController patternGaugeController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  bool isNew = true;

  @override
  void initState() {
    super.initState();

    _patternSaveProvider = Provider.of<PatternSaveProvider>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      if (widget.patternKey != null) {
        await _patternSaveProvider.getPattern(widget.patternKey!);

        patternNameController.text = _patternSaveProvider.newPattern.patternName;
        patternShopLinkController.text = _patternSaveProvider.newPattern.patternShopLink;
        patternWriterController.text = _patternSaveProvider.newPattern.patternWriter;
        patternPriceController.text = _patternSaveProvider.newPattern.patternPrice;
        patternOriginGaugeController.text = _patternSaveProvider.newPattern.patternOriginGauge;
        patternGaugeController.text = _patternSaveProvider.newPattern.patternGauge;
        isNew = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PatternSaveProvider>(
      builder: (context, patternProvider, child) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(63.0),
          child: CustomAppbarWidget(title: isNew ? '?????? ??????' : '${patternProvider.pattern.patternName} ??????'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                children: [
                  const SizedBox(height: 23.0),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Navigator.pop(context);
                                  XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);
                                  patternProvider.setPickedFile(imageFile);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Text(
                                    '???????????? ????????????',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 1.0,
                                color: AppColors.grey,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.pop(context);
                                  XFile? imageFile = await _picker.pickImage(source: ImageSource.camera);
                                  patternProvider.setPickedFile(imageFile);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Text(
                                    '?????? ????????????',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                              if (patternProvider.pickedFile != null || patternProvider.pattern.patternImg.isNotEmpty)
                                Column(
                                  children: [
                                    Container(
                                      height: 1.0,
                                      color: AppColors.grey,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        patternProvider.removePickedFile();
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10.0),
                                        child: Text(
                                          '????????? ??????',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          );
                        },
                      );
                    },
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: patternProvider.pickedFile != null
                          ? Image.file(
                              File(patternProvider.pickedFile!.path),
                              fit: BoxFit.cover,
                            )
                          : patternProvider.pattern.patternImg.isNotEmpty
                              ? Image.network(
                                  patternProvider.pattern.patternImg,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                ),
                    ),
                  ),
                  const SizedBox(height: 23.0),
                  TextFormField(
                    controller: patternNameController,
                    decoration: const InputDecoration(
                      hintText: '?????? ??????',
                      hintStyle: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    onChanged: (String? text) {
                      patternProvider.changePatternName(name: text ?? '');
                    },
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: patternShopLinkController,
                    decoration: const InputDecoration(
                      hintText: '?????????',
                      hintStyle: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    onChanged: (String? text) {
                      patternProvider.changeShopLink(link: text ?? '');
                    },
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: patternWriterController,
                    decoration: const InputDecoration(
                      hintText: '?????? ?????? ??????',
                      hintStyle: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    onChanged: (String? text) {
                      patternProvider.changeWriterName(name: text ?? '');
                    },
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: patternPriceController,
                    decoration: const InputDecoration(
                      hintText: '??????',
                      hintStyle: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    onChanged: (String? text) {
                      patternProvider.changePrice(price: text ?? '');
                    },
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          '?????? ???',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () {
                          patternProvider.addTempOriginYarn();
                        },
                        child: const Icon(Icons.add),
                      )
                    ],
                  ),
                  Column(
                    children: List.generate(patternProvider.newPattern.patternOriginYarn.length, (index) {
                      return Row(
                        children: [
                          const SizedBox(width: 40.0),
                          Expanded(
                            child: TextFormField(
                              initialValue: patternProvider.newPattern.patternOriginYarn[index],
                              decoration: InputDecoration(
                                hintText: '?????? ??? ${index + 1}',
                                hintStyle: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              onChanged: (String? text) {
                                patternProvider.changeTempOriginYarn(index: index, yarn: text ?? '');
                              },
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          GestureDetector(
                            onTap: () {
                              patternProvider.removeTempOriginYarn(index: index);
                            },
                            child: const Icon(Icons.close),
                          ),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: patternOriginGaugeController,
                    decoration: const InputDecoration(
                      hintText: '?????? ?????????',
                      hintStyle: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    onChanged: (String? text) {
                      patternProvider.changeOriginGauge(gauge: text ?? '');
                    },
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          '?????? ???',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () {
                          patternProvider.addTempYarn();
                        },
                        child: const Icon(Icons.add),
                      )
                    ],
                  ),
                  Column(
                    children: List.generate(patternProvider.newPattern.patternYarn.length, (index) {
                      return Row(
                        children: [
                          const SizedBox(width: 40.0),
                          Expanded(
                            child: TextFormField(
                              initialValue: patternProvider.newPattern.patternYarn[index],
                              decoration: InputDecoration(
                                hintText: '?????? ??? ${index + 1}',
                                hintStyle: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              onChanged: (String? text) {
                                patternProvider.changeTempYarn(index: index, yarn: text ?? '');
                              },
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          GestureDetector(
                            onTap: () {
                              patternProvider.removeTempYarn(index: index);
                            },
                            child: const Icon(Icons.close),
                          ),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: patternGaugeController,
                    decoration: const InputDecoration(
                      hintText: '?????????',
                      hintStyle: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    onChanged: (String? text) {
                      patternProvider.changeGauge(gauge: text ?? '');
                    },
                  ),
                  const SizedBox(height: 50.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () async {
                        await patternProvider.setPattern();
                        Fluttertoast.showToast(msg: '${isNew ? '??????' : '??????'}???????????????.');
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 100.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                          color: AppColors.pointColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          isNew ? '??????' : '??????',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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
