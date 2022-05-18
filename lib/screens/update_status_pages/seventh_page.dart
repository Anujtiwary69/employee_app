import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';
import 'package:jobtrackeremployee/constants/app_dimens.dart';
import 'package:jobtrackeremployee/widgets/app_text_form_field_with_header.dart';

class SeventhPage extends StatelessWidget {
  TextEditingController? preCOntroller = TextEditingController();

  TextEditingController? rootPhotoController = TextEditingController();
  TextEditingController? postWorkController = TextEditingController();
  AppDimens? appDimens;

  SeventhPage(
      {this.postWorkController, this.preCOntroller, this.rootPhotoController});
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
            "Photos",
            style: TextStyle(
                fontSize: appDimens!.textw24,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600),
          ),
        ),
        _textFormFild("Pre works photos (yes/no)", "(Yes/No)", preCOntroller!),
        _textFormFild(
            "Tree root photos (yes/no)", "(Yes/No)", rootPhotoController!),
        _textFormFild("Post work completion photos (yes/no)", "(Yes/No)",
            postWorkController!),
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
