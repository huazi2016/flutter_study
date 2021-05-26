class SelfBo {
  int code;
  String msg;
  List<SelfInfoBo> data;
  int count;

  SelfBo({this.code, this.msg, this.data, this.count});

  SelfBo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<SelfInfoBo>();
      json['data'].forEach((v) {
        data.add(new SelfInfoBo.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class SelfInfoBo {
  int courseId;
  String type;
  String title;
  String content;
  String image;
  String video;
  String file;
  String teacher;
  String createTime;
  String updateTime;

  SelfInfoBo(
      {this.courseId,
      this.type,
      this.title,
      this.content,
      this.image,
      this.video,
      this.file,
      this.teacher,
      this.createTime,
      this.updateTime});

  SelfInfoBo.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    type = json['type'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    video = json['video']??'';
    file = json['file']??'';
    teacher = json['teacher'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseId'] = this.courseId;
    data['type'] = this.type;
    data['title'] = this.title;
    data['content'] = this.content;
    data['image'] = this.image;
    data['video'] = this.video;
    data['file'] = this.file;
    data['teacher'] = this.teacher;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    return data;
  }
}
