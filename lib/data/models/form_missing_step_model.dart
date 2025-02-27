class FormMissingStepModel {
  List<String>? missingStep;

  FormMissingStepModel({this.missingStep});

  FormMissingStepModel.fromJson(Map<String, dynamic> json) {
    missingStep = json['missing_step'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['missing_step'] = missingStep;
    return data;
  }
}
