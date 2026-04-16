import 'package:flutter/material.dart';
import 'package:talk_me/core/theme/app_colors.dart';
import 'package:talk_me/core/utils/context_func.dart';
import 'package:talk_me/data/models/message_dm.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({required this.uid, required this.message,required this.scrollPosition, super.key});
  final MessageDm message;
  final String uid;
  final ScrollPosition scrollPosition;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onLongPressStart: (details){
            // todo add actions of message
            final position = details.globalPosition;
            showMenu(
                position: RelativeRect.fromLTRB(
                  position.dx,
                  position.dy+20,
                  position.dx,
                  position.dy,),
                context: context,
                items: [
                  PopupMenuItem(child: Text("Delete"))
                ]
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: message.senderId == uid ? AppColors.blue500: AppColors.gray600,
              borderRadius: message.senderId == uid ? BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
                topRight: Radius.zero,
              ) : BorderRadius.only(
                topLeft: Radius.zero,
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: uid == message.senderId? CrossAxisAlignment.start : CrossAxisAlignment.end ,
              children: [
                Text(message.message,style: context.textStyle.bodyLarge!.copyWith(
                  color: AppColors.white,
                ),),

                Text(message.timeOfMessage,style: context.textStyle.bodySmall!.copyWith(
                  color: AppColors.gray200,
                  fontWeight: FontWeight.bold
                ),)

              ],
            ),
          ),
        )
      ],
    );
  }
}