import 'package:flutter/material.dart';
import 'package:horario_corte_luz/presentation/page/login_page.dart';
import 'package:horario_corte_luz/presentation/page/register_page.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroLogin(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  void _onIntroRegister(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const RegisterPage()),
    );
  }

  Widget _buildFullscreenImage(String url) {
    return Image.asset(
      'assets/onboarding/${url}',
      fit: BoxFit.cover,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    double? subTitleSize = 17;
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      safeArea: 10,
      bodyFlex: 4,
      imageFlex: 8,
    );

    return IntroductionScreen(
        // 2. Pass that key to the `IntroductionScreen` `key` param
        key: _introKey,
        autoScrollDuration: 3000,
        pages: [
          PageViewModel(
            title: 'Cortes de Luz',
            image: _buildFullscreenImage('corte1.png'),
            bodyWidget: Text(
                "En Ecuador tendremos cortes de luz en diferentes horarios hasta el mes de diciembre.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: subTitleSize)),
            decoration: pageDecoration,
          ),
          PageViewModel(
              title: 'Protege lo tuyo',
              image: _buildFullscreenImage('electromestics.png'),
              decoration: pageDecoration,
              bodyWidget: Text(
                  'Debes apagar tus electrodomésticos para evitar daños.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: subTitleSize))),
          PageViewModel(
              title: 'Conoce tus horarios',
              image: _buildFullscreenImage('hours.png'),
              decoration: pageDecoration,
              bodyWidget: Column(children: [
                Text(
                    'Los actualizamos todos los días para mantenerte informado.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: subTitleSize)),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton(
                        onPressed: () {
                          _onIntroLogin(context);
                        },
                        child: const Text('Iniciar sesión')),
                    const SizedBox(width: 40),
                    FilledButton(
                        onPressed: () {
                          _onIntroRegister(context);
                        },
                        child: const Text(
                          'Registrarse',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ]))
        ],
        showNextButton: true,
        showDoneButton: false,
        next: const Icon(Icons.arrow_forward));
  }
}
