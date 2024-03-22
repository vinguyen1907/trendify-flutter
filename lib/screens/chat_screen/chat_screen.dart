import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/blocs/chat_bloc/chat_bloc.dart';
import 'package:ecommerce_app/blocs/user_bloc/user_bloc.dart';
import 'package:ecommerce_app/common_widgets/custom_loading_widget.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/message.dart';
import 'package:ecommerce_app/screens/chat_screen/widgets/message_input.dart';
import 'package:ecommerce_app/screens/chat_screen/widgets/message_item.dart';
import 'package:ecommerce_app/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const String routeName = '/chat-screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userBloc = context.read<UserBloc>();
    final user = userBloc.state as UserLoaded;
    context
        .read<ChatBloc>()
        .add(LoadChatRoom(imgUrl: user.user.imageUrl, name: user.user.name));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        actions: [
          ZegoSendCallInvitationButton(
            iconSize: const Size(30, 30),
            isVideoCall: true,
            buttonSize: const Size(40, 40),
            icon: ButtonIcon(
                backgroundColor: Colors.transparent,
                icon: const MyIcon(
                  icon: AppAssets.icVideoCall,
                  width: 20,
                  height: 20,
                )),
            timeoutSeconds: 60,
            invitees: [
              ZegoUIKitUser(
                id: 'admin',
                name: 'admin',
              ),
            ],
          ),
          const SizedBox(
            width: 8,
          ),
          ZegoSendCallInvitationButton(
            iconSize: const Size(30, 30),
            buttonSize: const Size(40, 40),
            icon: ButtonIcon(
                backgroundColor: Colors.transparent,
                icon: const MyIcon(
                  icon: AppAssets.icVoiceCall,
                )),
            isVideoCall: false,
            timeoutSeconds: 60,
            invitees: [
              ZegoUIKitUser(
                id: 'admin',
                name: 'admin',
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const CustomLoadingWidget();
          } else if (state is ChatLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultPadding),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: ChatService().getMessages(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CustomLoadingWidget();
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.hasData &&
                              snapshot.data!.size > 0) {
                            List<Message> messages = snapshot.data!.docs
                                .map((e) => Message.fromMap(
                                    e.data() as Map<String, dynamic>))
                                .toList();
                            return ListView.builder(
                              reverse: true,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                return MessageItem(message: messages[index]);
                              },
                            );
                          } else {
                            return const Center(
                              child: Text('No message'),
                            );
                          }
                        }),
                  ),
                  const MessageInput(),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
