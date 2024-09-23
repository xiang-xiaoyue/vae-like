import 'dart:io';

import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:trump/components/post/sections.dart';
import 'package:trump/pages/publish/sub/post/conponents/content_input.dart';
import 'package:trump/pages/publish/sub/post/vm.dart';
import 'package:trump/util/util.dart';

// 录制语音，录制完成后点击“完成”，跳到编辑页面编辑文字。
class NewPostVoiceMain extends StatefulWidget {
  const NewPostVoiceMain({super.key});

  @override
  State<NewPostVoiceMain> createState() => _NewPostVoiceMainState();
}

class _NewPostVoiceMainState extends State<NewPostVoiceMain> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CreatePostViewModel>(builder: (context, vm, _) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        child: Column(
          children: [
            NewPostTextarea(
                onChange: (v) => vm.np.content = v.trim(), hideCounter: true),
            (vm.np.voiceUrl != "")
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: PostVoicePlayerSection(
                      url: vm.np.voiceUrl,
                      setDurationSeconds: (i) {
                        vm.setVoicePositionSeconds(i);
                      },
                      resetUrl: (u) {
                        vm.setVoiceUrl(u);
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: VoiceRecordCard(),
                  )
          ],
        ),
      );
    });
  }
}

// 录音
class VoiceRecordCard extends StatefulWidget {
  const VoiceRecordCard({super.key});

  @override
  State<VoiceRecordCard> createState() => _VoiceRecordCardState();
}

class _VoiceRecordCardState extends State<VoiceRecordCard> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final AudioRecorder audioRecorder = AudioRecorder();

  bool isPlaying = false, isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Consumer<CreatePostViewModel>(builder: (context, vm, _) {
        return Row(
          children: [
            isRecording
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          String? filePath = await audioRecorder.stop();
                          if (filePath != null) {
                            setState(
                              () {
                                isRecording = false;
                                uploadSingleFile(filePath).then((url) {
                                  if (url.contains("http")) {
                                    vm.setVoiceUrl(url);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(url)));
                                  }
                                });
                              },
                            );
                          }
                        },
                        child: const CircleAvatar(
                          child: Icon(
                            Icons.stop,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      const Text("停止")
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (await audioRecorder.hasPermission()) {
                            final Directory appDocumentDir =
                                await getApplicationDocumentsDirectory();
                            final String filePath =
                                p.join(appDocumentDir.path, "tc.wav");
                            await audioRecorder.start(const RecordConfig(),
                                path: filePath);
                            setState(() {
                              isRecording = true;
                            });
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: const Icon(Icons.mic),
                        ),
                      ),
                      const Text("录音"),
                    ],
                  ),
          ],
        );
      }),
    );
  }
}
// Expanded(
//   child: Row(
//     mainAxisSize: MainAxisSize.max,
//     children: [
//       Expanded(
//         child: LinearProgressIndicator(
//           color: Colors.orange.shade300,
//           backgroundColor: Colors.grey.shade500,
//           value: vm.voicePositionSeconds /
//               vm.voiceDurationSeconds,
//           //value: 0.2,
//         ),
//       ),
//       const SizedBox(width: 12),
//       Text(
//           "${vm.voicePositionSeconds}/${vm.voiceDurationSeconds}"),
//     ],
//   ),
// ),
//const SizedBox(width: 12),
