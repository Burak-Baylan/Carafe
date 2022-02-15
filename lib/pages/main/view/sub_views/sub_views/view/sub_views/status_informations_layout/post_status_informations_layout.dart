import 'package:flutter/material.dart';
import '../../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../../core/extensions/int_extensions.dart';
import '../../../../../../../../core/widgets/border_container.dart';
import '../../../../../../model/post_status_informations_model.dart';

class PostStatusInformationsLayout extends StatefulWidget {
  PostStatusInformationsLayout({
    Key? key,
    required this.postStatusInformationsModel,
  }) : super(key: key);

  PostStatusInformationsModel postStatusInformationsModel;

  @override
  State<PostStatusInformationsLayout> createState() =>
      _PostStatusInformationsLayoutState();
}

class _PostStatusInformationsLayoutState
    extends State<PostStatusInformationsLayout> {
  @override
  Widget build(BuildContext context) {
    return BorderContainer.all(
      radius: 15,
      color: Colors.transparent,
      decoration: BoxDecoration(
        border: Border.all(width: .5, color: Colors.grey.shade500),
        borderRadius: 15.radiusAll,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 15),
                    child: _buildViewsLayout,
                  ),
                  Divider(color: Colors.grey.shade500, thickness: .5),
                  Container(
                    margin: const EdgeInsets.only(left: 15, bottom: 15),
                    child: _buildInteractionsLayout,
                  ),
                ],
              ),
            ),
            VerticalDivider(
              color: Colors.grey.shade500,
              thickness: .5,
              width: 0,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 15),
                    child: _buildProfileVisitsLayout,
                  ),
                  Divider(color: Colors.grey.shade500, thickness: .5),
                  Container(
                    margin: const EdgeInsets.only(left: 15, bottom: 15),
                    child: _postClicksLayout,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildViewsLayout => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleText('Views'),
          _buildCountText(
              widget.postStatusInformationsModel.views.shorten.toString()),
        ],
      );

  Widget get _buildInteractionsLayout => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleText('Interactions'),
          _buildCountText(widget
              .postStatusInformationsModel.interactions.shorten
              .toString()),
        ],
      );

  Widget get _buildProfileVisitsLayout => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleText('Profile Visits'),
          _buildCountText(widget
              .postStatusInformationsModel.profileVisits.shorten
              .toString()),
        ],
      );

  Widget get _postClicksLayout => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleText('Post Clicks'),
          _buildCountText(
              widget.postStatusInformationsModel.postClicks.shorten.toString()),
        ],
      );

  Widget _buildTitleText(String text) => Text(
        text,
        style: TextStyle(
          fontSize: context.width / 30,
          color: Colors.grey[500],
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildCountText(String text) => FittedBox(
        child: Text(
          text,
          maxLines: 1,
          style: TextStyle(
            fontSize: context.width / 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
}
