class RegisterBo {
  int code;
  String msg;
  Null data;
  int count;

  RegisterBo({this.code, this.msg, this.data, this.count});

  RegisterBo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['data'] = this.data;
    data['count'] = this.count;
    return data;
  }
}
