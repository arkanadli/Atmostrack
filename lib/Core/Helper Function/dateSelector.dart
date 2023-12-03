// Fungsi untuk menyaring data berdasarkan tanggal
import 'package:cloud_firestore/cloud_firestore.dart';

List<Map<String, dynamic>> filterDataByDate(
    List<DocumentSnapshot> dataSensorList, String selectedDate) {
  // Ambil DateTime dari selectedDate (yang diasumsikan sebagai string)
  DateTime dateTime = DateTime.parse(selectedDate);

  // List untuk menyimpan data yang sesuai dengan tanggal
  List<Map<String, dynamic>> dataSesuaiTanggal = [];

  // Loop melalui semua elemen di dataSensorList
  for (var data in dataSensorList) {
    // Ambil Timestamp dari data
    Timestamp waktu = data['timestamp'];

    // Ubah Timestamp menjadi objek DateTime
    DateTime date = waktu.toDate();

    // Periksa tahun, bulan, dan tanggal
    if (dateTime.year == date.year &&
        dateTime.month == date.month &&
        dateTime.day == date.day) {
      // Jika tanggal sesuai, tambahkan data ke list
      dataSesuaiTanggal.add(data.data() as Map<String, dynamic>);
    }
  }

  return dataSesuaiTanggal;
}
