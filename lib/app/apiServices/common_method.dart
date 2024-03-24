
import 'package:shopperz/model/signIn_model.dart';
import 'package:shopperz/utils/api_list.dart';

setUserData(List<Customer> customers) {
  for(int i=0; i<customers.length;i++){
    Customer obj = customers[i];
    AppConstants.customerId = obj.customerId;
    AppConstants. userName = obj.userName;
    AppConstants. emailId = obj.emailId;
  }

}