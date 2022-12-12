class KritikSaranAnon {
    String judul;
    String deskripsi;
    static  List<KritikSaranAnon> kritikSaranAnonList = [];

    KritikSaranAnon({required this.judul, required this.deskripsi});

    static void tambahKritikSaran({judul, deskripsi}) {
        kritikSaranAnonList.add(KritikSaranAnon(judul: judul, deskripsi:deskripsi));
    }
}