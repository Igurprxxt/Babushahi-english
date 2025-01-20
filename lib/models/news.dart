class News {
  String? id;
  String? title;
  String? headline;
  String? postedon;
  String? photo;
  String? cityvillage;
  String? reporterName;
  String? type;
  String? adUrl;
  String? pageUrl;
  String? category;

  News({
    this.id,
    this.title,
    this.headline,
    this.postedon,
    this.photo,
    this.cityvillage,
    this.reporterName,
    this.type,
    this.adUrl,
    this.pageUrl,
    this.category,
  });

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    headline = json['headline'];
    postedon = json['postedon'];
    photo = json['photo'];
    cityvillage = json['cityvillage'];
    reporterName = json['reporter_name'];
    type = json['type'];
    adUrl = json['ad_url'];
    pageUrl = json['page_url'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['headline'] = this.headline;
    data['postedon'] = this.postedon;
    data['photo'] = this.photo;
    data['cityvillage'] = this.cityvillage;
    data['reporter_name'] = this.reporterName;
    data['type'] = this.type;
    data['ad_url'] = this.adUrl;
    data['page_url'] = this.pageUrl;
    data['category'] = this.category;
    return data;
  }
}
