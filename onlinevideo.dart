import 'package:video_player/video_player.dart';
import 'localvideo.dart';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

_pickVideoFileFrom(context) async {
  File videoFile = await FilePicker.getFile(type: FileType.video);
  if (videoFile == null) {
    print("Video Picked is null");
  }
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return VideoFile(
      file: videoFile,
    );
  }));
}

class VideoExample extends StatefulWidget {
  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<VideoExample> {
  VideoPlayerController playerController;

  VoidCallback listener;

  @override
  void initState() {
    super.initState();

    listener = () {
      setState(() {});
    };
  }

  void createVideo() {
    if (playerController == null) {
      playerController = VideoPlayerController.network(
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4')
        ..addListener(listener)
        ..setVolume(1.0)
        ..initialize()
        ..play();
    } else {
      if (playerController.value.isPlaying) {
        playerController.pause();
      } else {
        playerController.initialize();

        playerController.play();
      }
    }
  }

  @override
  void deactivate() {
    playerController.setVolume(0.0);

    playerController.removeListener(listener);

    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text(
              "Local Video Player",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                  decoration: TextDecoration.underline),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 30, 5, 30),
            child: RaisedButton(
              padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
              onPressed: () {
                _pickVideoFileFrom(context);

                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) {
                //   return MaterialApp(
                //     title: 'Flutter Demo',
                //     theme: ThemeData(
                //       primarySwatch: Colors.blue,
                //     ),
                //     home: HomePage(),
                //     debugShowCheckedModeBanner: false,
                //   );
                // }));
              },
              child: Text("Play Local Video"),
              color: Colors.teal,
              splashColor: Colors.tealAccent,
            ),
          ),
          Container(
            // margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text(
              "Online Video Player",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                  decoration: TextDecoration.underline),
            ),
          ),
          Center(
              child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    child: (playerController != null
                        ? VideoPlayer(
                            playerController,
                          )
                        : Container()),
                  ))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createVideo();

          playerController.play();
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
