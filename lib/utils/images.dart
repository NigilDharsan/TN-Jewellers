class Images {
  static const String logo = 'assets/logo/logo.svg';
  static const String logoPng = 'assets/logo/logo.png';

  static const String hello_axi_logo =
      'assets/images/hello_taxi_appicon_blue.png';
  static const String riderSearch = 'assets/images/riderSearch.gif';
  static const String customer_care = 'assets/images/customer_care.jpg';

  static String get backgroundImg => 'background_img'.png;
  static String get backgroundImg1 => 'background_img1'.png;
  static String get backgroundImgLogo => 'background_img_logo'.png;
  static String get backgroundImgLogo1 => 'background_img_logo1'.png;
  static String get user => 'user'.png;
  static String get banner => 'banner'.png;
  static String get product_ear_ring => 'product_ear_ring'.png;
  static String get rightArrow => 'right_arrow'.png;
  static String get splash => 'Splash'.png;

  static String get money => 'money'.png;
  static String get clock => 'clock'.png;
  static String get navigation => 'navi'.png;
  static String get carimage => 'carimage'.png;

  static String get update => 'update'.png;
  static String get maintenance => 'maintenance'.png;
  static String get cart => 'cart'.png;
  static String get guest => 'guest'.png;

  static String get notification => 'notification'.svg;
  static String get search => 'search'.png;

  static String get chat => 'chat'.svg;

  static String get cancel => 'cancel'.svg;

  static String get lock => 'lock'.svg;

  static String get theme => 'theme'.svg;

  static String get keyPng => 'key'.png;
  static String get accountCircle => 'account_circle'.svg;
}

extension on String {
  String get png => 'assets/images/$this.png';
  String get svg => 'assets/images/$this.svg';
}
