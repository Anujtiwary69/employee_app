import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';
import 'package:jobtrackeremployee/constants/app_constants.dart';
import 'package:jobtrackeremployee/widgets/app_text_field_widget.dart';
import 'package:jobtrackeremployee/widgets/app_text_form_field_with_header.dart';

import 'package:provider/provider.dart';

class CustomDialouge extends StatefulWidget {
  CustomDialouge(
      {Key? key,
      this.isEdit = false,
      this.jobStatusData,
      this.onSave,
      @required this.isJobType,
      @required this.labelTitle,
      @required this.statusTitle})
      : super(key: key);

  bool? isEdit;
  bool? isJobType;
  String? labelTitle, statusTitle;
  var jobStatusData;
  void Function()? onSave;

  @override
  _CustomDialougeState createState() => _CustomDialougeState();
}

class _CustomDialougeState extends State<CustomDialouge> {
  TextEditingController titleController = new TextEditingController();

  TextEditingController statusController = new TextEditingController();

  setData() {
    if (widget.isEdit!) {
      titleController.text = widget.jobStatusData!.title!;
      _selectedTest = widget.jobStatusData!.status!;

      setState(() {});
    }
  }

  GlobalKey dropDownKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
    _dropdownTestItems = buildDropdownTestItems(list_items);
  }

  List<String> list_items = ["Active", "Inactive"];

  onChangeDropdownTests(selectedTest) {
    if (mounted)
      setState(() {
        _selectedTest = selectedTest;
      });
  }

  _dropDown() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Status:",
            style: TextStyle(
              fontSize: 20,
              color: AppColors.appColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
                border: Border.all(color: Colors.grey)),
            child: Material(
              color: Colors.transparent,
              child: DropdownButton(
                underline: Container(),
                isExpanded: true,
                key: dropDownKey,

                // elevation: 10,
                hint: Container(
                    child: Text(
                  'Select status',
                  style: TextStyle(
                      color: Color(0xff666666),
                      fontStyle: FontStyle.italic,
                      fontSize: 18),
                )),
                icon: Icon(Icons.keyboard_arrow_down_outlined,
                    color: const Color(0xff666666)),
                value: _selectedTest,
                items: _dropdownTestItems!,
                onChanged: onChangeDropdownTests,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _selectedTest;

  List<DropdownMenuItem>? _dropdownTestItems;
  List<DropdownMenuItem> buildDropdownTestItems(List<String> _testList) {
    List<DropdownMenuItem> items = [];
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(
            i,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontFamily: "Nunito",
                fontStyle: FontStyle.normal,
                fontSize: 18.0),
          ),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        color: Colors.transparent,
        // height:MediaQuery.of(context).size.height * 0.2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      // color: Colors.green,r
                      color: Colors.transparent
                    ),
                    // width: MediaQuery.of(context).size.width,
                    // height:MediaQuery.of(context).size.height * 0.2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.topRight,
                          child: Material(
                            child: InkWell(
                                onTap: () => Navigator.pop(context, false),
                                child: Icon(Icons.clear)),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        _textFormField2(
                            headerText: "${widget.labelTitle}",
                            controller: titleController,
                            labelText: "Title"),
                        SizedBox(
                          height: 10,
                        ),
                        _dropDown(),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // _textFormField2(
                        //     controller: statusController,
                        //     headerText: "${widget.statusTitle}",
                        //     labelText: "Status"),
                        SizedBox(
                          height: 25,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: MaterialButton(
                              color: AppColors.appColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () async {
                                if (titleController.text.trim().length ==
                                    0) {
                                  AppConstants()
                                      .showToast(msg: "Please enter title");
                                } else if (_selectedTest == null) {
                                  AppConstants().showToast(
                                      msg: "Please select the status");
                                } else {
                                  if (widget.isJobType!) {
                                    // await providerData.addEditJobType(
                                    //     context: context,
                                    //     title: titleController.text,
                                    //     status: "$_selectedTest",
                                    //     statusId: widget.isEdit!
                                    //         ? "${widget.jobStatusData!.id!}"
                                    //         : "",
                                    //     isEdit: widget.isEdit);
                                    Navigator.pop(context, true);
                                  } else {
                                    Navigator.pop(context, true);

                                    // await providerData.addEditJobStatus(
                                    //     context: context,
                                    //     title: titleController.text,
                                    //     status: "$_selectedTest",
                                    //     statusId:
                                    //         "${widget.jobStatusData!.id!}",
                                    //     isEdit: widget.isEdit);
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 18.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                ),
                AppConstants.progress(
                  false,
                  context,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _textFormField(
      {String? labelText,
      TextEditingController? controller,
      String? title,
      TextInputType? keyBoardType = TextInputType.text}) {
    return Material(
      color: Colors.transparent,
      child: AppTextFormFieldWidget(
        // controller: controller,
        borderColor: Colors.green,
        isOutlineBorder: true,
        text: "$labelText",
        headerText: "Name",
        keyBoardType: keyBoardType,
      ),
    );
  }

  _textFormField2(
      {String? labelText,
      String? headerText,
      TextEditingController? controller,
      TextInputType? keyBoardType = TextInputType.text}) {
    return Material(
      color: Colors.transparent,
      child: TextFormFieldWidgetWithHeader(
        controller: controller,
        text: "$labelText",
        headerText: "$headerText",
        keyBoardType: keyBoardType,
      ),
    );
  }
}
