enum PaymentEnum {
  none,
  cashInHand,
  online,
}

extension PaymentExtension on PaymentEnum {
  String get name {
    switch (this) {
      case PaymentEnum.none:
        return "Pending";

      case PaymentEnum.cashInHand:
        return "Cash In Hand";

      case PaymentEnum.online:
        return "Online Payment";
    }
  }
}
