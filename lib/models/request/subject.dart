class NewSubject {
  String name;
  String keywords;
  String summary;
  String reason;
  String coverUrlList;
  NewSubject({
    this.name = '',
    this.keywords = '',
    this.summary = '',
    this.reason = '',
    this.coverUrlList = '',
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "keywords": keywords,
        "summary": summary,
        "reason": reason,
        "cover_url_list": coverUrlList,
      };
}
