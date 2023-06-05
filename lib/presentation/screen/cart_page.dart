import 'package:flutter/material.dart';
import 'package:memes_api/common/models/cart_card_model.dart';
import 'package:memes_api/common/providers/api_cart_provider.dart';
import 'package:memes_api/common/providers/cart_counter_provider.dart';
import 'package:memes_api/presentation/widget/text_and_button.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var memeCartProvider = Provider.of<MemeCartProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Meme Cart Items(${memeCartProvider.getMemesIdList!.length})',
        ),
      ),
      body: memeCartProvider.getCartList.isEmpty
          ? const TextAndButton()
          : Consumer<MemeCartProvider>(
            builder: (context,value,child){
              return ListView.builder(
                itemCount: value.getMemesIdList!.length,
                itemBuilder: ((context,index){
                  CartCardModel cartObject = value.getCartList[index];
                  return SizedBox(
                    child: Card(
                      elevation: 3,
                      color: const Color(0xFF323030),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(
                              "${cartObject.imageUrlCart}",
                              width: 140,
                            ),
                            Text(
                              cartObject.nameCart!.length > 20
                                  ? "${cartObject.nameCart!.substring(0, 20)}..."
                                  : "${cartObject.nameCart}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                size: 25,
                                color: Colors.white,
                              ),
                              onPressed: (){
                                value.removeItem(cartObject.id);
                                context.read<CartCounterProvider>().decrement();
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
    );
  }
}