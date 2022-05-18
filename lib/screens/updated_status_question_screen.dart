import 'package:flutter/material.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';
import 'package:jobtrackeremployee/constants/app_dimens.dart';
import 'package:jobtrackeremployee/models/common_model.dart';
import 'package:jobtrackeremployee/providers/job_provider.dart';
import 'package:jobtrackeremployee/screens/update_status_pages/confirmation_page.dart';
import 'package:jobtrackeremployee/screens/update_status_pages/fifth_page.dart';
import 'package:jobtrackeremployee/screens/update_status_pages/first_page.dart';
import 'package:jobtrackeremployee/screens/update_status_pages/fourth_page.dart';
import 'package:jobtrackeremployee/screens/update_status_pages/second_page.dart';
import 'package:jobtrackeremployee/screens/update_status_pages/seventh_page.dart';
import 'package:jobtrackeremployee/screens/update_status_pages/sixth_page.dart';
import 'package:jobtrackeremployee/screens/update_status_pages/third_page.dart';
import 'package:jobtrackeremployee/widgets/app_bar_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class UpdatedStatusQuestion extends StatefulWidget {
  String? jobId;
  UpdatedStatusQuestion({@required this.jobId});
  @override
  _UpdatedStatusQuestionState createState() => _UpdatedStatusQuestionState();
}

