class ExpensesUser {
  final String uid;
  ExpensesUser({this.uid});
}

class ExpensesData {
  final String payment;
  final String price;
  final String createdAt;

  ExpensesData({this.payment, this.price, this.createdAt});
}
