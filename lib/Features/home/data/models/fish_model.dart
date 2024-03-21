class FishModel {
  final String image;
  final String title;
  final String description;
  final String causativeAgents;
  final String transmission;
  final String clinicalSigns;
  final String diagnosis;
  final String treatment;
  final String preventionAndControl;
  final String impactOnAquaculture;

  FishModel({
    required this.image,
    required this.title,
    required this.description,
    required this.causativeAgents,
    required this.transmission,
    required this.clinicalSigns,
    required this.diagnosis,
    required this.treatment,
    required this.preventionAndControl,
    required this.impactOnAquaculture,
  });
}

class DiseasesModel {
  int? id;
  String? photoPath;
  String? name;
  String? type;
  String? description;
  List<dynamic>? recommandationActions;
  List<dynamic>? causativeAgents;
  List<dynamic>? clinicalSigns;
  List<dynamic>? diagnosis;
  List<dynamic>? treatment;
  List<dynamic>? preventionAndControlls;
  List<dynamic>? impactOnAquacultures;

  DiseasesModel({
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

  DiseasesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photoPath = json['photoPath'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    recommandationActions = json['recommandationActions'].cast<String>();
    causativeAgents = json['causativeAgents'].cast<String>();
    clinicalSigns = json['clinicalSigns'].cast<String>();
    diagnosis = json['diagnosis'].cast<String>();
    treatment = json['treatment'].cast<String>();
    preventionAndControlls = json['preventionAndControlls'].cast<String>();
    impactOnAquacultures = json['impactOnAquacultures'].cast<String>();
  }

  static List<DiseasesModel> diseasesFromSnapShot(List diseasesSnapShot) {
    return diseasesSnapShot.map((data) {
      return DiseasesModel.fromJson(data);
    }).toList();
  }
}
