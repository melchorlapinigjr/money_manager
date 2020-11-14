import 'package:better_uuid/uuid.dart';

import './base_resource.dart';

class Transaction extends BaseResource {
  Transaction({
    this.id,
    this.name,
    this.description,
    this.date,
    this.amount,
    this.type,
    this.categoryID=0,
    Map<String, dynamic> json,
  }) : super(json);

  int id;
  String name;
  String description;
  DateTime date;
  double amount;
  String type;
  int categoryID;


  @override
  void fromJson(Map<String, dynamic> json) {
    id = (json['id'] as num).toInt();
    name = json['name'];
    description = json['description'] as String;
    date = DateTime.parse(json['date'] as String);
    amount = (json['amount'] as num)?.toDouble();
    type = json['type'];
    categoryID = (json['category_id'] as num)?.toInt();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['date'] = date;
    data['amount'] = amount;
    data['type'] = type;
    data['category_id'] = categoryID;
    return data;
  }

  Map<String, dynamic> toSembastMap() => <String, dynamic>{
    'id': id,
    'name' : name,
    'description' : description,
    'date' : date.toString(),
    'amount' : amount,
    'type' : type,
    'category_id' : categoryID,
  };

}

int generateUniqueID(){
  var id = Uuid.v1();
  return id.time;
}