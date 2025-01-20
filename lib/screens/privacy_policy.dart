import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Animate(
      effects: const [
        FadeEffect(duration: Duration(milliseconds: 500)),
      ],
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    onPressed: () {
                      // Sending user to the previous screen
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              const Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.all(10),
                // Width = 90% of the screen
                width: MediaQuery.of(context).size.width * 0.9,
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Your privacy is important to Tirchhi Nazar Media. This privacy statement provides information about the personal information that Tirchhi Nazar Media collects, and the ways in which Tirchhi Nazar Media uses that personal information.',
                    ),
                    Text('Personal information collection'),
                    Text(
                        'Tirchhi Nazar Media may collect and use the following kinds of personal information:\ninformation about your use of this website (including [the contents, images and graphics, design and technology used in developing the website.]);'),
                    Text(
                        'information that you provide for the purpose of registering with the website (name of the registrar, the address, phone number and email of site owner , administrator and billing contacts '),
                    Text(
                      'information that you provide for the purpose of subscribing to the website services (including [including the name, address and phone number of the person of contact]); and] ',
                    ),
                    Text(
                      '[any other information that you send to Tirchhi Nazar Media].] ',
                    ),
                    Text(
                      'Using personal information',
                    ),
                    Text(
                      'Tirchhi Nazar Media] may use your personal information to:',
                    ),
                    Text(
                      '''
→ administer this website
→ personalize the website for you;
→ enable your access to and use of the website services;
→ publish information about you on the website;
→ send to you products that you purchase;
→ supply to you services that you purchase;
→ send to you statements and invoices;
→ collect payments from you; and
→ send you marketing communications.''',
                    ),
                    Text(
                      'Where Tirchhi Nazar Media discloses your personal information to its agents or sub-contractors for these purposes, the agent or sub-contractor in question will be obligated to use that personal information in accordance with the terms of this privacy statement.',
                    ),
                    Text(
                      'In addition to the disclosures reasonably necessary for the purposes identified elsewhere above, Tirchhi Nazar Media may disclose your personal information to the extent that it is required to do so by law, in connection with any legal proceedings or prospective legal proceedings, and in order to establish, exercise or defend its legal rights.',
                    ),
                    Text(
                      'Securing your data',
                    ),
                    Text(
                      'Tirchhi Nazar Media will take reasonable technical and organizational precautions to prevent the loss, misuse or alteration of your personal information.',
                    ),
                    Text(
                      'Tirchhi Nazar Media will store all the personal information you provide [on its secure servers].',
                    ),
                    Text(
                      '→ Information relating to electronic transactions entered into via this website will be protected by encryption technology.',
                    ),
                    Text(
                      '→ Cross-border data transfers',
                    ),
                    Text(
                      'Information Tirchhi Nazar Media collects may be stored and processed in and transferred between any of the countries in Tirchhi Nazar Media operates to enable the use of the information in accordance with this privacy policy. ',
                    ),
                    Text(
                      'In addition, personal information that you submit for publication on the website will be published on the internet and may be available around the world. ',
                    ),
                    Text(
                      'You agree to such cross-border transfers of personal information.',
                    ),
                    Text(
                      '→ Updating this statement',
                    ),
                    Text(
                      'may update this privacy policy by posting a new version on this website. You should check this page occasionally to ensure you are familiar with any changes.',
                    ),
                    Text(
                      'Other websites',
                    ),
                    Text(
                      '→ This website contains links to other websites.',
                    ),
                    Text(
                      'Tirchhi Nazar Media is not responsible for the privacy policies or practices of any third party.',
                    ),
                    Text(
                      '→ Contact Tirchhi Nazar Media',
                    ),
                    Text(
                      'If you have any questions about this privacy policy or Tirchhi Nazar Media treatment of your personal information, ',
                    ),
                    Text(
                      'please write by email to tirshinazar@gmail.com',
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
