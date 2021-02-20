import 'package:flutter/material.dart';

class CustomInputDialogWidget extends StatefulWidget {
  final String title;
  final Color themeColor;
  final String note;
  CustomInputDialogWidget(
    this.title,
    this.themeColor,
    this.note,
  );
  @override
  _CustomInputDialogWidgetState createState() =>
      _CustomInputDialogWidgetState();
}

class _CustomInputDialogWidgetState extends State<CustomInputDialogWidget> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.note);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.white,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) {
    return Container(
      height: 238,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[100],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  autofocus: true,
                  // style: StyledTexts.blackBodyTextStyle,
                  cursorColor: Colors.black,
                  textCapitalization: TextCapitalization.sentences,
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Type the quantity",
                    // hintStyle: StyledTexts.grayBodyTextStyle,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              child: Row(
                children: [
                  ButtonTheme(
                    height: 40,
                    minWidth: 100,
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: widget.themeColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Add to Cart",
                        // style: StyledTexts.blackHeading4TextStyle,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(_controller.text);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomInputDialog {
  static Future<String> show(
    BuildContext context,
    String title, {
    Color themeColor = Colors.black,
    String note = "",
  }) =>
      showDialog(
        context: context,
        builder: (context) => CustomInputDialogWidget(
          title,
          themeColor,
          note,
        ),
      );
}
