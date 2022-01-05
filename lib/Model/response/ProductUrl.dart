import 'dart:convert';

ProductUrl productUrlFromJson(String str) => ProductUrl.fromJson(json.decode(str));

String productUrlToJson(ProductUrl data) => json.encode(data.toJson());

class ProductUrl {
    ProductUrl({
        required this.code,
        required this.success,
        required this.data,
        required this.message,
    });

    int code;
    bool success;
    Data data;
    String message;

    factory ProductUrl.fromJson(Map<String, dynamic> json) => ProductUrl(
        code: json["code"],
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": data.toJson(),
        "message": message,
    };
}

class Data {
    Data({
        required this.url,
    });

    String url;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}
