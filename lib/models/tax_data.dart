
class TaxRateData {
  int taxRateId;
  int taxId;
  int taxStateId;
  int taxCountryId;
  int taxAmount;
  String taxAmountSymbol;
  Currency currency;
  dynamic taxDescription;
  Tax tax;

  TaxRateData({
    required this.taxRateId,
    required this.taxId,
    required this.taxStateId,
    required this.taxCountryId,
    required this.taxAmount,
    required this.taxAmountSymbol,
    required this.currency,
    required this.taxDescription,
    required this.tax,
  });

  factory TaxRateData.fromJson(Map<String, dynamic> json) => TaxRateData(
    taxRateId: json["tax_rate_id"],
    taxId: json["tax_id"],
    taxStateId: json["tax_state_id"],
    taxCountryId: json["tax_country_id"],
    taxAmount: json["tax_amount"],
    taxAmountSymbol: json["tax_amount_symbol"],
    currency: Currency.fromJson(json["currency"]),
    taxDescription: json["tax_description"],
    tax: Tax.fromJson(json["tax"]),
  );

  Map<String, dynamic> toJson() => {
    "tax_rate_id": taxRateId,
    "tax_id": taxId,
    "tax_state_id": taxStateId,
    "tax_country_id": taxCountryId,
    "tax_amount": taxAmount,
    "tax_amount_symbol": taxAmountSymbol,
    "currency": currency.toJson(),
    "tax_description": taxDescription,
    "tax": tax.toJson(),
  };
}

class Currency {
  int exchangeRate;
  String symbolPosition;
  String code;

  Currency({
    required this.exchangeRate,
    required this.symbolPosition,
    required this.code,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    exchangeRate: json["exchange_rate"],
    symbolPosition: json["symbol_position"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "exchange_rate": exchangeRate,
    "symbol_position": symbolPosition,
    "code": code,
  };
}

class Tax {
  int taxId;
  String taxTitle;
  String taxDescription;
  TaxRate taxRate;

  Tax({
    required this.taxId,
    required this.taxTitle,
    required this.taxDescription,
    required this.taxRate,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
    taxId: json["tax_id"],
    taxTitle: json["tax_title"],
    taxDescription: json["tax_description"],
    taxRate: TaxRate.fromJson(json["tax_rate"]),
  );

  Map<String, dynamic> toJson() => {
    "tax_id": taxId,
    "tax_title": taxTitle,
    "tax_description": taxDescription,
    "tax_rate": taxRate.toJson(),
  };
}

class TaxRate {
  int taxRateId;
  int taxId;
  int taxStateId;
  int taxCountryId;
  int taxAmount;
  String taxAmountSymbol;
  Currency currency;
  dynamic taxDescription;

  TaxRate({
    required this.taxRateId,
    required this.taxId,
    required this.taxStateId,
    required this.taxCountryId,
    required this.taxAmount,
    required this.taxAmountSymbol,
    required this.currency,
    required this.taxDescription,
  });

  factory TaxRate.fromJson(Map<String, dynamic> json) => TaxRate(
    taxRateId: json["tax_rate_id"],
    taxId: json["tax_id"],
    taxStateId: json["tax_state_id"],
    taxCountryId: json["tax_country_id"],
    taxAmount: json["tax_amount"],
    taxAmountSymbol: json["tax_amount_symbol"],
    currency: Currency.fromJson(json["currency"]),
    taxDescription: json["tax_description"],
  );

  Map<String, dynamic> toJson() => {
    "tax_rate_id": taxRateId,
    "tax_id": taxId,
    "tax_state_id": taxStateId,
    "tax_country_id": taxCountryId,
    "tax_amount": taxAmount,
    "tax_amount_symbol": taxAmountSymbol,
    "currency": currency.toJson(),
    "tax_description": taxDescription,
  };
}

