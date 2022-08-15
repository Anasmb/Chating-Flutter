import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
    this._message,
    this._isMyMessage,
  );

  final String _message;
  final bool _isMyMessage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          _isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color:
                _isMyMessage ? Colors.grey[400] : Theme.of(context).accentColor,
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
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            _message,
            style: TextStyle(
              color: _isMyMessage
                  ? Colors.black
                  : Theme.of(context).accentTextTheme.headline1.color,
            ),
          ),
        ),
      ],
    );
  }
}
