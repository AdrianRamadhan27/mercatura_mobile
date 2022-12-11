
import 'package:flutter/material.dart';

import 'package:mercatura/umkm/pages/umkm_list_page.dart';
import 'package:mercatura/umkm/models/umkm.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';


class UmkmCards extends StatelessWidget {
  UmkmCards({super.key, required this.umkmList, required this.refreshFunction});

  List<Umkm> umkmList;
  Function refreshFunction;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // TODO: implement build
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: umkmList.length,
        itemBuilder: (_, index)=> Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading:  Container(
                      width: 100,
                      padding: EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/detail_umkm', arguments: umkmList[index].pk);
                          },
                          child:CircleAvatar(
                        radius: 40.0,
                        backgroundImage: NetworkImage("${umkmList[index].fields.logoUsaha}"),
                          ),
                        ),
                      ),
          ),
                title: Text(umkmList[index].fields.namaUsaha, style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.bold),),
                subtitle: Text(
                    umkmList[index].fields.deskripsiUsaha,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('Detail'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/detail_umkm', arguments: umkmList[index].pk);
                    },
                  ),
                  const SizedBox(width: 8),
                  (request.cookies['user'] == umkmList[index].fields.pemilikUsaha) ?
                  TextButton(
                    child: const Text('Edit'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/update_umkm', arguments: umkmList[index]).then((_) {
                        refreshFunction();
                      });
                    },
                  ) :
                  Container(),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        )
    );
  }
}