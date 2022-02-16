import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../core/constants/firebase/firebase_constants.dart';
import '../../../../../../../../core/extensions/color_extensions.dart';
import '../../../../../../../../core/helpers/status_bar_helper.dart';
import '../../../../../../../../core/init/navigation/service/navigation_service.dart';
import '../../../../../../model/post_model.dart';
import '../../../../../add_post/view/add_post_page.dart';
import '../../../../../home/view/sub_views/home_page_full_screen_image/home_page_full_screen_image.dart';
import '../../../../sub_views/view/post_status.dart';
import '../../../full_screen_post_view/full_screen_post_view.dart';
import '../post_view_model.dart';

class PostViewModelNavigators {
  void onPressedImage(
    List<ImageProvider<Object>?> imageProviders,
    List<dynamic> imageUrls,
    int imageIndex,
    String imageTag,
    PostModel postModel,
  ) {
    if (imageProviders[imageUrls.length - 1] == null) return;
    StatusBarHelper.edgeToEdgeScreen();
    Colors.transparent.changeBottomNavBarColor;
    customNavigateToPage(
      HomePageFullScreenImage(
        imageProviders: imageProviders,
        imageUrls: imageUrls,
        imageIndex: imageIndex,
        imagesDominantColor: postModel.imagesDominantColors,
        tag: imageTag,
      ),
      false,
    );
  }

  void navigateToPostStatus(PostViewModel postViewModel, PostModel postModel) =>
      customNavigateToPage(
          PostStatusView(
            postModel: postModel,
            postViewModel: postViewModel,
          ),
          true);

  void navigateToFullScreenPostView(
    PostViewModel viewModel,
    PostModel postModel,
    DocumentReference ref,
  ) =>
      customNavigateToPage(
        FullScreenPostView(postViewModel: viewModel, postModel: postModel),
        true,
      );

  void navigateToReplyScreen(
    PostModel postModel,
    DocumentReference<Object?> postAddingRef,
  ) =>
      customNavigateToPage(
        AddPostPage(
          isAComment: true,
          postAddingReference: postAddingRef
              .collection(FirebaseConstants.instance.postCommentsText),
          replyingPostPostModel: postModel,
        ),
        true,
      );

  customNavigateToPage(Widget page, bool animate) =>
      NavigationService.instance.customNavigateToPage(page, animate: animate);
}
