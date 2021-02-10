import 'package:winch_app/shared_prefrences/winch_user_model.dart';

class CityItem {
  int id;
  String city;

  CityItem(this.id, this.city);
  static List<CityItem> getCompanies() {
    String lang = 'en';
    return <CityItem>[
      CityItem(1, lang == 'en' ? 'Select city' : 'اختر المحافظه'),
      CityItem(2, lang == 'en' ? 'Cairo' : 'القاهره'),
      CityItem(3, lang == 'en' ? 'Alex' : 'الاسكندريه'),
      CityItem(4, lang == 'en' ? 'Giza' : 'الجيزه'),
      CityItem(5, lang == 'en' ? 'Tanta' : 'طنطا'),
    ];
  }
}
