
// class Warehouse {
//   final int id;
//   final String code;
//   final String name;
//   final String address;
//   final String phone;
//   final String email;
//   final int countryId;
//   final int stateId;
//   final double latitude;
//   final double longitude;
//   final String status;
//   final int isDefault;
//   final int createdBy;
//   final int updatedBy;
//   final DateTime? deletedAt;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   Warehouse({
//     required this.id,
//     required this.code,
//     required this.name,
//     required this.address,
//     required this.phone,
//     required this.email,
//     required this.countryId,
//     required this.stateId,
//     required this.latitude,
//     required this.longitude,
//     required this.status,
//     required this.isDefault,
//     required this.createdBy,
//     required this.updatedBy,
//     required this.deletedAt,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory Warehouse.fromJson(Map<String, dynamic> json) {
//     return Warehouse(
//       id: json['id'],
//       code: json['code'],
//       name: json['name'],
//       address: json['address'],
//       phone: json['phone'],
//       email: json['email'],
//       countryId: json['country_id'],
//       stateId: json['state_id'],
//       latitude: json['latitude'],
//       longitude: json['longitude'],
//       status: json['status'],
//       isDefault: json['is_default'],
//       createdBy: json['created_by'],
//       updatedBy: json['updated_by'],
//       deletedAt: json['deleted_at'] != null
//           ? DateTime.parse(json['deleted_at'])
//           : null,
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }
// }




class Tax {
  final int id;
  final int taxId;
  final int stateId;
  final int countryId;
  final int taxRate;
  final String? description;
  final int createdBy;
  final int updatedBy;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Tax({
    required this.id,
    required this.taxId,
    required this.stateId,
    required this.countryId,
    required this.taxRate,
    required this.description,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Tax.fromJson(Map<String, dynamic> json) {
    return Tax(
      id: json['id'],
      taxId: json['tax_id'],
      stateId: json['state_id'],
      countryId: json['country_id'],
      taxRate: json['tax_rate'],
      description: json['description'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Warehouse{
  final int warehouseId;
  final String warehouseCode;
  final String warehouseName;
  final String warehouseAddress;
  final String warehousePhone;
  final String warehouseEmail;
  final String warehouseStatus;
  final int warehouseStateId;
  final int warehouseCountryId;
  final List<Tax> warehouseTax;
  final String warehouseCountry1;
  final String warehouseState1;

  Warehouse({
    required this.warehouseId,
    required this.warehouseCode,
    required this.warehouseName,
    required this.warehouseAddress,
    required this.warehousePhone,
    required this.warehouseEmail,
    required this.warehouseStatus,
    required this.warehouseStateId,
    required this.warehouseCountryId,
    required this.warehouseTax,
    required this.warehouseCountry1,
    required this.warehouseState1,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    List<dynamic> taxList = json['warehouse_tax'];
    List<Tax> warehouseTax = taxList.map((taxData) => Tax.fromJson(taxData)).toList();
    return Warehouse(
      warehouseId: json['warehouse_id'],
      warehouseCode: json['warehouse_code'],
      warehouseName: json['warehouse_name'],
      warehouseAddress: json['warehouse_address'],
      warehousePhone: json['warehouse_phone'],
      warehouseEmail: json['warehouse_email'],
      warehouseStatus: json['warehouse_status'],
      warehouseStateId: json['warehouse_state_id'],
      warehouseCountryId: json['warehouse_country_id'],
      warehouseTax: warehouseTax,
      warehouseCountry1: json['warehouse_country1'],
      warehouseState1: json['warehouse_state1'],
    );
  }
}