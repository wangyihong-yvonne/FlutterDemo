import 'package:flutter/material.dart';

main() => runApp(new MaterialApp(
      home: new AppHome(),
      theme: ThemeData(fontFamily: 'Roboto'),
    ));

class AppHome extends StatefulWidget {
  @override
  State<AppHome> createState() {
    return new AppState();
  }
}

class AppState extends State<AppHome> with SingleTickerProviderStateMixin {
  List<String> Names = ['Abhishek Locker', 'John Smith', 'Robert Wings'];
  List<String> Positions = ['Manager', 'Sales', 'HR'];
  List<String> Time = [
    '5/30 slots booked',
    '5/2 slots booked',
    '6/30 slots booked'
  ];

  // list item
  Widget _buildListItem(BuildContext context, int index) {
    return EachList(this.Names[index], this.Positions[index], this.Time[index]);
  }

  late TabController tController;

  @override
  void initState() {
    super.initState();
    tController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: new Text("Blismo Demo by Yvonne",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            controller: tController,
            tabs: <Widget>[
              Tab(text: 'By Time'),
              Tab(text: "By Owner"),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: TabBarView(
              controller: tController,
              children: <Widget>[
                Center(
                  child: Container(
                    child: Text('First Tab'),
                  ),
                ),
                Container(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      // If it is not a Widget of the Sliver family, you need to use the SliverToBoxAdapter as a layer wrapper.
                      // SliverFixedExtendList has higher performance than SliverList when the list item height is fixed
                      SliverList(
                        delegate: SliverChildBuilderDelegate(_buildListItem,
                            childCount: this.Names.length),
                        //itemExtent: 48.0
                      ),
                      SliverToBoxAdapter(
                          child: SizedBox(
                        child: Container(
                          height: 120,
                          color: Colors.grey[200],
                          child: Center(
                              child: Text('+',
                                  style: TextStyle(
                                      fontSize: 50.0,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ))
          ],
        ));
  }
}

class EachList extends StatelessWidget {
  final String name;
  final String time;

  EachList(this.name, this.position, this.time);

  final String position;

  //EachList(this.position);
  @override
  Widget build(BuildContext context) {
    return new Card(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ListTile(
              title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(position),
                    Text(""),
                    Text(time),
                  ]),
              leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://www.woolha.com/media/2020/03/eevee.png")),
            )));
  }
}
