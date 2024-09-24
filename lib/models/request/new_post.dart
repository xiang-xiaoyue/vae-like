import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:trump/models/resp/models/post.dart';

part 'new_post.g.dart';

NewPost newPostFromJson(String str) => NewPost.fromJson(json.decode(str));
String newPostToJson(NewPost data) => json.encode(data.toJson());

@JsonSerializable()
class NewPost {
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "vote_option_list")
  List<String> voteOptionList;
  @JsonKey(name: "color")
  String color;
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "subject_id")
  int subjectId;
  @JsonKey(name: "start_time")
  int startTime;
  @JsonKey(name: "end_time")
  int endTime;
  @JsonKey(name: "image_list")
  List<String>? imageList;
  @JsonKey(name: "poster_url")
  String posterUrl;
  @JsonKey(name: "video_url")
  String videoUrl;
  @JsonKey(name: "voice_url")
  String voiceUrl;
  @JsonKey(name: "music_url")
  String musicUrl;
  @JsonKey(name: "at_user_list")
  List<String> atUserList;
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "sub_type")
  String subType;
  @JsonKey(name: "id")
  int id;

  NewPost({
    this.title = '',
    this.id = 0,
    this.status = "normal",
    //this.voteOptionList=['',''],
    //todo:  this.voteOptionList, 对应的换成：List<String>? voteOptionList;,可调用add方法
    // 如果要初始两个空的，就在class():冒号后面初始化，如下:
    // 这样在用的时候就不用if(vm.np.voteOptionList!=null) 了
    this.color = '0xffffffff',
    this.content = '',
    this.subjectId = 0,
    this.startTime = 0,
    this.endTime = 0,
    //note: const []在上面对应的是List<String> imageList,这样用了const之后就不能用add方法。
    //this.imageList = const [],
    this.imageList,
    this.posterUrl = '',
    this.videoUrl = '',
    this.voiceUrl = '',
    this.musicUrl = '',
    this.atUserList = const [],
    this.type = '',
    this.subType = '',
  }) : voteOptionList = ['', ''];
  factory NewPost.fromJson(Map<String, dynamic> json) =>
      _$NewPostFromJson(json);
  Map<String, dynamic> toJson() => _$NewPostToJson(this);

  void fromPost(Post p) {
    id = p.id;
    title = p.title;
    status = p.status;
    voteOptionList = p.voteResult != null
        ? p.voteResult!.map((i) => i.content).toList()
        : [];
    color = p.color;
    content = p.content;
    subjectId = p.subject.id;
    startTime = p.startTime;
    endTime = p.endTime;
    imageList = p.imageList;
    posterUrl = p.posterUrl;
    videoUrl = p.videoUrl;
    voiceUrl = p.voiceUrl;
    musicUrl = p.musicUrl;
    atUserList = p.atUserList.map((i) => i.toString()).toList();
    type = p.type;
    subType = p.subType;
  }
}
