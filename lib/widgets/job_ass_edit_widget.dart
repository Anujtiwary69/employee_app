import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import 'package:jobtrackeremployee/constants/app_colors.dart';
import 'package:jobtrackeremployee/constants/app_constants.dart';
import 'package:jobtrackeremployee/models/client_model.dart';
import 'package:jobtrackeremployee/models/job_status_model.dart';
import 'package:jobtrackeremployee/providers/job_provider.dart';
import 'package:jobtrackeremployee/widgets/app_text_form_field_with_header.dart';
import 'package:provider/provider.dart';

class JobAddEditWidget extends StatefulWidget {
  final bool? isEdit;
  JobAddEditWidget({this.isEdit});
  @override
  _JobAddEditWidgetState createState() => _JobAddEditWidgetState();
}

class _JobAddEditWidgetState extends State<JobAddEditWidget> {
  _textFormField2(
      {String? labelText,
      String? headerText,
      FocusNode? focusNode,
      void Function()? onTap,
      TextEditingController? controller,
      TextInputType? keyBoardType = TextInputType.text}) {
    return Material(
      color: Colors.transparent,
      child: TextFormFieldWidgetWithHeader(
        controller: controller,
        text: "$labelText",
        focusNode: focusNode,
        onTap: onTap,
        headerText: "$headerText",
        keyBoardType: keyBoardType,
      ),
    );
  }

  TextEditingController sitePhoneController = new TextEditingController();
  TextEditingController siteMobileController = new TextEditingController();
  TextEditingController lnameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController jobTitleController = new TextEditingController();
  TextEditingController contactPersonController = new TextEditingController();

  setData() {
    if (widget.isEdit!) {
      // descriptionController.text = "${widget.clientList!.contactFirstName}";
      // lnameController.text = "${widget.clientList!.contactLastName}";
      // siteMobileController.text = "${widget.clientList!.mobileNo}";
      // stateController.text = "${widget.clientList!.state}";
      // cityController.text = "${widget.clientList!.city}";
      // jobTitleController.text = "${widget.clientList!.businessName}";
      // addressController.text = "${widget.clientList!.address}";
      // sitePhoneController.text = widget.clientList!.phoneNo!;
      // emailController.text = widget.clientList!.contactEmail!;

      setState(() {});
    }
  }

  bool isLoading = false;
  List<DropdownMenuItem>? _drpdownClientItems;
  List<DropdownMenuItem>? _dropdownJobTypeItems;
  List<DropdownMenuItem>? _dropdownJobStatusItems;
  List<String> statusList = ["John Smith", "AnnA k. Bosch", "Carry Jones"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _drpdownClientItems = buildDropdownTestItems(statusList);
  }

  List<String> list_items = ["Active", "Inactive"];
  List<DropdownMenuItem>? _dropdownTestItems;
  String? _selectedTest;
  onChangeDropdownTests(selectedTest) {
    if (mounted) print(selectedTest);
    setState(() {
      _selectedTest = selectedTest;
    });
  }

