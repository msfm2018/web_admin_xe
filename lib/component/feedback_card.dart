import 'package:flutter/material.dart';
// import 'package:web_app/models/Feedback.dart';

const kTextColor = Color(0xFF707070);
const kTextLightColor = Color(0xFF555555);

const kDefaultPadding = 20.0;

final kDefaultShadow = BoxShadow(
  offset: Offset(0, 50),
  blurRadius: 50,
  color: Color(0xFF0700B1).withOpacity(0.15),
);

final kDefaultCardShadow = BoxShadow(
  offset: Offset(0, 20),
  blurRadius: 50,
  color: Colors.black.withOpacity(0.1),
);

// // TextField dedign
// final kDefaultInputDecorationTheme = InputDecorationTheme(
//   border: kDefaultOutlineInputBorder,
//   enabledBorder: kDefaultOutlineInputBorder,
//   focusedBorder: kDefaultOutlineInputBorder,
// );

// final kDefaultOutlineInputBorder = OutlineInputBorder(
//   // Maybe flutter team need to fix it on web
//   // borderRadius: BorderRadius.circular(50),
//   borderSide: BorderSide(
//     color: Color(0xFFCEE4FD),
//   ),
// );

class FeedbackCard extends StatefulWidget {
  @override
  _FeedbackCardState createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  Duration duration = Duration(milliseconds: 200);
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      hoverColor: Colors.transparent,
      onHover: (value) {
        setState(() {
          isHover = value;
        });
      },
      child: AnimatedContainer(
        duration: duration,
        margin: EdgeInsets.only(top: kDefaultPadding * 3),
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        // height: double.infinity,
        width: 350,
        decoration: BoxDecoration(
          color: Color(0xFFFFF3DD),
          border: Border.all(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [if (isHover) kDefaultCardShadow],
        ),
        child: Column(
          children: [
            Transform.translate(
              offset: const Offset(0, -55),
              child: AnimatedContainer(
                duration: duration,
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 10),
                  boxShadow: [if (!isHover) kDefaultCardShadow],
                  image: const DecorationImage(
                    image: AssetImage("assets/images/people.png"),
                  ),
                ),
              ),
            ),
            const Text(
              '''北国风光，千里冰封，万里雪飘。
                望长城内外，惟余莽莽；大河上下，顿失滔滔。
山舞银蛇，原驰蜡象，欲与天公试比高。
须晴日，看红装素裹，分外妖娆。
江山如此多娇，引无数英雄竞折腰。
惜秦皇汉武，略输文采；唐宗宋祖，稍逊风骚。
一代天骄，成吉思汗，只识弯弓射大雕。
俱往矣，数风流人物，还看今朝。''',
              style: TextStyle(
                color: kTextColor,
                fontSize: 18,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
            const SizedBox(height: kDefaultPadding * 2),
            const Text(
              "高尔基",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
