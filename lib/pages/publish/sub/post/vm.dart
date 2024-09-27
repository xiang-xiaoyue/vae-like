import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/request/new_post.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/subject.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/service/api.dart';
import 'package:trump/util/color.dart';

//note: 在NewPost里，options是const[],atUsrList也是const[],所以无法直接add,remove,
// 这里另外声明列表，最后赋值过去
class CreatePostViewModel with ChangeNotifier {
  CreatePostViewModel(String subType, Post? currentEdittingThread) {
    print("当前帖子：${currentEdittingThread?.content}");
    if (currentEdittingThread != null) {
      newPostFromPost(currentEdittingThread);
    } else {
      np.type = Constants.postTypeThread;
      np.subType = subType;
    }
    notifyListeners();
  }

  //todo: getPostId有可能得到null

  // 从草稿箱跳来之前，当前编辑的帖子信息保存在了currentUserViewModel中
  void newPostFromPost(Post p) {
    np.fromPost(p);
    // 强行转成“帖子”
    np.type = Constants.postTypeThread;
    print("np信息：${np.id}");
    notifyListeners();
  }

  NewPost np = NewPost();
  List<User> atUserList = [];
  int voiceDurationSeconds = 0;
  int voicePositionSeconds = 0;

  void notify() {
    notifyListeners();
  }

  void setShortTextBackgroundColor(Color color) {
    np.color = color2String(color);
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

  // 增加图文中的图片
  void addImage(String url) {
    np.imageList ??= [];
    np.imageList!.add(url);
    print("保存图片：$url---${np.imageList}");
    notifyListeners();
  }

  // 从图片列表中移除
  void removeImage(String url) {
    np.imageList?.remove(url);
    notifyListeners();
  }

  // 发布帖子
  Future<int> publish({String status = "normal"}) async {
    np.atUserList = atUserList.map((i) => i.id.toString()).toList();
    np.status = status;
    print("这是保存草稿时的选项：${np.voteOptionList.length}");
    Post post = await Api.instance.createPost(np);
    notifyListeners();
    return post.id;
  }

  // 增加投票的选项
  addVoteOption() {
    np.voteOptionList.add('');
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
    notifyListeners();
  }

  // 去掉@的人
  void removeAtUser(User user) {
    atUserList.remove(user);
    notifyListeners();
  }

  // 减少投票的选项
  removeVoteOption(String option) {
    np.voteOptionList.remove(option);
    notifyListeners();
  }

  // 修改选项投票选项内容
  updateVoteOption(String oldValue, String newValue) {
    int index = np.voteOptionList.indexOf(oldValue);
    np.voteOptionList[index] = newValue;
    notifyListeners();
  }
}
