import 'package:flutter/material.dart';

class PeerProfile extends StatefulWidget {
  @override
  _PeerProfileState createState() => _PeerProfileState();
}

class _PeerProfileState extends State<PeerProfile> {
  var i=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          color: Colors.pink[50],
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                actions: <Widget>[
                  IconButton(
                    onPressed: ()
                    {
                      //todo block,report
                      print('action pressed');
                    },
                    icon: Icon(Icons.more_vert),
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter),

                    ),
                    child: Text('Chamki Mamoni'),
                  ),
                  background: Image.asset('images/b4.jpeg',fit: BoxFit.cover,),
                  collapseMode: CollapseMode.parallax,
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: ()
                          {

                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.chat),
                          onPressed: ()
                          {

                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.card_giftcard),
                          onPressed: ()
                          {

                          },
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('Photos'),
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
                            child: Text('kbakjnjc kjbjbcc jbfjkbwkjbdkf wefbjekbf kjbefjb'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('kjscnjkdbcjdbclanckln knl jbjbfwjbwob lnwlkfk lkn lknwflknweknlkweb lkwfklwbdc lneflknwlk blbwkwdbklc blwdbclbdwkcb lkbcklbwdlbvlb n lknwdlkbcklsdbckln wklnfe'),
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
                            child: Text('ibdcjdbc hek jfowefhwufh ouwhourwuibiurguruiuirguv  uhuire nefrfb rerfrerfffffwfhiufe  hweifub b bbo bouhbo bioio hoih iioh iohio hioh ioiohiogui fyuui gpi gpio gohpo hiojbou buob ojbo bkn io hi hioh iohio hio biohp iphn pihp ibp buv icyuf ug ogo gio bob ob inpihi boboi h oierhgpijrwgergijreg reg regreghcriuhcfjbnergr grehigreogh3rihgriohg cwiefhwepohfpknkohfeg iheornferpknerpreni!!!!!!!!n cjbjbncknckncerogklncklnelkrnvlkrenkcnferfnreknfckernfekrnferkhgkv cjkrbjgbejbgvkjcjkv cekrjbrejkv'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SliverFillRemaining()
            ],
          ),
        )
    );
  }
}