  List<DropdownMenuItem> buildDropdownItems(List<String> _testList) {
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

  _setData(JobProvider providerData) async {
    setState(() {
      isLoading = true;
    });
    await providerData.getClientList(context);
    await providerData.getJobType(context);
    await providerData.getJobStatusList(context);
    _drpdownClientItems = buildDropdownTestItems(providerData.clientList!);
    _dropdownJobTypeItems = buildDropdownJobTypeItems(providerData.jobType!);
    _dropdownJobStatusItems =
        buildDropdownJobStatusItems(providerData.jobStatus!);
    _dropdownTestItems = buildDropdownItems(list_items);
    setState(() {
      isLoading = false;
    });
  }

  JobProvider? providerData;
  bool isFirst = false;
  @override
  Widget build(BuildContext context) {
    providerData = Provider.of<JobProvider>(context);
    if (isFirst == false) {
      _setData(providerData!);
      isFirst = true;
    }
    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height * .8,
      child: _drpdownClientItems == null ||
              _dropdownJobTypeItems == null ||
              _dropdownJobStatusItems == null ||
              _dropdownTestItems == null
          ? Container(
              color: Colors.transparent,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: SpinKitThreeBounce(
                    size: 35,
                    duration: new Duration(milliseconds: 1100),
                    color: AppColors.appColor),
              ),
            )
          : _mainBody(),
    );
  }

  _mainBody() {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    _dropDownView(
                        headerText: "Client:",
                        text: "Select Client",
                        items: _drpdownClientItems!,
                        onChanged: onChangeDropdownClient,
                        value: _selectedClient),
                    SizedBox(
                      height: 10,
                    ),
                    _dropDownView(
                        headerText: "Job Type:",
                        text: "Select Job Type",
                        items: _dropdownJobTypeItems!,
                        onChanged: onChangeDropdownJobType,
                        value: _selectedJobType),
                    SizedBox(
                      height: 10,
                    ),
                    _dropDownView(
                        headerText: "Job Status:",
                        text: "Select Job Status",
                        items: _dropdownJobStatusItems!,
                        onChanged: onChangeDropdownJobStatus,
                        value: _selectedJobStatus),
                    SizedBox(
                      height: 10,
                    ),
                    _textFormField2(
                        headerText: "Job Title:",
                        controller: jobTitleController,
                        labelText: "Enter Job Title"),
                    SizedBox(
                      height: 10,
                    ),
                    _textFormField2(
                        headerText: "Job Description:",
                        controller: descriptionController,
                        labelText: "Enter Job Description"),
                    SizedBox(
                      height: 10,
                    ),
                    // _textFormField2(
                    //     headerText: "Last Name:",
                    //     controller: lnameController,
                    //     labelText: "Enter last name"),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // _textFormField2(
                    //     headerText: "Email",
                    //     controller: emailController,
                    //     labelText: "Enter email"),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    _textFormField2(
                        headerText: "Address: ",
                        keyBoardType: TextInputType.emailAddress,
                        controller: addressController,
                        labelText: "Enter Address"),
                    SizedBox(
                      height: 10,
                    ),
                    _textFormField2(
                        headerText: "City:",
                        keyBoardType: TextInputType.phone,
                        controller: cityController,
                        labelText: "Enter City"),

                    SizedBox(
                      height: 10,
                    ),
                    _textFormField2(
                        headerText: "State:",
                        controller: stateController,
                        labelText: "Enter State"),
                    SizedBox(
                      height: 10,
                    ),
                    _textFormField2(
                        headerText: "Start Date:",
                        focusNode: AlwaysDisabledFocusNode(),
                        keyBoardType: TextInputType.phone,
                        controller: startDateController,
                        onTap: () {
                          _selectDate(context);
                        },
                        labelText: "Enter start date"),
                    SizedBox(
                      height: 10,
                    ),
                    _textFormField2(
                        headerText: "Start time:",
                        focusNode: AlwaysDisabledFocusNode(),
                        keyBoardType: TextInputType.phone,
                        controller: timeController,
                        onTap: () {
                          _selectTime(context);
                        },
                        labelText: "Enter start time"),
                    SizedBox(
                      height: 10,
                    ),
                    _textFormField2(
                        headerText: "Contact Person:",
                        controller: contactPersonController,
                        labelText: "Enter Contact Person"),
                    SizedBox(
                      height: 10,
                    ),
                    _dropDown(),
                    SizedBox(
                      height: 10,
                    ),
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
                            if (jobTitleController.text.trim().length == 0) {
                              AppConstants()
                                  .showToast(msg: "Please enter the job title");
                            } else if (descriptionController.text
                                    .trim()
                                    .length ==
                                0) {
                              AppConstants().showToast(
                                  msg: "Please enter the description");
                            } else if (_selectedClient == null) {
                              AppConstants()
                                  .showToast(msg: "Please select the client");
                            } else if (_selectedJobType == null) {
                              AppConstants()
                                  .showToast(msg: "Please select the Job type");
                            } else if (_selectedJobStatus == null) {
                              AppConstants().showToast(
                                  msg: "Please select the Job status");
                            }
                            //  else if (_selectedClient == null) {
                            //   AppConstants()
                            //       .showToast(msg: "Please select the client");
                            // }
                            else if (addressController.text.trim().length ==
                                0) {
                              AppConstants()
                                  .showToast(msg: "Please enter address");
                            } else if (cityController.text.trim().length == 0) {
                              AppConstants()
                                  .showToast(msg: "Please enter city");
                            } else if (stateController.text.trim().length ==
                                0) {
                              AppConstants()
                                  .showToast(msg: "Please enter state");
                            } else if (startDateController.text.trim().length ==
                                0) {
                              AppConstants().showToast(
                                  msg: "Please select the start data");
                            } else if (timeController.text.trim().length == 0) {
                              AppConstants()
                                  .showToast(msg: "Please select the time");
                            } else {
                              setState(() {
                                isLoading = true;
                              });
                              // if (widget.isEdit!) {
                              // Navigator.pop(context, true);
                              // await providerData!.addEditJob(
                              //   title: timeController.text,
                              //   address: addressController.text,
                              //   description: descriptionController.text,
                              //   city: cityController.text,
                              //   clientId: "${_selectedClient.id}",
                              //   contactPerson: contactPersonController.text,
                              //   context: context,
                              //   isEdit: false,
                              //   jobStatusId: "${_selectedJobStatus.id}",
                              //   jobTypeId: "${_selectedJobType.id}",
                              //   startDate: startDateController.text,
                              //   startTime: timeController.text,
                              //   state: stateController.text,
                              //   status: _selectedTest!,
                              // );

                              //   setState(() {
                              //     isLoading = false;
                              //   });
                              // } else {
                              //   setState(() {
                              //     isLoading = true;
                              //   });
                              await providerData!
                                  .addEditJob(
                                title: jobTitleController.text,
                                address: addressController.text,
                                description: descriptionController.text,
                                city: cityController.text,
                                clientId: "${_selectedClient.id}",
                                contactPerson: contactPersonController.text,
                                context: context,
                                isEdit: false,
                                jobStatusId: "${_selectedJobStatus.id}",
                                jobTypeId: "${_selectedJobType.id}",
                                startDate: startDateController.text,
                                startTime: timeController.text,
                                state: stateController.text,
                                status: _selectedTest!,
                              )
                                  .then((value) {
                                if (value.status == true) {
                                  Navigator.pop(context, true);
                                }
                              });

                              setState(() {
                                isLoading = false;
                              });
                              // }
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
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topRight,
              child: Material(
                color: AppColors.appColor,
                shape: CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                      onTap: () => Navigator.pop(context, false),
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
            AppConstants.progress(false, context)
          ],
        ),
      ),
    );
  }

  _dropDown() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
                // key: dropDownKey,

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

  DateTime? _selectedDate = DateTime.now();
  TextEditingController startDateController = TextEditingController();
  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      startDateController
        ..text = DateFormat.yMMMd().format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: startDateController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController timeController = new TextEditingController();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext? context, Widget? child) {
          return MediaQuery(
            data:
                MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
        timeController.text = picked_s.format(context);
      });
  }

  var _selectedClient;
  List<DropdownMenuItem> buildDropdownTestItems(List<ClientList> _testList) {
    List<DropdownMenuItem> items = [];
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(
            "${i.contactFirstName} ${i.contactLastName}",
            style: const TextStyle(
                color: const Color(0xff003059),
                fontWeight: FontWeight.w300,
                fontFamily: "Poppins",
                fontStyle: FontStyle.normal,
                fontSize: 18.0),
          ),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem> buildDropdownJobTypeItems(List<JobType> _testList) {
    List<DropdownMenuItem> items = [];
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(
            "${i.title}",
            style: const TextStyle(
                color: const Color(0xff003059),
                fontWeight: FontWeight.w300,
                fontFamily: "Poppins",
                fontStyle: FontStyle.normal,
                fontSize: 18.0),
          ),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem> buildDropdownJobStatusItems(
      List<JobStatus> _testList) {
    List<DropdownMenuItem> items = [];
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(
            "${i.title}",
            style: const TextStyle(
                color: const Color(0xff003059),
                fontWeight: FontWeight.w300,
                fontFamily: "Poppins",
                fontStyle: FontStyle.normal,
                fontSize: 18.0),
          ),
        ),
      );
    }
    return items;
  }

  _dropDownView(
      {String? text,
      String? headerText,
      dynamic value,
      required List<DropdownMenuItem<dynamic>> items,
      required void Function(dynamic) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$headerText",
              style: TextStyle(
                fontSize: 20,
                color: AppColors.appColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            DropdownBelow(
              itemWidth: MediaQuery.of(context).size.width * 0.95,
              boxWidth: MediaQuery.of(context).size.width,
              itemTextstyle: TextStyle(color: Colors.black87, fontSize: 18),
              boxTextstyle: TextStyle(
                  color: const Color(0xffbfbfbf),
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 15.0),
              boxPadding: EdgeInsets.only(left: 10, right: 5),
              // boxHeight: 40,
              elevation: 0,
              boxDecoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(0)),
                border: Border.all(color: Colors.grey),
              ),
              hint: Container(
                  child: Text(
                '$text',
                style: TextStyle(
                    color: Color(0xff666666),
                    fontStyle: FontStyle.italic,
                    fontSize: 18),
              )),
              icon: Icon(Icons.keyboard_arrow_down_outlined,
                  color: const Color(0xff666666)),
              value: value,
              items: items,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }

  var _selectedJobType;
  var _selectedJobStatus;
  onChangeDropdownClient(selectedClient) {
    print(selectedClient);
    setState(() {
      _selectedClient = selectedClient;
    });
  }

  onChangeDropdownJobType(selectedItem) {
    print(selectedItem);
    setState(() {
      _selectedJobType = selectedItem;
    });
  }

  onChangeDropdownJobStatus(selectedItem) {
    print(selectedItem);
    setState(() {
      _selectedJobStatus = selectedItem;
    });
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
