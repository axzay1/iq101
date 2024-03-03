import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/Screen/gender_category_home_screen.dart';

class GenderCategoryWidget extends StatefulWidget {

  @override
  State<GenderCategoryWidget> createState() => _GenderCategoryWidgetState();
}

class _GenderCategoryWidgetState extends State<GenderCategoryWidget> {
      @override
      Widget build(BuildContext context) {
        return SizedBox(
        height: MediaQuery.of(context).size.height * 0.239 + 20,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (context, index){
              return
                InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => GenderCategoryHomeScreen(index :index))),
              child: Column(
                    children: [
                      Container(
                        color: Colors.black,
                        width: 140,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Men', style: GoogleFonts.vollkorn(color: Colors.white, fontSize: 20)),
                            if(index > 1)
                              const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Image(image:  AssetImage('assets/images/flag.png'), height: 15, ),
                              ),
                          ],
                        ),
                      ),
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [

                            Container(
                              height: MediaQuery.of(context).size.height * 0.204,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: index == 0 ? Colors.blue.withOpacity(0.35) : index == 1 ?Colors.pink.withOpacity(0.35) :Colors.purple.withOpacity(0.35),),
                                borderRadius: BorderRadius.circular(1),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    index == 0 ? Color(0xFF81D8D0).withOpacity(0.1) : index == 1 ?Colors.pinkAccent.withOpacity(0.3) :Colors.purple.withOpacity(0.3),
                                    Colors.white.withOpacity(0.5),
                                    index == 0 ? Color(0xFF81D8D0).withOpacity(0.6) : index == 1 ?Colors.pinkAccent.withOpacity(0.6) :Colors.purple.withOpacity(0.6),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: Offset(10, 10),
                                    blurRadius: 30,
                                  ),
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    offset: Offset(-10, -10),
                                    blurRadius: 30,
                                  ),
                                ],
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(left:20, right: 20, top: 15, bottom: 23),
                                decoration: BoxDecoration(
                                  border: Border.all(color: index == 0 ? Colors.blue.withOpacity(0.2) : index == 1 ?Colors.pink.withOpacity(0.2) :Colors.purple.withOpacity(0.2)),
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      offset: Offset(10, 10),
                                      blurRadius: 30,
                                    ),
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.5),
                                      offset: Offset(-10, -10),
                                      blurRadius: 30,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child:
                                  SizedBox(
                                    width: 80,
                                    child: Card(
                                      elevation: 0.5,
                                      color: Colors.transparent,
                                      shadowColor: index > 1 ? Colors.purple: Color(0xFF81D8D0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:  BorderRadius.circular(1),
                                      ),

                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.204,
                              width: 120,
                              child:   CustomPaint(
                                painter: DiagonalLinesPainter(color: index == 0 ? Colors.blueAccent :index ==1  ? Colors.pinkAccent: Colors.purpleAccent),
                              ),
                            ),
                            Positioned(
                                top: 8,
                                child: Image(image: AssetImage('assets/images/category.png'), height: MediaQuery.of(context).size.height * 0.204)),

                          ],
                        ),
                      ),
                    ],
                  ),
                );
            })
    );
  }
}
class DiagonalLinesPainter extends CustomPainter {
  Color color;
  DiagonalLinesPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.2)
      ..strokeWidth = 1.5;

    canvas.drawLine(const Offset(0, 0),  const Offset(20, 16), paint);
    canvas.drawLine(Offset(size.width, 0),  Offset(size.width -20, 16), paint);
    canvas.drawLine(Offset(0, size.height),  Offset(20, size.height - 26), paint);
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width -20, size.height - 26), paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}