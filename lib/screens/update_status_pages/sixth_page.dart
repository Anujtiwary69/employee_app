import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';
import 'package:jobtrackeremployee/constants/app_dimens.dart';
import 'package:jobtrackeremployee/widgets/app_text_form_field_with_header.dart';

class SixthPage extends StatelessWidget {
  TextEditingController? jobController = TextEditingController();
  TextEditingController? nameController = TextEditingController();
  TextEditingController? phoneController = TextEditingController();
  AppDimens? appDimens;

  SixthPage({this.jobController, this.nameController, this.phoneController});
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
            "Client Details",
            style: TextStyle(
                fontSize: appDimens!.textw24,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600),
          ),
        ),
        _textFormFild("Job or PO Number", "input", jobController!),
        _textFormFild("Client Name", "input", nameController!),
        _textFormFild("Client Phone Number", "input", phoneController!),
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
