class NewMsg {
  int toUserId;
  int fromUserId;
  int groupId;
  String content;
  String contentType;
  String poster;
  String url;
  NewMsg({
    this.toUserId = 0,
    this.fromUserId = 0,
    this.groupId = 0,
    this.content = '',
    this.contentType = '',
    this.poster = '',
    this.url = '',
  });

  Map<String, dynamic> toJson() => {
        "to_user_id": toUserId,
        "from_user_id": fromUserId,
        "group_id": groupId,
        "content": content,
        "content_type": contentType,
        "poster": poster,
        "url": url,
      };
}
