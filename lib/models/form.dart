// FeedbackForm is a data class which stores data fields of Feedback.
class AppForm {
  String companyName;
  String name;
  String mobile1;
  String mobile2;
  String email1;
  String email2;
  String website;
  String address;
  String pinCode;
  String city;
  String state;
  String country;
  String entryBy;
  String referenceBy;
  String remarks;
  //String type;
  //List type;
  //String typeControllerResult;
  String date;

  AppForm(
      this.companyName,
      this.name,
      this.mobile1,
      this.mobile2,
      this.email1,
      this.email2,
      this.website,
      this.address,
      this.pinCode,
      this.city,
      this.state,
      this.country,
      this.entryBy,
      this.referenceBy,
      this.remarks,
      //this.type,
      this.date);

  factory AppForm.fromJson(dynamic json) {
    return AppForm(
        "${json['companyName']}",
        "${json['name']}",
        "${json['mobile1']}",
        "${json['mobile2']}",
        "${json['email1']}",
        "${json['email2']}",
        "${json['website']}",
        "${json['address']}",
        "${json['pinCode']}",
        "${json['city']}",
        "${json['state']}",
        "${json['country']}",
        "${json['entryBy']}",
        "${json['referenceBy']}",
        "${json['remarks']}",
        //"${json['type']}",
        "${json['date']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'companyName': companyName,
        'name': name,
        'mobile1': mobile1,
        'mobile2': mobile2,
        'email1': email1,
        'email2': email2,
        'website': website,
        'address': address,
        'pinCode': pinCode,
        'city': city,
        'state': state,
        'country': country,
        'entryBy': entryBy,
        'referenceBy': referenceBy,
        'remarks': remarks,
        //'type': type,
        'date': date,
      };
}
