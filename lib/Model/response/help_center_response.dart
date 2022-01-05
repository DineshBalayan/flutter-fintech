//     final data = dataFromJson(jsonString);

import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Faq faq;
  Training training;
  Marketing marketing;

  Data({
    required this.faq,
    required this.training,
    required this.marketing,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        faq: Faq.fromJson(json["FAQ"]),
        training: Training.fromJson(json["training"]),
        marketing: Marketing.fromJson(json["marketing"]),
      );

  Map<String, dynamic> toJson() => {
        "FAQ": faq.toJson(),
        "training": training.toJson(),
        "marketing": marketing.toJson(),
      };
}

class Faq {
  List<Lead> payout;
  List<Lead> leads;
  List<Lead> referrals;

  Faq({
    required this.payout,
    required this.leads,
    required this.referrals,
  });

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
        payout: List<Lead>.from(json["payout"].map((x) => Lead.fromJson(x))),
        leads: List<Lead>.from(json["leads"].map((x) => Lead.fromJson(x))),
        referrals: List<Lead>.from(json["referrals"].map((x) => Lead.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payout": List<dynamic>.from(payout.map((x) => x.toJson())),
        "leads": List<dynamic>.from(leads.map((x) => x.toJson())),
        "referrals": List<dynamic>.from(referrals.map((x) => x.toJson())),
      };
}

class Lead {
  String question;
  String answer;
  String videoUrl;

  Lead({
    required this.question,
    required this.answer,
    required this.videoUrl,
  });

  factory Lead.fromJson(Map<String, dynamic> json) => Lead(
        question: json["question"],
        answer: json["answer"],
        videoUrl: json["video_url"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
        "video_url": videoUrl,
      };
}

class Marketing {
  List<Account> savingAccount;
  List<Account> dmatAccount;

  Marketing({
    required this.savingAccount,
    required this.dmatAccount,
  });

  factory Marketing.fromJson(Map<String, dynamic> json) => Marketing(
        savingAccount: List<Account>.from(
            json["saving_account"].map((x) => Account.fromJson(x))),
        dmatAccount: List<Account>.from(
            json["dmat_account"].map((x) => Account.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "saving_account":
            List<dynamic>.from(savingAccount.map((x) => x.toJson())),
        "dmat_account": List<dynamic>.from(dmatAccount.map((x) => x.toJson())),
      };
}

class Account {
  String videoUrl;
  String title;

  Account({
    required this.videoUrl,
    required this.title,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        videoUrl: json["video_url"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "video_url": videoUrl,
        "title": title,
      };
}

class Training {
  String newProduct;
  List<String> freqWatched;
  List<DmatTraining> dmatTraining;
  List<DmatTraining> savingAccount;

  Training({
    required this.newProduct,
    required this.freqWatched,
    required this.dmatTraining,
    required this.savingAccount,
  });

  factory Training.fromJson(Map<String, dynamic> json) => Training(
        newProduct: json["new_product"],
        freqWatched: List<String>.from(json["freq_watched"].map((x) => x)),
        dmatTraining: List<DmatTraining>.from(
            json["dmat_training"].map((x) => DmatTraining.fromJson(x))),
        savingAccount: List<DmatTraining>.from(
            json["saving_account"].map((x) => DmatTraining.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "new_product": newProduct,
        "freq_watched": List<dynamic>.from(freqWatched.map((x) => x)),
        "dmat_training":
            List<dynamic>.from(dmatTraining.map((x) => x.toJson())),
        "saving_account":
            List<dynamic>.from(savingAccount.map((x) => x.toJson())),
      };
}

class DmatTraining {
  String videoUrl;
  String title;
  String description;

  DmatTraining({
    required this.videoUrl,
    required this.title,
    required this.description,
  });

  factory DmatTraining.fromJson(Map<String, dynamic> json) => DmatTraining(
        videoUrl: json["video_url"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "video_url": videoUrl,
        "title": title,
        "description": description,
      };
}
