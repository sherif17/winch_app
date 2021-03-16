import 'package:winch_app/shared_prefrences/winch_user_model.dart';

class CityItem {
  int id;
  String city;
  static String lang;

  CityItem(this.id, this.city);
  static List<CityItem> getEngCompanies() {
    //tring lang = 'en';
    return <CityItem>[
      CityItem(1, 'Select city'),
      CityItem(2, 'Ain Sokhna'),
      CityItem(3, 'Alexandria'),
      CityItem(4, 'Asyut'),
      CityItem(5, 'Banha'),
      CityItem(6, 'Beheira'),
      CityItem(7, ' Beni Suef'),
      CityItem(8, 'Damietta'),
      CityItem(9, 'Faiyum'),
      CityItem(10, 'Hurghada'),
      CityItem(11, 'Ismailia'),
      CityItem(12, 'Kafr El Sheikh'),
      CityItem(13, 'Mansoura'),
      CityItem(14, 'Marsa Alam'),
      CityItem(15, 'Matruh'),
      CityItem(16, 'Minya'),
      CityItem(17, 'Monufia'),
      CityItem(18, 'New Valley'),
      CityItem(19, 'North Coast'),
      CityItem(20, 'North Sinai'),
      CityItem(21, 'Port Said'),
    ];
  }

  static List<CityItem> getArabCompanies() {
    //tring lang = 'en';
    return <CityItem>[
      CityItem(1, 'اختر المحافظه'),
      CityItem(2, 'السخنة'),
      CityItem(3, 'الإسكندرية'),
      CityItem(4, 'اسيوط'),
      CityItem(5, 'بنها'),
      CityItem(6, 'البحيرة'),
      CityItem(7, 'بني سويف'),
      CityItem(8, 'دمياط'),
      CityItem(9, 'الفيوم'),
      CityItem(10, 'الغردقة'),
      CityItem(11, 'الاسماعيلية'),
      CityItem(12, ' كفر الشيخ'),
      CityItem(13, 'المنصورة'),
      CityItem(14, 'مرسى علم'),
      CityItem(15, 'مطروح'),
      CityItem(16, 'المنيا'),
      CityItem(17, 'المنوفية'),
      CityItem(18, 'الوادي الجديد'),
      CityItem(19, 'الساحل الشمالي'),
      CityItem(20, 'راس غارب'),
      CityItem(21, 'بورسعيد'),
    ];
  }
}

// static List<CityItem> getEngCompanies() {
// //tring lang = 'en';
// return <CityItem>[
// CityItem(1, lang == 'en' ? 'Select city' : 'اختر المحافظه'),
// CityItem(2, lang == 'en' ? 'Ain Sokhna' : 'السخنة'),
// CityItem(3, lang == 'en' ? 'Alexandria' : 'الإسكندرية'),
// CityItem(4, lang == 'en' ? 'Asyut' : 'اسيوط'),
// CityItem(5, lang == 'en' ? 'Banha' : 'بنها'),
// CityItem(6, lang == 'en' ? 'Beheira' : 'البحيرة'),
// CityItem(7, lang == 'en' ? ' Beni Suef' : 'بني سويف'),
// CityItem(8, lang == 'en' ? 'Damietta' : 'دمياط'),
// CityItem(9, lang == 'en' ? 'Faiyum' : 'الفيوم'),
// CityItem(10, lang == 'en' ? 'Hurghada' : 'الغردقة'),
// CityItem(11, lang == 'en' ? 'Ismailia' : 'الاسماعيلية'),
// CityItem(12, lang == 'en' ? 'Kafr El Sheikh' : ' كفر الشيخ'),
// CityItem(13, lang == 'en' ? 'Mansoura' : 'المنصورة'),
// CityItem(14, lang == 'en' ? 'Marsa Alam' : 'مرسى علم'),
// CityItem(15, lang == 'en' ? 'Matruh' : 'مطروح'),
// CityItem(16, lang == 'en' ? 'Minya' : 'المنيا'),
// CityItem(17, lang == 'en' ? 'Monufia' : 'المنوفية'),
// CityItem(18, lang == 'en' ? 'New Valley' : 'الوادي الجديد'),
// CityItem(19, lang == 'en' ? 'North Coast' : 'الساحل الشمالي'),
// CityItem(20, lang == 'en' ? 'North Sinai' : 'راس غارب'),
// CityItem(21, lang == 'en' ? 'Port Said' : 'بورسعيد'),
// ];
// }
