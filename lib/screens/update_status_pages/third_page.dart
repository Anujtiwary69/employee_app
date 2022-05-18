import 'package:flutter/material.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';
import 'package:jobtrackeremployee/constants/app_dimens.dart';
import 'package:jobtrackeremployee/widgets/app_text_form_field_with_header.dart';

class ThirdPage extends StatelessWidget {
  TextEditingController? startTimeController = TextEditingController();
  TextEditingController? finishTimeCOntroller = TextEditingController();
  AppDimens? appDimens;
  ThirdPage({this.finishTimeCOntroller,this.startTimeController});
  @override
  Widget build(BuildContext context) {
    appDimens = AppDimens(MediaQuery.of(context).size.width);
    return Container(
      child: _mainBody(),
    );
  }

  _mainBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Duration / Times onsite",
            style: TextStyle(
                fontSize: appDimens!.textw24,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600),
          ),
        ),
        _textFormFild("Start time (am/pm)", "input", startTimeController!),
        _textFormFild("Finish time (am/pm)", "input", finishTimeCOntroller!),
      ],
    );
  }

  _textFormFild(
      String headerText, String hintText, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: TextFormFieldWidgetWithHeader(
        headerText: headerText,
        text: hintText,
        controller: controller,
      ),
    );
  }
}
