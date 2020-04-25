import 'package:flutter/material.dart';

class PeerProfile extends StatefulWidget {
  final snapShot;

  const PeerProfile({Key key, this.snapShot}) : super(key: key);

  @override
  _PeerProfileState createState() => _PeerProfileState();
}

class _PeerProfileState extends State<PeerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.pink[50],
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  //todo block,report
                  print('action pressed');
                },
                icon: Icon(Icons.more_vert),
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Chamki Mamoni, 30'),
              background: Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.snapShot['profilePhoto']),
                    fit: BoxFit.cover,
                    alignment: Alignment.center
                  )
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.transparent
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter),
                    ),
                  ),
                ),
              ),
              collapseMode: CollapseMode.parallax,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.2),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.favorite,size: 40,),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.chat,size: 40,),
                          onPressed: () {},
                        ),

                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(5),
                  //todo, album
                ),
                Container(
                  //todo, personal descriptions
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'kbakjnjc kjbjbcc jbfjkbwkjbdkf wefbjekbf kjbefjb'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'kjscnjkdbcjdbclanckln knl jbjbfwjbwob lnwlkfk lkn lknwflknweknlkweb lkwfklwbdc lneflknwlk blbwkwdbklc blwdbclbdwkcb lkbcklbwdlbvlb n lknwdlkbcklsdbckln wklnfe'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('sdjvchhsdbc jbdcjb jkbsdkdj kdbvvf'),
                      )
                    ],
                  ),
                ),
                Container(
                  //todo, about
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('about Me'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'ibdcjdbc hek jfowefhwufh ouwhourwuibiurguruiuirguv  uhuire nefrfb rerfrerfffffwfhiufe  hweifub b bbo bouhbo bioio hoih iioh iohio hioh ioiohiogui fyuui gpi gpio gohpo hiojbou buob ojbo bkn io hi hioh iohio hio biohp iphn pihp ibp buv icyuf ug ogo gio bob ob inpihi boboi h oierhgpijrwgergijreg reg regreghcriuhcfjbnergr grehigreogh3rihgriohg cwiefhwepohfpknkohfeg iheornferpknerpreni!!!!!!!!n cjbjbncknckncerogklncklnelkrnvlkrenkcnferfnreknfckernfekrnferkhgkv cjkrbjgbejbgvkjcjkv cekrjbrejkv'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text('Photos'),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.2),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.favorite,size: 40,),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.chat,size: 40,),
                      onPressed: () {},
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
