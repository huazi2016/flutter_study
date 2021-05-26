class AnswerBo {
  int code;
  String msg;
  List<AnswerInfoBo> data;
  int count;

  AnswerBo({this.code, this.msg, this.data, this.count});

  AnswerBo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<AnswerInfoBo>();
      json['data'].forEach((v) {
        data.add(new AnswerInfoBo.fromJson(v));
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

class AnswerInfoBo {
  int answerId;
  int questionId;
  String student;
  String anwser;
  String teacher;
  String reply;
  int score;
  String createTime;
  String updateTime;

  AnswerInfoBo(
      {this.answerId,
      this.questionId,
      this.student,
      this.anwser,
      this.teacher,
      this.reply,
      this.score,
      this.createTime,
      this.updateTime});

  AnswerInfoBo.fromJson(Map<String, dynamic> json) {
    answerId = json['answerId'];
    questionId = json['questionId'];
    student = json['student'];
    anwser = json['anwser'];
    teacher = json['teacher'];
    reply = json['reply'];
    score = json['score'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answerId'] = this.answerId;
    data['questionId'] = this.questionId;
    data['student'] = this.student;
    data['anwser'] = this.anwser;
    data['teacher'] = this.teacher;
    data['reply'] = this.reply;
    data['score'] = this.score;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    return data;
  }
}