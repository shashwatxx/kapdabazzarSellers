class Seller {
  final String sellerId;
  final String email;
  final String sellerName;
  final String address;
  final String accHolderName;
  final String accNumber;
  final String gstin;
  final String shopName;
  final String ifsc;

  final String phone;
  final String password;
  final bool reviewed;

  Seller(
      {this.sellerId,
      this.email,
      this.password,
      this.sellerName,
      this.phone,
      this.reviewed,
      this.gstin,
      this.shopName,
      this.ifsc,
      this.accNumber,
      this.accHolderName,
      this.address});
}
