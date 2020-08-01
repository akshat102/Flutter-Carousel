import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  MyApp() : super();

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<MyApp> {
  CarouselSlider carouselSlider;
  int _in=0;
  List imgList=[
    'asset/img1.jpg',
    'asset/img2.jpg',
    'asset/img3.jpg',
    'asset/img4.jpg',
    'asset/img5.jpg',
    'asset/img6.jpg',
    'asset/img7.jpg'
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: new Scaffold(
          appBar: AppBar(
            title:Text('Carousel '),
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                  carouselSlider = CarouselSlider(
                  height: 400.0,
                  initialPage: 0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    reverse: false,
                    enableInfiniteScroll: true,
                    autoPlayInterval: Duration(seconds: 2),
                    autoPlayAnimationDuration: Duration(milliseconds: 2000),
                    pauseAutoPlayOnTouch: Duration(seconds: 10),
                    scrollDirection: Axis.horizontal,
                  onPageChanged: (index){
                    setState(() {
                      _in=index;
                    });
                },
                items: imgList.map((imgUrl){
                  return Builder(
                  builder: (BuildContext context){
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                       image: DecorationImage(
                            image: AssetImage(imgUrl),
                        ),
                       //color: Colors.green,
                      ),
                      child: Image.asset(
                        imgUrl,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(imgList, (index, url){
                    return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _in==index ? Colors.redAccent:Colors.green,
                      ),
                      );
                    }),
                ),
                SizedBox(
                    height: 20.0,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          OutlineButton(
                            onPressed: goToPrevious,
                            child: Text("<"),
                          ),
                          OutlineButton(
                              onPressed: goToNext,
                              child: Text(">"),
                          ),
                ],
            ),
          ],
        ),
    ),
        ),
    );
  }


  goToPrevious() {
    carouselSlider.previousPage(
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  goToNext() {
    carouselSlider.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.decelerate);
  }
}
