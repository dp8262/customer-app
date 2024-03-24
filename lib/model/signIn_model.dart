class SignInModel {
  SignInModel({
    required this.customer,
  });
  late final List<Customer> customer;

  SignInModel.fromJson(Map<String, dynamic> json){
    customer = List.from(json['customer']).map((e)=>Customer.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['customer'] = customer.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Customer {
  Customer({
    required this.customerId,
    required this.userName,
     this.mobileNumber,
    required this.emailId,
    required this.password,
  });
  late final String customerId;
  late final String userName;
  late final String? mobileNumber;
  late final String emailId;
  late final String password;

  Customer.fromJson(Map<String, dynamic> json){
    customerId = json['customerId'];
    userName = json['UserName'];
    mobileNumber = json['MobileNumber'];
    emailId = json['emailId'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['customerId'] = customerId;
    _data['UserName'] = userName;
    _data['MobileNumber'] = mobileNumber;
    _data['emailId'] = emailId;
    _data['Password'] = password;
    return _data;
  }
}