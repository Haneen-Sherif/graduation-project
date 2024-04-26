class DiseaseResultModel {
  final String diseaseName;
  final String diseaseType;
  final String recommendationAction;
  final String diseaseImage;

  const DiseaseResultModel({
    required this.diseaseName,
    required this.diseaseType,
    required this.recommendationAction,
    required this.diseaseImage,
  });
}

class DetectResultModel {
  String? fishPhoto;
  String? ownerId;
  String? nameOfDisFromAiModel;
  double? score;
  int? diseaseId;
  Disease? disease;
  DateTime? dateTime;

  DetectResultModel({
    this.fishPhoto,
    this.ownerId,
    this.nameOfDisFromAiModel,
    this.score,
    this.diseaseId,
    this.disease,
    this.dateTime,
  });

  factory DetectResultModel.fromJson(Map<String, dynamic> json) {
    return DetectResultModel(
      fishPhoto: json['fishPhoto'],
      ownerId: json['ownerId'],
      nameOfDisFromAiModel: json['nameOfDisFromAiModel'],
      score: json['score']?.toDouble(), // Convert 'score' to double if present
      diseaseId: json['diseaseId'],
      disease:
          json['disease'] != null ? Disease.fromJson(json['disease']) : null,
      dateTime:
          json['dateTime'] != null ? DateTime.parse(json['dateTime']) : null,
    );
  }

  static List<DetectResultModel> detectFromSnapShot(List detectSnapShot) {
    return detectSnapShot.map((data) {
      return DetectResultModel.fromJson(data);
    }).toList();
  }
}

class Disease {
  int? id;
  String? photoPath;
  String? name;
  String? type;
  String? description;
  List<String>? recommandationActions;
  List<String>? causativeAgents;
  List<String>? clinicalSigns;
  List<String>? diagnosis;
  List<String>? treatment;
  List<String>? preventionAndControlls;
  List<String>? impactOnAquacultures;

  Disease({
    this.id,
    this.photoPath,
    this.name,
    this.type,
    this.description,
    this.recommandationActions,
    this.causativeAgents,
    this.clinicalSigns,
    this.diagnosis,
    this.treatment,
    this.preventionAndControlls,
    this.impactOnAquacultures,
  });

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      id: json['id'],
      photoPath: json['photoPath'],
      name: json['name'],
      type: json['type'],
      description: json['description'],
      recommandationActions: json['recommandationActions'] != null
          ? List<String>.from(json['recommandationActions'])
          : [],
      causativeAgents: json['causativeAgents'] != null
          ? List<String>.from(json['causativeAgents'])
          : [],
      clinicalSigns: json['clinicalSigns'] != null
          ? List<String>.from(json['clinicalSigns'])
          : [],
      diagnosis:
          json['diagnosis'] != null ? List<String>.from(json['diagnosis']) : [],
      treatment:
          json['treatment'] != null ? List<String>.from(json['treatment']) : [],
      preventionAndControlls: json['preventionAndControlls'] != null
          ? List<String>.from(json['preventionAndControlls'])
          : [],
      impactOnAquacultures: json['impactOnAquacultures'] != null
          ? List<String>.from(json['impactOnAquacultures'])
          : [],
    );
  }
  static List<Disease> diseaseFromSnapShot(List diseaseSnapShot) {
    return diseaseSnapShot.map((data) {
      return Disease.fromJson(data);
    }).toList();
  }
}
