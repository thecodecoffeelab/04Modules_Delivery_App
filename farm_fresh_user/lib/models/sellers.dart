class Sellers
{
  String? sellerUID;
  String? sellerName;
  String? sellerAvatarUrl;
  String? sellerEmail;
  String? phone;

  Sellers({
    this.sellerUID,
    this.sellerName,
    this.sellerAvatarUrl,
    this.sellerEmail,
    this.phone,
  });

  Sellers.fromJson(Map<String, dynamic> json)
  {
    sellerUID = json["sellerUID"];
    sellerName = json["sellerName"];
    sellerAvatarUrl = json["sellerAvatarUrl"];
    sellerEmail = json["sellerEmail"];
    phone = json["phone"];
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["sellerUID"] = sellerUID;
    data["sellerName"] = sellerName;
    data["sellerAvatarUrl"] = sellerAvatarUrl;
    data["sellerEmail"] = sellerEmail;
    data["phone"] = phone;
    return data;
  }
}