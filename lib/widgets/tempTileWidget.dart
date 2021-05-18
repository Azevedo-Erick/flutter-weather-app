import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TempTileWidget extends StatefulWidget {
  final String textDescription;
  final info;
  final String decoration;
  final FaIcon icon;
  const TempTileWidget(
      {Key key,
      @required this.info,
      @required this.decoration,
      @required this.icon,
      @required this.textDescription})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _TempTileWidgetState();
}

class _TempTileWidgetState extends State<TempTileWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.icon,
      title: Text(widget.textDescription),
      trailing: Text(widget.info != null
          ? widget.info.toString() + widget.decoration
          : "Carregando..."),
    );
  }
}
