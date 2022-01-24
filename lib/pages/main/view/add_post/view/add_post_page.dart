import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../app/constants/app_constants.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/widgets/custom_text_form.dart';
import '../../../model/post_model.dart';
import '../../../model/replying_post_model.dart';
import '../components/add_post_image_layout.dart';
import '../components/app_bar.dart';
import '../components/bottom_layout.dart';
import '../components/top_layout.dart';
import '../view_model/add_post_view_model.dart';

class AddPostPage extends StatefulWidget {
  AddPostPage({
    Key? key,
    this.isAComment = false,
    this.postAddingReference,
    this.replyingPostPostModel,
  }) : super(key: key);

  bool isAComment;
  ReplyingPostModel? replyingPostModel;
  CollectionReference? postAddingReference;
  PostModel? replyingPostPostModel;

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> with WidgetsBindingObserver {
  late BuildContext context;
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  AddPostViewModel addPostViewModel = AddPostViewModel();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    addPostViewModel.setContext(context);
    return WillPopScope(
      onWillPop: addPostViewModel.canPageClose,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: _buildPage,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    addPostViewModel.isAComment = widget.isAComment;
    addPostViewModel.postAddingReference = widget.postAddingReference;
    addPostViewModel.replyingPostPostModel = widget.replyingPostPostModel;
  }

  Widget get _buildPage => Observer(
        builder: (_) => Form(
          key: formKey,
          child: Column(
            children: [
              IgnorePointer(
                  ignoring: addPostViewModel.screenLockState, child: _appBar),
              Expanded(child: _buildOtherWidgets),
            ],
          ),
        ),
      );

  Widget get _buildOtherWidgets => Observer(
        builder: (_) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: IgnorePointer(
                child: _buildMessageAndTopLayout,
                ignoring: addPostViewModel.screenLockState,
              ),
            ),
            _bottomLayout,
          ],
        ),
      );

  Widget get _buildMessageAndTopLayout => Column(
        children: [
          _topLayout,
          Expanded(flex: 1, child: _buildTextFormAndImages),
        ],
      );

  Widget get _buildTextFormAndImages => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          width: context.width,
          child: Column(
            children: [
              _textField,
              SizedBox(
                width: context.width,
                height: context.height / 3,
                child: _images,
              ),
            ],
          ),
        ),
      );

  Widget get _images => Observer(
        builder: (_) => ListView.builder(
          clipBehavior: Clip.antiAlias,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: addPostViewModel.imagesLength,
          controller: addPostViewModel.scrollController,
          itemBuilder: (context, index) =>
              _buildImageLayout(index) ?? Container(),
        ),
      );

  Widget? _buildImageLayout(index) {
    if (addPostViewModel.images.isEmpty) return null;
    return AddPostImageLayout(index: index, viewModel: addPostViewModel);
  }

  Widget get _textField => CustomTextFormField(
        hideCounterText: true,
        maxLength: PostContstants.MAX_POST_TEXT_LENGTH,
        fontSize: 15,
        onTextChanged: (text) => addPostViewModel.onPostTextChanged(text),
        maxLines: 10,
        backgroundColor: AppColors.white,
        inputBorder: InputBorder.none,
        controller: controller,
        hintText: addPostViewModel.isAComment ? 'Write your reply!' : "Write what you want!",
        disableLeading: true,
      );

  Widget get _topLayout => AddPostTopLayout(viewModel: addPostViewModel);

  Widget get _bottomLayout => AddPostBottomLayout(viewModel: addPostViewModel);

  Widget get _appBar => AddPostAppBar(viewModel: addPostViewModel);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) context.unFocus;
  }
}
