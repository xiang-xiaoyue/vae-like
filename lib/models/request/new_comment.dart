class NewComment {
  String content;
  String picUrl;
  String voiceUrl;
  int postId;
  int parentId;
  int topId;

  NewComment({
    this.content = '',
    this.picUrl = '',
    this.voiceUrl = '',
    this.postId = 0,
    this.parentId = 0,
    this.topId = 0,
  });

  Map<String, dynamic> toJson() => {
        "content": content,
        "pic_url": picUrl,
        "voice_url": voiceUrl,
        "post_id": postId,
        "parent_id": parentId,
        "top_id": topId,
      };
}
