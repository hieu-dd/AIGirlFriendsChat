import 'package:ai_girl_friends/common/const/image.dart';
import 'package:ai_girl_friends/screen/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PremiumScreen extends ConsumerStatefulWidget {
  static const direction = 'premium';

  const PremiumScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _PremiumScreenState();
}

class _PremiumScreenState extends ConsumerState<PremiumScreen> {
  int _selectBenefitIndex = 2;

  void _selectBenefit(int index) {
    setState(() {
      _selectBenefitIndex = _selectBenefitIndex == index ? -1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.background;
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  ImageConst.premiumBg,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    backgroundColor,
                    backgroundColor.withOpacity(0.9),
                    backgroundColor.withOpacity(0.7),
                    Colors.transparent,
                  ],
                )),
              ),
              ShaderMask(
                blendMode: BlendMode.srcATop,
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFFFCB69), Color(0xFFFFE09F)],
                  ).createShader(bounds);
                },
                child: Text(
                  'GET PREMIUM',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.yellow.withOpacity(0.8),
                        offset: Offset(-0.0, -0.0),
                      ),
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.yellow.withOpacity(0.8),
                        offset: Offset(0.0, -0.0),
                      ),
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.yellow.withOpacity(0.8),
                        offset: Offset(0.0, 0.0),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          _benefitRow('Get deeper into any relationship'),
          _benefitRow('Unlimited daily messages'),
          _benefitRow('Remove ads for good'),
          _benefitRow('Highly prioritized feedback'),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _registerItem(
                  '1',
                  'month',
                  '\$19.99',
                  'Best seller',
                  _selectBenefitIndex == 0,
                  onClick: () {
                    _selectBenefit(0);
                  },
                ),
                const SizedBox(width: 13),
                _registerItem(
                  '6',
                  'month',
                  '\$49.99',
                  'Save 50%',
                  _selectBenefitIndex == 1,
                  onClick: () {
                    _selectBenefit(1);
                  },
                ),
                const SizedBox(width: 13),
                _registerItem(
                  null,
                  'forever',
                  '\$99.99',
                  'Life time',
                  _selectBenefitIndex == 2,
                  onClick: () {
                    _selectBenefit(2);
                  },
                )
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
            child: PrimaryButton(
              onClick: () {},
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFFC452),
                  Color(0xFFFFD886),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              title: 'Continue',
            ),
          )
        ],
      ),
    ));
  }

  Widget _registerItem(
    String? time,
    String timeUnit,
    String price,
    String highlight,
    bool isSelect, {
    required void Function() onClick,
  }) {
    return Flexible(
      fit: FlexFit.tight,
      child: InkWell(
        onTap: onClick,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            isSelect
                ? Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(top: 6),
                    width: double.infinity,
                    height: 190,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFEADCA6),
                          Color(0xFFF1C55F),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Text(
                      highlight,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 190,
                  ),
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFF3B3D3D),
              ),
              child: Column(children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  child: time != null
                      ? FittedBox(
                          child: Text(
                            time,
                            style: const TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        )
                      : Image.asset(ImageConst.icInfinity),
                ),
                Text(
                  timeUnit.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Text(
                  price,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFEBD99C)),
                ),
                const SizedBox(height: 30),
              ]),
            ),
            if (!isSelect)
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.3),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _benefitRow(String benefit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          const Icon(
            Icons.done,
            color: Color(0xFF70FFC3),
            size: 44,
          ),
          Text(
            benefit,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
