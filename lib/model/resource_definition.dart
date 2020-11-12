import 'package:flutter/material.dart';

class ResourceDefinition {
  ResourceDefinition({
    @required this.type,
    @required this.builder,
  });
  
  Type type;
  Function builder;
}
