import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'new_post.g.dart';

NewPost newPostFromJson(String str) => NewPost.fromJson(json.decode(str));
String newPostToJson(NewPost data) => json.encode(data.toJson());

@JsonSerializable()
class NewPost {
  @JsonKey(name: "title")
  String title;
  //VoteOptionList []string `json:"vote_option_list"`
  @JsonKey(name: "vote_option_list")
  List<String?> voteOptionList;
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
  List<String> imageList;
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

  NewPost({
    this.title = '',
    this.voteOptionList = const [],
    //todo:  this.voteOptionList, 对应的换成：List<String>? voteOptionList;,可调用add方法
    this.color = '0xffffffff',
    this.content = '',
    this.subjectId = 0,
    this.startTime = 0,
    this.endTime = 0,
    this.imageList = const [],
    this.posterUrl = '',
    this.videoUrl = '',
    this.voiceUrl = '',
    this.musicUrl = '',
    this.atUserList = const [],
    this.type = '',
    this.subType = '',
  });
  factory NewPost.fromJson(Map<String, dynamic> json) =>
      _$NewPostFromJson(json);
  Map<String, dynamic> toJson() => _$NewPostToJson(this);
}
