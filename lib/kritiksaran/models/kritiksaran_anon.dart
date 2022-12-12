class KritikSaranAnon {
    String judul;
    String deskripsi;
    static  List<KritikSaranAnon> KritikSaranAnonList = [];

    KritikSaranAnon({required this.judul, required this.deskripsi});

    static void tambahKritikSaran({judul, deskripsi}) {
        KritikSaranAnonList.add(KritikSaranAnon(judul: judul, deskripsi:deskripsi));
    }
}