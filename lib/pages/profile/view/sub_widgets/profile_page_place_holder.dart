import 'package:flutter/material.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/double_extensions.dart';
import 'place_holders/profile_following_and_followers_place_holder_layout.dart';
import 'place_holders/profile_view_description_place_holder.dart';
import 'place_holders/profile_view_follow_button_place_holder.dart';
import 'place_holders/profile_view_profiile_photo_place_holder.dart';
import 'place_holders/proflle_view_displayname_and_username_place_holder.dart';

class ProfilePagePlaceHolder extends StatelessWidget {
  ProfilePagePlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 15.0.edgeIntesetsAll,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileViewProfilePhotoPlaceHolder(),
              Expanded(
                child: Container(
                  margin: 15.0.edgeIntesetsRightLeft,
                  height: context.width / 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ProfileFollowingAndFollowersPlaceHolderLayout(),
                      10.0.sizedBoxOnlyHeight,
                      ProfileViewFollowButtonPlaceHolder(),
                    ],
                  ),
                ),
              )
            ],
          ),
          15.0.sizedBoxOnlyHeight,
          ProfileViewDisplaynameAndUsernamePlaceHolder(),
          8.0.sizedBoxOnlyHeight,
          ProfileViewDescriptionPlaceHolder(),
        ],
      ),
    );
  }
}
