import 'package:flutter/material.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';
import 'package:jobtrackeremployee/constants/app_dimens.dart';
import 'package:jobtrackeremployee/widgets/app_text_form_field_with_header.dart';

class FirstPage extends StatelessWidget {
  TextEditingController? treachController = TextEditingController();
  TextEditingController? depthcontroller = TextEditingController();
  TextEditingController? widthController = TextEditingController();
  TextEditingController? concretecontroller = TextEditingController();
  TextEditingController? stromcontroller = TextEditingController();
  FirstPage(
      {this.treachController,
      this.concretecontroller,
      this.depthcontroller,
      this.stromcontroller,
      this.widthController});
  AppDimens? appDimens;
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
            "TRB, SRP, NDRI, Excavation, Stromwater",
            style: TextStyle(
                fontSize: appDimens!.textw24,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600),
          ),
        ),
        _textFormFild("Length of trench (I/m)", "input", treachController!),
        _textFormFild("Depth of trench (mm)", "input", depthcontroller!),
        _textFormFild("Width (mm)", "input", widthController!),
        _textFormFild("Concrete cutting (I/m)", "input", concretecontroller!),
        _textFormFild("Stromwater reinstatement (I/m)", "input", stromcontroller!)
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
