class GatewayTransaction {

  static const String SUCCESSFUL = "SUCCESSFUL";
  static const String FAILED = "FAILED";
  static const String PENDING = "PENDING";
  static const String INITIATED = "INITIATED";

  String? gatewayOperatorCode;
  String? gatewayCode;
  int? amount;
  String? currencyCode;
  String? recipientNumber;
  String? status;
  String? gatewayTransId;
  double? fees;
  String? paymentUrl;
  String? merchantTransId;
  bool? isPayin;
  String? requestMetadata;
  String? responseMetadata;
  int? responseStatusCode;
  bool? isWaiting;
  bool? isCompleted;
  int? merchantId;
  String? updatedAt;
  String? createdAt;
  int? id;

  GatewayTransaction(
      { this.gatewayOperatorCode,
        this.gatewayCode,
        this.amount,
        this.currencyCode,
        this.recipientNumber,
        this.status,
        this.paymentUrl,
        this.gatewayTransId,
        this.fees,
        this.merchantTransId,
        this.isPayin,
        this.requestMetadata,
        this.responseMetadata,
        this.responseStatusCode,
        this.isWaiting,
        this.isCompleted,
        this.merchantId,
        this.updatedAt,
        this.createdAt,
        this.id});

  GatewayTransaction.fromJson(Map<String, dynamic> json) {
    gatewayOperatorCode = json['gateway_operator_code'];
    gatewayCode = json['gateway_code'];
    amount = json['amount'];
    currencyCode = json['currency_code'];
    recipientNumber = json['recipient_number'];
    status = json['status'];
    paymentUrl = json['payment_url'];
    gatewayTransId = json['gateway_trans_id'];
    fees = json['fees'];
    merchantTransId = json['merchant_trans_id'];
    isPayin = json['is_payin'];
    requestMetadata = json['request_metadata'];
    responseMetadata = json['response_metadata'];
    responseStatusCode = json['response_status_code'];
    isWaiting = json['is_waiting'];
    isCompleted = json['is_completed'];
    merchantId = json['merchant_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gateway_operator_code'] = gatewayOperatorCode;
    data['gateway_code'] = gatewayCode;
    data['amount'] = amount;
    data['currency_code'] = currencyCode;
    data['recipient_number'] = recipientNumber;
    data['status'] = status;
    data['payment_url'] = paymentUrl;
    data['gateway_trans_id'] = gatewayTransId;
    data['fees'] = fees;
    data['merchant_trans_id'] = merchantTransId;
    data['is_payin'] = isPayin;
    data['request_metadata'] = requestMetadata;
    data['response_metadata'] = responseMetadata;
    data['response_status_code'] = responseStatusCode;
    data['is_waiting'] = isWaiting;
    data['is_completed'] = isCompleted;
    data['merchant_id'] = merchantId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}

