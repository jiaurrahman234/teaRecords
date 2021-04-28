import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tea_records/constants.dart';

import 'DailyField/DailyFieldReport.dart';
import 'GreenLeaf/GreenLeaf.dart';
import 'GreenLeaf/GreenLeafReport.dart';
import 'RawMaterialReport/RawMaterialReport.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.white,
          title: Text('Dashboard',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 30.0)),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Jiaur Rahman',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0)),
                  Icon(Icons.arrow_drop_down, color: Colors.black54)
                ],
              ),
            )
          ],
        ),
        body: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: <Widget>[
            _buildTile(
              daily_green_leaf,
              context,
              contentDesign("assets/images/green_tea.svg", daily_green_leaf),
            ),
            _buildTile(
              daily_field_report,
              context,
              contentDesign(
                  "assets/images/field_report.svg", daily_field_report),
            ),
            _buildTile(
              daily_raw_material,
              context,
              contentDesign(
                  "assets/images/raw_materials.svg", daily_raw_material),
            ),
            _buildTile(
              daily_production,
              context,
              contentDesign(
                  "assets/images/daily_production.svg", daily_production),
            ),
          ],
          staggeredTiles: [
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(1, 180.0),
          ],
        ));
  }

  Widget _buildTile(String page, BuildContext context, Widget child,
      {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            onTap: () {
              if (page.compareTo(daily_green_leaf) == 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GreenLeafForm(title: page)));
              } else if (page.compareTo(daily_field_report) == 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DailyFieldReportForm(title: page)));
              } else if (page.compareTo(daily_raw_material) == 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RawMaterialdReportForm(title: page)));
              } else {}
            },
            child: child));
  }

  Widget contentDesign(String assetName, String title) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SvgPicture.asset(
              assetName,
              height: 70.0,
              width: 70.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 16.0)),
            Text(title, style: Theme.of(context).textTheme.headline6),
          ]),
    );
  }
}
