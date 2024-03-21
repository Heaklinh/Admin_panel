import 'dart:convert';

class MaintainToggle {
  final bool toggle;
  MaintainToggle({
    required this.toggle
  });
  
  Map<String, dynamic> toMap() {
    return {
      'toggle': toggle
    };
  }

  factory MaintainToggle.fromMap(Map<String, dynamic> map) {
    return MaintainToggle(
      toggle: map['toggle'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MaintainToggle.fromJson(String source) =>
      MaintainToggle.fromMap(json.decode(source));
}
