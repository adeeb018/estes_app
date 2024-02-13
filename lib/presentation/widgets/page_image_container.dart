import 'package:flutter/material.dart';

class PageImageContainer extends StatelessWidget {
  const PageImageContainer({super.key,required this.currentState});

  final int currentState;
  @override
  Widget build(BuildContext context) {
      if(currentState == 1) {
        return Container(
          width: 280,
          height: 320,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/exclamation_mark.png'),),
          ),
        );
      }
      else if(currentState == 2){
        return Container(
          width: 280,
          height: 320,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/troubleshoot.png'),),
          ),
        );
      }else if(currentState == 3){
        return Container(
          width: 280,
          height: 320,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/something_not_right.png'),),
          ),
        );
      }else if(currentState == 4){
        return Container(
          width: 280,
          height: 320,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/danger_exclamation.png'),),
          ),
        );
      }else{
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 280,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/success_image_stack_1.png'))
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 320,
                decoration: const BoxDecoration(
                  // color: Colors.red,
                  image: DecorationImage(
                    image: AssetImage('assets/images/success_image_stack_2.png')),
                ),
              ),
            ),
          ],
        );
      }

  }
}
