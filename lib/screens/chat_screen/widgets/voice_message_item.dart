import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/extensions/date_time_extension.dart';
import 'package:ecommerce_app/models/message.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class VoiceMessageItem extends StatefulWidget {
  const VoiceMessageItem({super.key, required this.message});
  final Message message;
  @override
  State<VoiceMessageItem> createState() => _VoiceMessageItemState();
}

class _VoiceMessageItemState extends State<VoiceMessageItem> {
  bool isPlaying = false;
  late final AudioPlayer player;
  late final UrlSource path;
  bool isShowTime = false;
  bool isAnimated = false;
  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future initPlayer() async {
    player = AudioPlayer();
    path = UrlSource(widget.message.audioUrl);
    player.onPlayerComplete.listen((_) {
      setState(() {
        isPlaying = false;
        isAnimated = false;
      });
    });
  }

  void playPause() async {
    if (isPlaying) {
      player.pause();
      isPlaying = false;
      isAnimated = false;
    } else {
      player.play(path);
      isPlaying = true;
      isAnimated = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userId = firebaseAuth.currentUser!.uid;
    final isUser = widget.message.senderId == userId;
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => _showTime(),
      child: Container(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              constraints: BoxConstraints(maxWidth: size.width * 0.6),
              decoration: BoxDecoration(
                  color: isUser ? AppColors.greyColor : AppColors.primaryColor,
                  borderRadius: isUser
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15))
                      : const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      playPause();
                    },
                    child: Icon(
                      isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      size: 32.0,
                      color: isUser
                          ? AppColors.primaryColor
                          : AppColors.whiteColor,
                    ),
                  ),
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        isUser ? AppColors.primaryColor : AppColors.whiteColor,
                        BlendMode.srcIn),
                    child: LottieBuilder.asset(
                      AppAssets.lottieAudio1,
                      animate: isAnimated,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            !isShowTime
                ? const SizedBox()
                : Text(
                    widget.message.timestamp.formattedDateChat(),
                  )
          ],
        ),
      ),
    );
  }

  _showTime() {
    setState(() {
      isShowTime = !isShowTime;
    });
  }
}
