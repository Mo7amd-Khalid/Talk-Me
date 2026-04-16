import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:talk_me/core/di/di.dart';
import 'package:talk_me/core/theme/app_colors.dart';
import 'package:talk_me/core/utils/context_func.dart';
import 'package:talk_me/core/utils/padding.dart';
import 'package:talk_me/core/utils/white_spaces.dart';
import 'package:talk_me/data/models/message_dm.dart';
import 'package:talk_me/data/models/user_dm.dart';
import 'package:talk_me/presentation/chat_screen/cubit/chat_screen_contract.dart';
import 'package:talk_me/presentation/chat_screen/cubit/chat_screen_cubit.dart';
import 'package:talk_me/presentation/main/cubit/main_cubit.dart';
import 'package:talk_me/presentation/widgets/message_widget.dart';
import 'package:talk_me/presentation/widgets/profile_widget.dart';

class ChatScreenView extends StatelessWidget {
  ChatScreenView({required this.friendData, super.key});

  final UserDm friendData;
  final MainCubit _mainCubit = getIt();
  final ChatScreenCubit _chatScreenCubit = getIt();
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: Row(
          children: [
            buildProfileImage(
              path: friendData.image,
              context: context,
              width: context.widthSize * 0.13,
              height: context.heightSize * 0.05,
              color: AppColors.white,
            ),
            5.horizontalSpace,
            Text(friendData.name),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: _chatScreenCubit.getMessages(friendData.id),
        builder:(_, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator());
            }
          else if(snapshot.hasData)
            {
              List<MessageDm>? newMessage = snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
              return Column(
                children: [
                  Expanded(child: ListView.separated(
                      padding: EdgeInsets.all(8),
                      controller: scrollController,
                      itemBuilder: (_,index) => Column(
                        crossAxisAlignment: _mainCubit.state.currentUser.data!.id == newMessage[index].senderId ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [

                          MessageWidget(uid: _mainCubit.state.currentUser.data!.id, message: newMessage[index],scrollPosition: scrollController.position,),
                        ],
                      ),
                      separatorBuilder: (_,_) => 10.verticalSpace,
                      itemCount: newMessage.length)),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: messageController,
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(hintText: "Type a message..."),
                        ),
                      ),
                      5.horizontalSpace,
                      CircleAvatar(
                        backgroundColor: AppColors.blue500,
                        child: IconButton(
                          onPressed: () {
                            if(messageController.text.isNotEmpty)
                            {
                              _chatScreenCubit.doAction(SendMessage(MessageDm(
                                  id: "",
                                  message: messageController.text,
                                  senderId: _mainCubit.state.currentUser.data!.id,
                                  receiverId: friendData.id,
                                  timeOfMessage: DateFormat("MMM d,y HH:mm a").format(DateTime.now()),
                                  milliSecondTime: DateTime.now().millisecondsSinceEpoch,
                                  image: null
                              ), friendData.id));
                              messageController.text = "";
                            }

                          },
                          icon: Icon(Icons.send, color: AppColors.white),
                        ),
                      ),
                    ],
                  ).allPadding(16),
                ],
              );
            }
          else
            {
              return Center(child: Text(snapshot.error.toString()));
            }

        },
      ),
    );
  }
}
