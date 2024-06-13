import 'banner_navigation.dart';

class BannerData {
  int? bannerId;
  String? bannerTitle;
  String? bannerDescription;
  var bannerRefId;
  String? bannerStatus;
  BannerNavigation? bannerNavigation;
  String? gallary;
  int? language;



  BannerData(
      { this.bannerId,
        this.bannerTitle,
         this.bannerDescription,
         this.bannerRefId,
         this.bannerStatus,
         this.bannerNavigation,
         this.gallary,
         this.language});

  BannerData.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
    bannerTitle = json['banner_title'];
    bannerDescription = json['banner_description'];
    bannerRefId = json['banner_ref_id'];
    bannerStatus = json['banner_status'];
    bannerNavigation = (json['banner_navigation'] != null
        ? BannerNavigation.fromJson(json['banner_navigation'])
        : null);
    gallary = json['gallary'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['banner_id'] = bannerId;
    data['banner_title'] = bannerTitle;
    data['banner_description'] = bannerDescription;
    data['banner_ref_id'] = bannerRefId;
    data['banner_status'] = bannerStatus;
    if (bannerNavigation != null) {
      data['banner_navigation'] = bannerNavigation?.toJson();
    }
    data['gallary'] = gallary;
    data['language'] = language;
    return data;
  }
}