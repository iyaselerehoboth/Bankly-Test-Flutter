class Transactions {
  String trnAmount;
  String trnCounterPartyService;
  String trnDate;
  String trnCounterpartyBankCode;
  String trnContractReference;
  String trnPaymentReference;
  String trnCounterPartyReference;
  String logourl;
  String trnDrCr;
  String accountNumber;
  String accountName;
  String counterPartyAccountNumber;
  String counterPartyAccountName;
  String journalNarration;
  String trnCounterPartyBankName;
  String ftCounterPartySwitchCode;
  String trnNarration;
  String source;
  String bankCode;
  String branchCode;
  String maker;
  String checker;
  String bankName;
  String trnId;

  Transactions({
      required this.trnAmount,
      required this.trnCounterPartyService,
      required this.trnDate,
      required this.trnCounterpartyBankCode,
      required this.trnContractReference,
      required this.trnPaymentReference,
      required this.trnCounterPartyReference,
      required this.logourl,
      required this.trnDrCr,
      required this.accountNumber,
      required this.accountName,
      required this.counterPartyAccountNumber,
      required this.counterPartyAccountName,
      required this.journalNarration,
      required this.trnCounterPartyBankName,
      required this.ftCounterPartySwitchCode,
      required this.trnNarration,
      required this.source,
      required this.bankCode,
      required this.branchCode,
      required this.maker,
      required this.checker,
      required this.bankName,
      required this.trnId});

  factory Transactions.fromJson(Map<String, dynamic> json){

    return Transactions(
        trnAmount: json['trnAmount'],
        trnCounterPartyService: json['trnCounterPartyService'],
        trnDate: json['trnDate'],
        trnCounterpartyBankCode: json['trnCounterpartyBankCode'],
        trnContractReference: json['trnContractReference'],
        trnPaymentReference: json['trnPaymentReference'],
        trnCounterPartyReference: json['trnCounterPartyReference'],
        logourl: json['logourl'],
        trnDrCr: json['trnDrCr'],
        accountNumber: json['accountNumber'],
        accountName: json['accountName'],
        counterPartyAccountNumber: json['counterPartyAccountNumber'],
        counterPartyAccountName: json['counterPartyAccountName'],
        journalNarration: json['journalNarration'],
        trnCounterPartyBankName: json['trnCounterPartyBankName'],
        ftCounterPartySwitchCode: json['ftCounterPartySwitchCode'],
        trnNarration: json['trnNarration'],
        source: json['source'],
        bankCode: json['bankCode'],
        branchCode: json['branchCode'],
        maker: json['maker'],
        checker: json['checker'],
        bankName: json['bankName'],
        trnId: json['trnId'],
    );
  }
}
