import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';
import 'package:jobtrackeremployee/constants/app_constants.dart';
import 'package:jobtrackeremployee/constants/app_dimens.dart';
import 'package:jobtrackeremployee/constants/app_strings.dart';
import 'package:jobtrackeremployee/models/gallery_model.dart';
import 'package:jobtrackeremployee/models/job_detail_model.dart';
import 'package:jobtrackeremployee/providers/job_provider.dart';
import 'package:jobtrackeremployee/screens/update_job_status.dart';
import 'package:jobtrackeremployee/widgets/app_bar_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobDetailScreen extends StatefulWidget {
  String? id;
  bool apply;
  JobDetailScreen({@required this.id, required this.apply});
  @override
  _JobDetailScreenState createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  AppDimens? appDimens;
  bool isLoading = false;
  String BuutonText = "Apply";

  getDetail(JobProvider provider) async {
    setState(() {
      isLoading = true;
    });

    await provider.getJobDetail(context, widget.id!);
    await provider.getGallaryData(context, widget.id!);
    setState(() {
      isLoading = false;
    });
  }

  bool isFirst = false;
  JobProvider? providerData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    providerData = Provider.of<JobProvider>(context);
    if (isFirst == false) {
      getDetail(providerData!);
      isFirst = true;
    }
    appDimens = AppDimens(MediaQuery.of(context).size.width);
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(double.infinity, appDimens!.appBarHeight),
              child: AppBarWidget(
                automaticImplyLeading: true,
                iconThemeData: IconThemeData(color: Colors.black),
                title: Text(
                  "Job Details",
                  style: TextStyle(
                      color: Colors.black87, fontSize: appDimens!.textw20),
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      pushNewScreen(context,
                              screen: UpdateJobStatusScreen(
                                jobId: widget.id,
                              ),
                              withNavBar: true)
                          .then((value) {
                        isFirst = false;
                        setState(() {});
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(FontAwesomeIcons.solidEdit),
                    ),
                  )
                ],

                // leading: Container(
                //   padding: EdgeInsets.fromLTRB(
                //       appDimens!.paddingw10, 0, 0, appDimens!.paddingw10),
                //   child: Image.asset(
                //     "assets/logo/logo2.png",
                //     height: appDimens!.smallImageAssetsSize,
                //     width: appDimens!.smallImageAssetsSize,
                //   ),
                // ),
              )),
          body: providerData == null ? Container() : _mainBody(),
        ),
        AppConstants.progress(isLoading, context)
      ],
    );
  }

  List<TableRow> _myRows(JobProvider data) {
    List<TableRow> rows = [];
    // Table Header to added
    rows.add(TableRow(children: [
      TableCell(
          child: Row(children: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            "Task",
            style: TextStyle(
                fontSize: appDimens!.textw18,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600),
          ),
        ),
      ])),
      TableCell(
          child: Row(children: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(5.0),
          child: new Text(
            "Quantity",
            style: TextStyle(
                fontSize: appDimens!.textw18,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600),
          ),
        ),
      ]))
    ]));
    var quantiy = data.jobDetail?.quantity1?.split(",");
    // var quantiy1 = data.jobDetail?.quantity1?.split(",");
    int i = 0;

    data.jobDetail?.subTask?.split(",").forEach((element) {
      rows.add(TableRow(children: [
        TableCell(
            child: Row(children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(element.toString()),
          ),
        ])),
        TableCell(
            child: Row(children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(5.0),
            child: new Text(quantiy![i]),
          ),
        ]))
      ]));
      i++;
    });

    //here add others Rows with rows.add(TableRow(...)) ...

    return rows;
  }

  _mainBody() {
    return Consumer<JobProvider>(
      builder: (_, data, __) {
        return data.jobDetail == null
            ? Container()
            : SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(appDimens!.paddingw20),
                    child: Column(
                      children: [
                        _textCommonWidget("Job Code ", "001"),
                        _textCommonWidget(
                            "Job Title ", "${data.jobDetail!.title}"),
                        _textCommonWidget("Address ",
                            "45 Monteagle Road, Tawonga South, Queesland"),
                        _textCommonWidget(
                            "Start Date ",
                            AppConstants().displayDate(
                                "${data.jobDetail!.startDate} ${data.jobDetail!.startTime}")),
                        _textCommonWidget(
                            "Start Time ",
                            AppConstants().timeDisplay(
                                "${data.jobDetail!.startDate} ${data.jobDetail!.startTime}")),
                        _textCommonWidget(
                            "Details", "${data.jobDetail!.description}"),
                        _textCommonWidget(
                            "Status", "${data.jobDetail!.status}"),
                        // _textCommonWidget(
                        //     "Current_status", "${data.jobDetail!.current_status}"),

                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Table(
                            children: _myRows(data),
                          ),
                        ),
                        (widget.apply == true)
                            ? Container()
                            : _gridView(data.jobDetail!),
                        _photogridView(data),
                        SizedBox(
                          height: 20,
                        ),
                        (widget.apply == true)
                            ? TextButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(0)),
                                  // elevation: MaterialStateProperty.all(8),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  backgroundColor: MaterialStateProperty.all(
                                      (BuutonText == "Apply")
                                          ? AppColors.appColor
                                          : Colors.green),
                                  shadowColor: MaterialStateProperty.all(
                                      Theme.of(context).colorScheme.onSurface),
                                ),
                                onPressed: () async {
                                  if(data.jobDetail?.current_status==null){
                                    SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                    ;
                                    providerData?.assignToEmployee(
                                        jobId: data.jobDetail?.id.toString(),
                                        employeeId:
                                        prefs.getString(AppStrings.empCode),
                                        context: context);
                                    AppConstants().showToast(
                                        msg:
                                        "successfully Applied, Your application will be review by Admin");
                                    setState(() {
                                      BuutonText = "You Application is under review";
                                    });
                                  }

                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    (data.jobDetail?.current_status != null)
                                        ? (data.jobDetail?.current_status == 0)
                                            ? "You Application is under review"
                                            : "Approved"
                                        : BuutonText,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))
                            : Container(),

                        // _textCommonWidget("Last Updated on ", "${data.jobDetail!.u}"),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  _textCommonWidget(String title, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: Text("$title",
                  style: TextStyle(
                      fontSize: appDimens!.textw18,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600)),
            ),
            Flexible(
              child: Container(
                child: Text(":  ",
                    style: TextStyle(
                        fontSize: appDimens!.textw18,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Text(
                  "$text",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: appDimens!.textw16,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _gridView(JobDetail model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text("Employees: ",
            style: TextStyle(
                fontSize: appDimens!.textw18,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600)),
        SizedBox(height: 10),
        model.employee == null
            ? Container()
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 6.5),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: model.employee!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("${index + 1}) "),
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
                                  fontSize: appDimens!.textw16,
                                  color: AppColors.textColor,
                                )),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
      ],
    );
  }

  _photogridView(JobProvider galleryData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text("Photo Gallery: ",
            style: TextStyle(
                fontSize: appDimens!.textw18,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600)),
        SizedBox(height: 10),
        galleryData.gallery == null
            ? Container(
                child: Text('No Data Available'),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: galleryData.gallery!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.grey[100],
                        child: Image.network(
                          "${galleryData.gallery![index].fileName}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ],
    );
  }
}
