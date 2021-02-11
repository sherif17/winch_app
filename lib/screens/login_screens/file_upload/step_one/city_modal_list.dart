import 'package:winch_app/shared_prefrences/winch_user_model.dart';

class CityItem {
  int id;
  String city;
  static String lang;

  CityItem(this.id, this.city);
  static List<CityItem> getCompanies() {
    //tring lang = 'en';
    return <CityItem>[
      CityItem(1, lang == 'en' ? 'Select city' : 'اختر المحافظه'),
      CityItem(2, lang == 'en' ? 'Ain Sokhna' : 'السخنة'),
      CityItem(3, lang == 'en' ? 'Alexandria' : 'الإسكندرية'),
      CityItem(4, lang == 'en' ? 'Asyut' : 'اسيوط'),
      CityItem(5, lang == 'en' ? 'Banha' : 'بنها'),
      CityItem(6, lang == 'en' ? 'Beheira' : 'البحيرة'),
      CityItem(7, lang == 'en' ? ' Beni Suef' : 'بني سويف'),
      CityItem(8, lang == 'en' ? 'Damietta' : 'دمياط'),
      CityItem(9, lang == 'en' ? 'Faiyum' : 'الفيوم'),
      CityItem(10, lang == 'en' ? 'Hurghada' : 'الغردقة'),
      CityItem(11, lang == 'en' ? 'Ismailia' : 'الاسماعيلية'),
      CityItem(12, lang == 'en' ? 'Kafr El Sheikh' : ' كفر الشيخ'),
      CityItem(13, lang == 'en' ? 'Mansoura' : 'المنصورة'),
      CityItem(14, lang == 'en' ? 'Marsa Alam' : 'مرسى علم'),
      CityItem(15, lang == 'en' ? 'Matruh' : 'مطروح'),
      CityItem(16, lang == 'en' ? 'Minya' : 'المنيا'),
      CityItem(17, lang == 'en' ? 'Monufia' : 'المنوفية'),
      CityItem(18, lang == 'en' ? 'New Valley' : 'الوادي الجديد'),
      CityItem(19, lang == 'en' ? 'North Coast' : 'الساحل الشمالي'),
      CityItem(20, lang == 'en' ? 'North Sinai' : 'راس غارب'),
      CityItem(21, lang == 'en' ? 'Port Said' : 'بورسعيد'),
    ];
  }
}
