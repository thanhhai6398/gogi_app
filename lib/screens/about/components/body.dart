import 'package:flutter/material.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:
        SingleChildScrollView(
          padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(5)),
                Image.asset(
                  "assets/images/about-cover.jpg",
                  height: SizeConfig.screenHeight * 0.2,
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Container(
                    child: const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Luôn tâm huyết với việc khai thác nguồn nông sản Việt Nam để tạo ra những ly thức uống tươi ngon, an toàn và giàu giá trị dinh dưỡng. Gogimở cửa hàng đầu tiên vào năm 2013, mang trong mình lòng đam mê và khát vọng xây dựng một thương hiệu trà sữa thuần Việt, mang đậm hương vị quê hương GoGi tin rằng thưởng thức một ly trà sữa được pha chế từ trà Mộc Châu, trân châu từ sản dây Nghệ An hay mứt dâu tằm từ Đà Lạt sẽ là những trải nghiệm hoàn toàn khác biệt và tuyệt vời nhất cho những khách hàng của mình.",
                        textAlign: TextAlign.justify,
                      ),
                    )
                ),
                Container(
                    child: const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "GoGi cũng đã tin vào sức mạnh của cà phê nên cũng đã đưa cà phê vào thực đơn của mình. Bởi cà phê cung cấp một sự pha trộn phức hợp giữa màu sắc, mùi thơm và hương vị, giúp đánh thức chúng ta, là nguồn cung cấp chất chống oxy hóa lớn trong chế độ ăn uống và bảo vệ chống lại các bệnh khác nhau. Đó là một thức uống kỳ diệu, phải không? Đó là lý do tại sao chúng tôi thích phục vụ điều này.",
                        textAlign: TextAlign.justify,
                      ),
                    )
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/coffee-berry.jpg",
                      height: SizeConfig.screenHeight * 0.2,
                      width: SizeConfig.screenWidth * 0.2,
                    ),
                    SizedBox(width: getProportionateScreenWidth(5)),
                    Image.asset(
                      "assets/images/coffee-beans.jpg",
                      height: SizeConfig.screenHeight * 0.2,
                      width: SizeConfig.screenWidth * 0.5,
                    ),
                    SizedBox(width: getProportionateScreenWidth(5)),
                    Image.asset(
                      "assets/images/coffee-pot.jpg",
                      height: SizeConfig.screenHeight * 0.2,
                      width: SizeConfig.screenWidth * 0.2,
                    ),
                  ],
                )
              ],
            )
        )
    );
  }
}
