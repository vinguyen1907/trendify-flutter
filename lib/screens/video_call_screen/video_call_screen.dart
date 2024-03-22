import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:flutter/material.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({Key? key, required this.callID}) : super(key: key);
  final String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID:
          873318300, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          '5cdfa7af1e9db08e0a2b4e581c5bb600983aa40f2b9fd87b0193dde445721ed8', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: 'user_id1',
      userName: 'user_name1',
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
