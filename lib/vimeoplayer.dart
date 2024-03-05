import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VimeoVideoPlayer extends StatefulWidget {
  const VimeoVideoPlayer({
    super.key,
    required this.videoId,
  });

  final String videoId;

  @override
  State<VimeoVideoPlayer> createState() => VimeoVideoPlayerState();
}

class VimeoVideoPlayerState extends State<VimeoVideoPlayer> {
  final _controller = WebViewController();

  @override
  void initState() {
    _controller
      ..loadRequest(_videoPage(widget.videoId))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        ElevatedButton(
          onPressed: () {
            _playVideo();
          },
          child: const Text('Play Video'),
        ),
      ],
    );
  }

  void _playVideo() async {
    await _controller.runJavaScript('''
    playVideo();''');
    debugPrint('Play button pressed!');
  }

  Uri _videoPage(String videoId) {
    final html = '''
            <html>
              <head>
                <style>
                  body {
                   background-color: lightgray;
                   margin: 0px;
                   }
                </style>
                <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0">
                <meta http-equiv="Content-Security-Policy" 
                content="default-src * gap:; script-src * 'unsafe-inline' 'unsafe-eval'; connect-src *; 
                img-src * data: blob: android-webview-video-poster:; style-src * 'unsafe-inline';">
             </head>
             <body>
                <iframe 
                src="https://player.vimeo.com/video/$videoId?title=false&controls=false" 
                width="100%" height="100%" frameborder="0" allow="fullscreen" 
                allowfullscreen></iframe>
                <script src="https://player.vimeo.com/api/player.js"></script>
                <script>
                async function playVideo() {
                var iframe = document.querySelector('iframe');
                var player = new Vimeo.Player(iframe);
                console.log(player)
                await player.play();
               }
              </script>
             </body>
            </html>
            ''';
    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(html));
    return Uri.parse('data:text/html;base64,$contentBase64');
  }
}
