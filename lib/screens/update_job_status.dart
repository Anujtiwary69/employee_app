import 'dart:io';

import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:images_picker/images_picker.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';
import 'package:jobtrackeremployee/constants/app_constants.dart';
import 'package:jobtrackeremployee/constants/app_dimens.dart';
import 'package:jobtrackeremployee/models/common_model.dart';
import 'package:jobtrackeremployee/providers/job_provider.dart';
import 'package:jobtrackeremployee/screens/updated_status_question_screen.dart';
import 'package:jobtrackeremployee/widgets/app_bar_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class UpdateJobStatusScreen extends StatefulWidget {
  String? jobId;
  UpdateJobStatusScreen({@required this.jobId});
  @override
  _UpdateJobStatusScreenState createState() => _UpdateJobStatusScreenState();
}

class _UpdateJobStatusScreenState extends State<UpdateJobStatusScreen> {
  AppDimens? appDimens;
  List _testList = [
    {'no': 1, 'keyword': 'blue'},
    {'no': 2, 'keyword': 'black'},
    {'no': 3, 'keyword': 'red'}
  ];
  List<DropdownMenuItem>? _dropdownTestItems;
  var _selectedTest;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//     Timer(Duration(milliseconds: 200), () {
//     var state = dropdownKey1.currentState;
//     state.callTap();
// });
  }

  bool isFirst = false;
  bool isLoading = false;
  setData(JobProvider provider) async {
    setState(() {
      isLoading = true;
    });

    await provider.getJobStatusList(context);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var providerData = Provider.of<JobProvider>(context);
    appDimens = AppDimens(MediaQuery.of(context).size.width);
    if (isFirst == false) {
      setData(providerData);
      isFirst = true;
    }
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, appDimens!.appBarHeight),
            child: AppBarWidget(
              // automaticImplyLeading: true,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Platform.isIOS
                    ? Icon(
                        Icons.arrow_back_ios,
                      )
                    : Icon(
                        Icons.arrow_back_outlined,
                      ),
              ),
              iconThemeData: IconThemeData(color: Colors.black),
              title: Text(
                "Update Job Status",
                style: TextStyle(
                    color: Colors.black87, fontSize: appDimens!.textw20),
              ),
            ),
          ),
          body: providerData.jobStatus!.length == 0 ? Container() : _mainBody(),
        ),
        AppConstants.progress(isLoading, context)
      ],
    );
  }

  int? selectedIndex;
  _mainBody() {
    return Consumer<JobProvider>(
      builder: (_, data, __) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.jobStatus!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(
                        '${data.jobStatus![index].title}',
                        style: TextStyle(
                            fontSize: appDimens!.textw22,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textColor),
                      ),
                      tileColor:
                          selectedIndex == index ? Colors.grey[100] : null,
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        selectedIndex = index;
                        CommonResponse respone = await data.updateStatus(
                            context,
                            "${data.jobStatus![index].id}",
                            widget.jobId!);
                        if (respone.formOpen!) {
                          pushNewScreen(context,
                              screen: UpdatedStatusQuestion(
                                jobId: widget.jobId,
                              ));
                        }
                        setState(() {
                          isLoading = false;
                        });
                        setState(() {});
                        // pushNewScreen(context,
                        //     screen: UpdatedStatusQuestion());
                      },
                      trailing: Container(
                        child: selectedIndex == index
                            ? Icon(
                                Icons.check,
                                color: AppColors.appColor,
                                size: appDimens!.textw30,
                              )
                            : Icon(
                                Icons.check_box,
                                color: Colors.transparent,
                              ),
                      ),
                    ),
                  );
                },
              ),
              _bottomRow(),
              res == null ? Container() : photoList(data)
            ],
          ),
        );
      },
    );
  }

  _bottomRow() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upload Photo",
            style: TextStyle(
                fontSize: 28,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _textIcon(Icons.camera_alt, "Open Camera", () {
                uploadPhoto(true);
              }),
              _textIcon(Icons.folder, "Choose from gallery", () {
                uploadPhoto(false);
              }),
            ],
          )
        ],
      ),
    );
  }

  _textIcon(IconData icon, String text, void Function()? onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.appColor),
                    shape: BoxShape.circle),
                child: Icon(icon, size: 35, color: AppColors.appColor)),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "$text",
                style: TextStyle(
                    fontSize: appDimens!.textw18, color: AppColors.textColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Media>? res;
  Future uploadPhoto(bool? isCamera) async {
    print("aa");
    res = isCamera == true
        ? await ImagesPicker.openCamera(
            maxTime: 10,
            cropOpt: CropOption(aspectRatio: CropAspectRatio.custom))
        : await ImagesPicker.pick(
            count: 10,
            pickType: PickType.image,
          );
    setState(() {});
    // print(res![0].path);
  }

  photoList(JobProvider provider) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Selected Photos",
            style: TextStyle(
                fontSize: 28,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            height: 150,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: res!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(res![index].path),
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          res!.removeAt(index);
                          setState(() {});
                        },
                        child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.appColor),
                            child: Icon(Icons.clear, color: Colors.white)),
                      )
                    ],
                  );
                }),
          ),
          MaterialButton(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              await provider.uploadPhotos(context, res, widget.jobId);
              setState(() {
                isLoading = false;
              });
            },
            color: AppColors.appColor,
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text(
              "Upload photos",
              style:
                  TextStyle(color: Colors.white, fontSize: appDimens!.textw20),
            ),
          )
        ],
      ),
    );
  }
}
