import 'package:Carafe/pages/main/sub_views/report/view_model/report_view_model.dart';
import 'package:flutter/material.dart';
import '../../../../../core/base/view_model/base_view_model.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/extensions/double_extensions.dart';
import '../../../../../core/extensions/int_extensions.dart';
import '../../../../../core/widgets/custom_text_form.dart';
import '../../../../../core/widgets/lite_post_widget.dart';
import '../../../../../core/widgets/repyling_to_widget.dart';
import '../../../../authenticate/model/user_model.dart';
import '../../../model/post_model.dart';

class ReportView extends StatefulWidget {
  ReportView({
    Key? key,
    required this.reportType,
    required this.viewModel,
    required this.userModel,
    this.postModel,
  }) : super(key: key);

  ReportType reportType;
  PostModel? postModel;
  UserModel userModel;
  BaseViewModel viewModel;

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  Future<UserModel> user() async => widget.userModel;

  late Future<UserModel> userFuture;
  ReportViewModel reportViewModel = ReportViewModel();

  @override
  void initState() {
    super.initState();
    reportViewModel.setContext(context);
    reportViewModel.setReportType(widget.reportType);
    reportViewModel.setPostModel(widget.postModel);
    reportViewModel.setUserModel(widget.userModel);
  }

  @override
  Widget build(BuildContext context) {
    userFuture = user();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SizedBox(
        width: context.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildReportingUserWidget,
              const Divider(height: 0),
              buildPostWidget,
              buildTextForms,
              buildSendButton,
              5.0.sizedBoxOnlyHeight,
              const Divider(height: 0),
              25.0.sizedBoxOnlyHeight,
            ],
          ),
        ),
      ),
    );
  }

  Widget get buildSendButton => Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () async => await reportViewModel.report(),
            child: Container(
              margin: 15.0.edgeIntesetsRightLeft,
              child: Text(
                'Send',
                style: getTextStyle(
                  textSize: context.width / 25,
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: context.colorScheme.primary,
                  width: 1,
                  style: BorderStyle.solid,
                ),
                borderRadius: 50.radiusAll,
              ),
            ),
          ),
        ),
      );

  Widget get buildReportingUserWidget => Padding(
        padding: 15.0.edgeIntesetsAll,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReplyingToWidget(
              future: userFuture,
              viewModel: widget.viewModel,
              text: 'Reporting ',
              firstTextStyle:
                  getTextStyle(color: context.colorScheme.secondary),
              secondTextStyle: getTextStyle(color: Colors.grey),
            ),
          ],
        ),
      );

  Widget get buildTextForms => Container(
        margin: 10.0.edgeIntesetsAll,
        child: Form(
          key: reportViewModel.formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: reportViewModel.reportReasonTextFieldController,
                fontSize: context.width / 28,
                icon: Icons.description_outlined,
                labelText: 'Report Reason*',
                backgroundColor: Colors.grey.shade50,
                maxLines: 6,
                maxLength: 400,
              ),
              CustomTextFormField(
                controller: reportViewModel.emailTextFieldController,
                fontSize: context.width / 28,
                icon: Icons.email_outlined,
                labelText: 'Email (Optional)',
                backgroundColor: Colors.grey.shade50,
                keyboardType: TextInputType.emailAddress,
                validator: (text) => reportViewModel.emailValidator(text),
              ),
            ],
          ),
        ),
      );

  Widget get buildPostWidget => widget.reportType == ReportType.postReport
      ? ExpansionTile(
          initiallyExpanded: true,
          title: Text(
            'Reporting Post',
            style: getTextStyle(color: context.colorScheme.primary),
          ),
          children: [
            LitePostWidget(
              postModel: widget.postModel!,
              userModel: widget.userModel,
            ),
          ],
        )
      : Container();

  TextStyle? getTextStyle({
    Color? color,
    double? textSize,
    FontWeight? fontWeight,
  }) =>
      context.theme.textTheme.headline6?.copyWith(
        fontSize: textSize ?? context.width / 22,
        color: color ?? Colors.grey,
        fontWeight: fontWeight ?? FontWeight.bold,
      );

  AppBar get appBar => AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop,
        ),
        title: Text(
          "Reporting",
          style: TextStyle(
            fontSize: context.width / 20,
            color: context.theme.colorScheme.primary,
          ),
        ),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size(context.width, 1),
          child: const Divider(height: 0),
        ),
        iconTheme: IconThemeData(color: context.theme.colorScheme.primary),
      );
}

enum ReportType { userReport, postReport }
