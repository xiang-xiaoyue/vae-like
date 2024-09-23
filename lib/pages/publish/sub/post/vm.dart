import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trump/models/request/new_post.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/subject.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/service/api.dart';
import 'package:trump/util/color.dart';

//note: 在NewPost里，options是const[],atUsrList也是const[],所以无法直接add,remove,
// 这里另外声明列表，最后赋值过去
class CreatePostViewModel with ChangeNotifier {
  NewPost np = NewPost();
  List<String> options = ['', ''];
  List<User> atUserList = [];
  int voiceDurationSeconds = 0;
  int voicePositionSeconds = 0;
  Color selectedColor = Colors.white; // 如果是短文，有背景色

  void notify() {
    notifyListeners();
  }

  void setSelectedColor(Color color) {
    selectedColor = color;
    notifyListeners();
  }

  void setVoicePositionSeconds(int total) {
    voiceDurationSeconds = total;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (voicePositionSeconds == voiceDurationSeconds) {
        timer.cancel();
      } else {
        voicePositionSeconds += 1;
        print("进度：${voicePositionSeconds / voiceDurationSeconds}");
        notifyListeners();
      }
    });
    notifyListeners();
  }

  void setVoiceUrl(String url) {
    np.voiceUrl = url;
    notifyListeners();
  }

  List<String> imgs = [];
  // 增加图文中的图片
  void addImage(String url) {
    imgs.add(url);
    notifyListeners();
  }

  // 从图片列表中移除
  void removeImage(String url) {
    imgs.remove(url);
    notifyListeners();
  }

  // 发布帖子
  Future<int> publish() async {
    np.voteOptionList = options;
    np.atUserList = atUserList.map((i) => i.id.toString()).toList();
    np.color = toColor(selectedColor);
    np.imageList = imgs;
    Post post = await Api.instance.createPost(np);
    notifyListeners();
    return post.id;
  }

  // 增加投票的选项
  addVoteOption() {
    options.add('');
    notifyListeners();
  }

  String selectedSubjectName = '';
  // 选中话题
  void selectSubject(Subject s) {
    np.subjectId = s.id;
    selectedSubjectName = s.name;
    notifyListeners();
  }

  // @别人
  void atUser(User user) {
    bool hasAted = atUserList.any((i) => i.id == user.id);
    if (hasAted == false) {
      atUserList.add(user);
    }
    print("选中的@人：${atUserList.length}");
    notifyListeners();
  }

  // 去掉@的人
  void removeAtUser(User user) {
    atUserList.remove(user);
    notifyListeners();
  }

  // 减少投票的选项
  removeVoteOption(String option) {
    options.remove(option);
    notifyListeners();
  }

  // 修改选项投票选项内容
  updateVoteOption(String oldValue, String newValue) {
    int index = options.indexOf(oldValue);
    options[index] = newValue;
    notifyListeners();
  }
}
