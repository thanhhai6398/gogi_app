import 'package:flutter/material.dart';

import '../../../apiServices/ProductService.dart';
import '../../../constants.dart';
import '../../../models/Product.dart';
import '../../../size_config.dart';
import '../../menu/components/products.dart';

class SearchField extends StatefulWidget {
  @override
  State<SearchField> createState() => _SearchFieldScreen();
}

class _SearchFieldScreen extends State<SearchField> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.6,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(15),
                vertical: getProportionateScreenWidth(12)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Tìm kiếm sản phẩm",
            suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  print(controller.text);
                  onSearchTextChanged(controller.text);
                })),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => SearchResultScreen(keyword: text)));
    setState(() {});
  }
}

class SearchResultScreen extends StatelessWidget {
  String keyword;
  SearchResultScreen({super.key, required this.keyword});

  ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kết quả tìm kiếm", style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: productService.searchProduct(keyword),
            builder: (context, AsyncSnapshot<List<Product>> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error...'),
                );
              } else if (snapshot.hasData) {
                return Products(products: snapshot.data!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
