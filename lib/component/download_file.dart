import 'dart:html' as html;

import 'package:flutter/material.dart';

class DownloadFile extends StatelessWidget {
  const DownloadFile({
    Key? key,
    required this.downloadUrl,
    required this.filename,
    this.displayDeleteButton = false,
    this.onDelete,
  }) : super(key: key);

  final String filename;
  final String downloadUrl;
  final bool displayDeleteButton;
  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(filename),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                html.window.open(
                  downloadUrl,
                  'PlaceholderName',
                );
              },
              icon: const Icon(
                Icons.remove_red_eye_rounded,
              ),
            ),
            IconButton(
              onPressed: () {
                html.window.open(
                  downloadUrl,
                  'PlaceholderName',
                );
              },
              icon: const Icon(
                Icons.download_rounded,
              ),
            ),
            if (displayDeleteButton)
              IconButton(
                onPressed: () {
                  if (onDelete != null) {
                    onDelete!();
                  }
                },
                icon: const Icon(
                  Icons.delete,
                ),
              )
            else
              Container()
          ],
        ),
      ],
    );
  }
}
