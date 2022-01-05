// @dart=2.10
class OcrResponse {
  int blocks;
  int code;
  String text;

  OcrResponse({this.blocks, this.code, this.text});

  factory OcrResponse.fromJson(Map<String, dynamic> json) {
    return OcrResponse(
      blocks: json['blocks'],
      code: json['code'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blocks'] = this.blocks;
    data['code'] = this.code;
    data['text'] = this.text;
    return data;
  }
}