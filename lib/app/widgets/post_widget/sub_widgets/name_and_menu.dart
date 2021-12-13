import 'package:Carafe/view/main/model/post_model.dart';
import 'package:flutter/material.dart';

class PostNameAndMenu extends StatelessWidget {
  PostNameAndMenu({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //TODO Delete static name
        const Text(
          "burak Byln",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          customBorder: const CircleBorder(),
          onTap: () {},
          child: const Icon(
            Icons.more_vert_outlined,
            size: 20,
          ),
        ),
      ],
    );
  }
}
