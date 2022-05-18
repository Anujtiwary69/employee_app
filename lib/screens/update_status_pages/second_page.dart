import 'package:flutter/material.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';
import 'package:jobtrackeremployee/constants/app_dimens.dart';
import 'package:jobtrackeremployee/widgets/app_text_form_field_with_header.dart';

class SecondPage extends StatelessWidget {
  TextEditingController? footPathLenght = TextEditingController();
  TextEditingController? footPathWidth = TextEditingController();
  TextEditingController? crossOverLenght = TextEditingController();
  TextEditingController? cwController = TextEditingController();
  TextEditingController? kcController = TextEditingController();
  AppDimens? appDimens;

  SecondPage(
      {this.crossOverLenght,
      this.cwController,
      this.footPathLenght,
      this.footPathWidth,
      this.kcController});
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
            "Footpath Reinstatement",
            style: TextStyle(
                fontSize: appDimens!.textw24,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600),
          ),
        ),
        _textFormFild("Footpath Length (I/m)", "input", footPathLenght!),
        _textFormFild("Footpath Width (I/m)", "input", footPathWidth!),
        _textFormFild("Crossover Length (I/m)", "input", crossOverLenght!),
        _textFormFild("Crossover width (I/m)", "input", cwController!),
        _textFormFild("Kerb & Channel (I/m)", "input", kcController!)
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
