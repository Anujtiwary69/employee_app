import 'package:flutter/material.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';
import 'package:jobtrackeremployee/constants/app_dimens.dart';
import 'package:jobtrackeremployee/widgets/app_text_form_field_with_header.dart';

class FourthPage extends StatelessWidget {
  TextEditingController? tenmmController = TextEditingController();
  TextEditingController? twentymmController = TextEditingController();
  TextEditingController? fiftymmController = TextEditingController();
  TextEditingController? fiftyaboveCOntroller = TextEditingController();
  TextEditingController? rootDepthController = TextEditingController();
  AppDimens? appDimens;
  FourthPage(
      {this.fiftyaboveCOntroller,
      this.fiftymmController,
      this.rootDepthController,
      this.tenmmController,
      this.twentymmController});
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
            "Rootpruning",
            style: TextStyle(
                fontSize: appDimens!.textw24,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600),
          ),
        ),
        _textFormFild("10mm and under", "input", tenmmController!),
        _textFormFild("10mm to 20mm", "input", twentymmController!),
        _textFormFild("20mm to 50mm", "input", fiftymmController!),
        _textFormFild("50mm and above", "input", fiftyaboveCOntroller!),
        _textFormFild("Root growth depth(mm)", "input", rootDepthController!)
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
