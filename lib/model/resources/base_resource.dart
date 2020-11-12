abstract class BaseResource {
  BaseResource(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }
    fromJson(json);
  }

  void fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();

}