class _UpdatedStatusQuestionState extends State<UpdatedStatusQuestion> {
  AppDimens? appDimens;
  final PageController controller = PageController(initialPage: 0);
  int _curr = 0;
  int _totalPages = 7;
  @override
  Widget build(BuildContext context) {
    var providerData = Provider.of<JobProvider>(context);
    appDimens = AppDimens(MediaQuery.of(context).size.width);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, appDimens!.appBarHeight),
        child: AppBarWidget(
          automaticImplyLeading: true,
          iconThemeData: IconThemeData(color: Colors.black),
          title: Text(
            "Update Job Status",
            style:
                TextStyle(color: Colors.black87, fontSize: appDimens!.textw20),
          ),
          actions: [
            Center(
              child: Text(
                "(${_curr + 1} / $_totalPages)",
                style: TextStyle(
                    fontSize: appDimens!.textw18, color: Colors.black),
              ),
            )
          ],
        ),
      ),
      body: _mainBody(),
    );
  }

  _mainBody() {
    return Container(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PageView(
            children: [
              _firstPage(),
              _secondPage(),
              _thirdPage(),
              _fouthPage(),
              _fifthPage(),
              _sixthPage(),
              _seventhPage()
            ],
            allowImplicitScrolling: false,
            controller: controller,
            onPageChanged: (num) {
              if (mounted)
                setState(() {
                  _curr = num;
                });
            },
          ),
          _bottomButtons()
        ],
      ),
    );
  }

  TextEditingController? treachController = TextEditingController();
  TextEditingController? depthcontroller = TextEditingController();
  TextEditingController? widthController = TextEditingController();
  TextEditingController? concretecontroller = TextEditingController();
  TextEditingController? stromcontroller = TextEditingController();

  TextEditingController footPathLenght = TextEditingController();
  TextEditingController footPathWidth = TextEditingController();
  TextEditingController crossOverLenght = TextEditingController();
  TextEditingController cwController = TextEditingController();
  TextEditingController kcController = TextEditingController();

  TextEditingController startTimeController = TextEditingController();
  TextEditingController finishTimeCOntroller = TextEditingController();

  TextEditingController tenmmController = TextEditingController();
  TextEditingController twentymmController = TextEditingController();
  TextEditingController fiftymmController = TextEditingController();
  TextEditingController fiftyaboveCOntroller = TextEditingController();
  TextEditingController rootDepthController = TextEditingController();

  TextEditingController treeRootsController = TextEditingController();
  TextEditingController disposalCOntroller = TextEditingController();

  TextEditingController jobController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController preCOntroller = TextEditingController();
  TextEditingController rootPhotoController = TextEditingController();
  TextEditingController postWorkController = TextEditingController();
  _bottomButtons() {
    return Consumer<JobProvider>(
      builder: (_, data, __) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  shape: CircleBorder(
                      side: BorderSide(color: AppColors.textColor)),
                  onPressed: () {
                    controller.jumpToPage(_curr - 1);
                  },
                  child: Icon(Icons.arrow_back_ios_rounded)),
              MaterialButton(
                padding: EdgeInsets.all(15),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: AppColors.textColor)),
                onPressed: () {
                  // controller.jumpToPage(_curr + 1);
                },
                child: Text(
                  _curr + 1 == _totalPages ? "Save" : "Save",
                  style: TextStyle(fontSize: appDimens!.textw18),
                ),
              ),
              Visibility(
                  visible: _curr + 1 == _totalPages ? true : false,
                  child: SizedBox(
                    width: 20,
                  )),
              MaterialButton(
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  shape: _curr + 1 == _totalPages
                      ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: AppColors.textColor))
                      : CircleBorder(
                          side: BorderSide(color: AppColors.textColor)),
                  onPressed: () {
                    if (_curr + 1 == _totalPages) {
                      print(treachController!.text);
                      print(concretecontroller!.text);
                      print(widthController!.text);
                      print(depthcontroller!.text);
                      print(stromcontroller!.text);
                      _validation(data);

                      // pushNewScreen(context, screen: ConfirmationPage());
                    } else {
                      controller.jumpToPage(_curr + 1);
                    }
                  },
                  child: _curr + 1 == _totalPages
                      ? Text(
                          "Submit",
                          style: TextStyle(fontSize: appDimens!.textw18),
                        )
                      : Icon(Icons.arrow_forward_ios_rounded)),
            ],
          ),
        );
      },
    );
  }

  _validation(JobProvider provider) async {
    CommonResponse response = await provider.submitForm(
      context,
      conCreteCutting: concretecontroller!.text,
      width: widthController!.text,
      stomeware_reinstallment: stromcontroller!.text,
      startTie: startTimeController.text,
      reinstallment: stromcontroller!.text,
      lengthOfTrench: treachController!.text,
      kerbChannel: kcController.text,
      jobId: widget.jobId,
      footpath_length: footPathLenght.text,
      finishTime: finishTimeCOntroller.text,
      depthOfTrench: depthcontroller!.text,
      crossoverLenth: crossOverLenght.text,
      footpathWidth: footPathWidth.text,
      crossoverWidth: cwController.text,
      clientName: nameController.text,
      clientPhoneNumber: phoneController.text,
      disposalSlurry: disposalCOntroller.text,
      fiftymm: fiftymmController.text,
      fiftyplus: fiftyaboveCOntroller.text,
      jobNumber: jobController.text,
      tenmm: tenmmController.text,
      postWorkCompletionPhotos: postWorkController.text,
      preWorkPhotos: preCOntroller.text,
      rootGrowthDepth: rootDepthController.text,
      treeRootPhotos: treeRootsController.text,
      twentymm: tenmmController.text,
      treeRoots: treeRootsController.text,
    );
    if (response.status == true) {
      pushNewScreen(context, screen: ConfirmationPage());
    }
  }

  _firstPage() {
    return FirstPage(
      treachController: treachController,
      concretecontroller: concretecontroller,
      widthController: widthController,
      depthcontroller: depthcontroller,
      stromcontroller: stromcontroller,
    );
  }

  _secondPage() {
    return SecondPage(
      crossOverLenght: crossOverLenght,
      cwController: cwController,
      footPathLenght: footPathLenght,
      footPathWidth: footPathWidth,
      kcController: kcController,
    );
  }

  _thirdPage() {
    return ThirdPage(
      finishTimeCOntroller: finishTimeCOntroller,
      startTimeController: startTimeController,
    );
  }

  _fouthPage() {
    return FourthPage(
      fiftyaboveCOntroller: fiftyaboveCOntroller,
      fiftymmController: fiftymmController,
      rootDepthController: rootDepthController,
      tenmmController: tenmmController,
      twentymmController: twentymmController,
    );
  }

  _fifthPage() {
    return FifthPage(
      disposalCOntroller: disposalCOntroller,
      treeRootsController: treeRootsController,
    );
  }

  _sixthPage() {
    return SixthPage(
      jobController: jobController,
      nameController: nameController,
      phoneController: phoneController,
    );
  }

  _seventhPage() {
    return SeventhPage(
      postWorkController: postWorkController,
      preCOntroller: preCOntroller,
      rootPhotoController: rootPhotoController,
    );
  }
}
