class BundleFeature {
  final int id;
  final String feature;
  final int maintenancePackageFeatureId;

  BundleFeature({
    required this.id,
    required this.feature,
    required this.maintenancePackageFeatureId,
  });

  factory BundleFeature.fromJson(
    Map<String, dynamic> json,
  ) {
    return BundleFeature(
      id: json['id'],
      feature: json['feature'],
      maintenancePackageFeatureId: json['maintenance_package_feature_id'],
    );
  }
}
