import 'package:adjemin_gateway_sdk/adjemin_gateway_sdk.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:url_launcher/url_launcher.dart';

class OtpFormWidget extends StatefulWidget {
  final GatewayOperator gatewayOperator;
  final String title;

  const OtpFormWidget(
      {super.key, required this.title, required this.gatewayOperator});

  @override
  _OtpFormWidgetState createState() => _OtpFormWidgetState();
}

class _OtpFormWidgetState extends State<OtpFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50.0,
            ),
            Center(
              child: Image.network(
                widget.gatewayOperator.image!,
                width: 80,
                height: 80,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              child: Text(
                "${widget.gatewayOperator.name}",
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              child: Text(
                "Obtenez un code validation en cliquant sur",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.secondary),
                ),
                onPressed: () async {
                  await _makePhoneCall("#144*82#");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "#144*82#",
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Entrez le code reçu  dans le champs ci-dessous:",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: OTPTextField(
                length: 4,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: (MediaQuery.of(context).size.width / 4) - 40,
                fieldStyle: FieldStyle.underline,
                style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: Colors.black) ??
                    TextStyle(color: Colors.black),
                onChanged: (pin) {
                  // Vous pouvez ajouter ici une logique pour valider le PIN en temps réel si nécessaire
                  print("PIN en cours de saisie : $pin");
                },
                onCompleted: (pin) {
                  if (pin.isNotEmpty && pin.length == 4) {
                    Navigator.of(context).pop(pin);
                  } else {
                    // Gérer le cas où le PIN est invalide
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              "Veuillez entrer un code PIN valide à 4 chiffres")),
                    );
                  }
                },
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: OTPTextField(
            //     length: 4,
            //     width: MediaQuery.of(context).size.width,
            //     textFieldAlignment: MainAxisAlignment.spaceAround,
            //     fieldWidth: (MediaQuery.of(context).size.width / 4) - 40,
            //     fieldStyle: FieldStyle.underline,
            //     style: Theme.of(context)
            //         .textTheme
            //         .displaySmall!
            //         .copyWith(color: Colors.black),
            //     onCompleted: (pin) {
            //       if (pin.isNotEmpty && pin.length == 4) {
            //         Navigator.of(context).pop(pin);
            //       }
            //     },
            //   ),
            // ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.

  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  }
  }
}
