import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
    this._message,
    this._isMyMessage,
    this.username,
    this.userImage,
  );

  final String _message;
  final bool _isMyMessage;
  final String username;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              _isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: _isMyMessage
                    ? Colors.grey[400]
                    : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft:
                      !_isMyMessage ? Radius.circular(0) : Radius.circular(12),
                  bottomRight:
                      _isMyMessage ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                crossAxisAlignment: _isMyMessage
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _message,
                    style: TextStyle(
                      color: _isMyMessage
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                    textAlign: _isMyMessage ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        _isMyMessage
            ? Container() // dummy container
            : Positioned(
                top: -15,
                left: 0,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(userImage),
                ),
              ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
