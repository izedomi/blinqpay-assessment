import 'package:blinqpay/app/utils/math_util.dart';
import 'package:blinqpay/models/post_model.dart';
import 'package:blinqpay/presentations/shared/utils/space.dart';
import 'package:blinqpay/presentations/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

class PostEngagementLikes extends StatefulWidget {
  final Post post;
  final bool isLikedByCurrentUser;
  const PostEngagementLikes(
      {super.key, required this.post, required this.isLikedByCurrentUser});

  @override
  State<PostEngagementLikes> createState() => _PostEngagementLikesState();
}

class _PostEngagementLikesState extends State<PostEngagementLikes> {
  String likedUser1 = MathUtil.random(10).toString();
  String likedUser2 = MathUtil.random(10).toString();
  String likedUser3 = MathUtil.random(10).toString();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        yspace(16),
        SizedBox(
          width: screenWidth,
          height: h(35),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: RandomAvatar(
                  likedUser1,
                  trBackground: false,
                  width: w(25),
                  height: h(25),
                ),
              ),
              Positioned(
                left: 20,
                child: RandomAvatar(
                  likedUser2,
                  trBackground: false,
                  width: w(25),
                  height: h(25),
                ),
              ),
              Positioned(
                left: 40,
                child: RandomAvatar(
                  likedUser3,
                  trBackground: false,
                  width: w(25),
                  height: h(25),
                ),
              ),
              Positioned(
                  left: 75,
                  child: Padding(
                    padding: EdgeInsets.only(top: h(6)),
                    child: widget.isLikedByCurrentUser
                        ? AnimatedOpacity(
                            duration: const Duration(milliseconds: 1000),
                            opacity: widget.isLikedByCurrentUser ? 1 : 0,
                            child: RichText(
                              text: TextSpan(
                                  text: 'You',
                                  style: const TextStyle(
                                      color: AppColors.cookGrey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          ' and ${(widget.post.likeCount ?? 1) - 1} others liked this post',
                                      style: const TextStyle(
                                          // color: Colors.blueAccent,
                                          color: AppColors.cookGrey,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ]),
                            ),
                          )
                        : AnimatedOpacity(
                            duration: const Duration(milliseconds: 1000),
                            opacity: widget.isLikedByCurrentUser ? 0 : 1,
                            child: Text(
                              '${(widget.post.likeCount ?? 1)} blinqers liked this post',
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                          ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
