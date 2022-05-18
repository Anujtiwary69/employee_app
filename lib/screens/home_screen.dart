import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';
import 'package:jobtrackeremployee/constants/app_constants.dart';
import 'package:jobtrackeremployee/constants/app_dimens.dart';
import 'package:jobtrackeremployee/constants/app_strings.dart';
import 'package:jobtrackeremployee/models/job_detail_model.dart';
import 'package:jobtrackeremployee/models/login_model.dart';
import 'package:jobtrackeremployee/providers/job_provider.dart';
import 'package:jobtrackeremployee/screens/job_detail_screen.dart';
import 'package:jobtrackeremployee/screens/login.dart';
import 'package:jobtrackeremployee/utilities/shared_pref.dart';
import 'package:jobtrackeremployee/widgets/app_bar_widget.dart';
import 'package:jobtrackeremployee/widgets/job_ass_edit_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppDimens? appDimens;
  setData() async {
    SharedPref prefs = SharedPref();
    String jobDetail = await prefs.getString(AppStrings.employeeDetailModel);
    Map<String, dynamic> list = jsonDecode(jobDetail) as Map<String, dynamic>;
    print(list.length);
    List<EmployeeJobs> jobDetailList;
    jobDetailList = <EmployeeJobs>[];
    print(jobDetailList.length);
    // list.forEach((element) {
    //   print(element["id"]);

    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setData();
  }

  getjobData(JobProvider provider) async {
    setState(() {
      isLoading = true;
    });
    await provider.getJobList(context);
    setState(() {
      isLoading = false;
    });
  }

  bool isFirst = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    appDimens = AppDimens(MediaQuery.of(context).size.width);
    var providerData = Provider.of<JobProvider>(context);
    if (isFirst == false) {
      getjobData(providerData);

      isFirst = true;
    }
    return Stack(
      children: [
        Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Container(
            width: 70,
            height: 70,
            margin: EdgeInsets.only(bottom: 30, right: 20),
            child: FloatingActionButton(
              child: Icon(
                Icons.add,
                size: 35,
              ),
              onPressed: () => _dialouge(isEdit: false),
              backgroundColor: AppColors.appColor,
            ),
          ),
          backgroundColor: AppColors.backgroundColor,
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 56),
            child: AppBarWidget(
              title: Text(
                "DashBoard",
                style: TextStyle(
                    color: Colors.black87, fontSize: appDimens!.textw20),
              ),
              leading: Container(
                padding: EdgeInsets.fromLTRB(
                    appDimens!.paddingw10, 0, 0, appDimens!.paddingw10),
                child: Image.asset(
                  "assets/logo/logo2.png",
                  height: appDimens!.smallImageAssetsSize,
                  width: appDimens!.smallImageAssetsSize,
                ),
              ),
              actions: [
                InkWell(
                  onTap: () {
                    pushNewScreen(context,
                        screen: LoginScreen(), withNavBar: false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
          body: providerData.employeeJobs == null ? Container() : _mainBody(),
        ),
        AppConstants.progress(isLoading, context)
      ],
    );
  }

  _mainBody() {
    return Consumer<JobProvider>(
      builder: (_, data, __) {
        return Container(
          child: ListView.builder(
            padding: EdgeInsets.all(appDimens!.paddingw10),
            itemCount: data.employeeJobs!.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: _jobCard(data.employeeJobs![index], index),
              );
            },
          ),
        );
      },
    );
  }

  _jobCard(EmployeeJobs model, index) {
    return Card(
      child: _titleRow(model, index),
    );
  }

  _titleRow(EmployeeJobs model, index) {
    return InkWell(
      onTap: () {
        pushNewScreen(context,
            screen: JobDetailScreen(id: "${model.id}", apply: false,), withNavBar: true);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: appDimens!.paddingw10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${model.title}",
                        style: TextStyle(
                            fontSize: appDimens!.textw24,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.appColor),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              "${model.jobStatusTitle}".toUpperCase(),
                              style: TextStyle(
                                  fontSize: appDimens!.textw10,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            AppConstants().displayDate(
                                "${model.startDate!} ${model.startTime}"),
                            style: TextStyle(
                                fontSize: appDimens!.textw14,
                                color: Colors.grey),
                          )
                        ],
                      ),

                      // RichText(text: TextSpan(
                      //   children: [TextSpan(

                      //   )]
                      // ))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            _gridView(model),
            SizedBox(height: 20),
            _bottomRow()
          ],
        ),
      ),
    );
  }

  _gridView(EmployeeJobs model) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 6.5),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: model.employee!.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 0,
                  child: Icon(
                    Icons.person,
                    size: appDimens!.textw20,
                    color: Colors.grey,
                  )),
              Flexible(
                child: Container(
                  child: Text(
                    " ${model.employee![index].firstName} ${model.employee![index].lastName}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: appDimens!.textw16, color: Colors.grey),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _bottomRow() {
    return Container(
      decoration:
          BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
      child: Row(
        children: [
          // Container(
          //   // width: 1,
          //   height: appDimens!.verticalHeight,
          //   color: Colors.grey,
          // ),
          Expanded(child: iconText("Update", Icons.edit))
        ],
      ),
    );
  }

  iconText(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColors.appColor,
            size: appDimens!.textw24,
          ),
          SizedBox(width: 10),
          Text(
            "$text",
            style: TextStyle(fontSize: appDimens!.textw20),
          )
        ],
      ),
    );
  }

  _dialouge({bool? isEdit}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        builder: (context) {
          return JobAddEditWidget(
            isEdit: isEdit,
          );
        });
  }
}
