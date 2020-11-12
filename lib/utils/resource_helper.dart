

import 'package:money_manager/model/resource_definition.dart';
import 'package:money_manager/model/resources/transaction.dart';

class ResourceHelper {
  static final List<ResourceDefinition> _resources = <ResourceDefinition>[
    ResourceDefinition(
      type: Transaction,
      builder: (Map<String, dynamic> json) => Transaction(json: json),
    ),
  ];

  static ResourceDefinition get<T>() => _resources
      .singleWhere((ResourceDefinition resource) => resource.type == T);

  dynamic preventLintError;
}
