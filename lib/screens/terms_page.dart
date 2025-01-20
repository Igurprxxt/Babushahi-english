import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
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
                'Terms and Conditions',
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
                      'Your user content must be appropriate, civil, tasteful and in accord with generally accepted standards of etiquette and behavior on the internet.',
                    ),
                    Text(
                      'You must not use our website to link to any website or web page consisting of or containing material that would, were it posted on our website, breach the provisions of these terms and conditions of use.',
                    ),
                    Text(
                      'You must not submit any user content to the website that is or has ever been the subject of any threatened or actual legal proceedings or other similar complaint.',
                    ),
                    Text(
                      'We reserve the right to edit or remove any material submitted to our website, or stored on our servers, or hosted or published upon our website.',
                    ),
                    Text(
                      'Notwithstanding our rights under these terms and conditions of use in relation to user content, we do not undertake to monitor the submission of such content to, or the publication of such content on, our website.',
                    ),
                    Text(
                      '(1) Limited warranties',
                    ),
                    Text(
                      'You acknowledge that some of the information published on this website is submitted by users, and that we do not usually review, approve or edit such information. We do not warrant the completeness or accuracy of the information published on this website; nor do we commit to ensuring that the website remains available or that the material on the website is kept up-to-date.',
                    ),
                    Text(
                      'To the maximum extent permitted by applicable law we exclude all representations, warranties and conditions relating to this website and the use of this website (including, without limitation, any warranties implied by law of satisfactory quality, fitness for purpose and/or the use of reasonable care and skill).',
                    ),
                    Text(
                      '(2) Limitations and exclusions of liability',
                    ),
                    Text(
                      'Nothing in these terms and conditions of use will:',
                    ),
                    Text(
                      '(a) limit or exclude our or your liability for death or personal injury resulting from negligence;',
                    ),
                    Text(
                      '(b) limit or exclude our or your liability for fraud or fraudulent misrepresentation;',
                    ),
                    Text(
                      '(c) limit any of our or your liabilities in any way that is not permitted under applicable law; or',
                    ),
                    Text(
                      '(d) exclude any of our or your liabilities that may not be excluded under applicable law.',
                    ),
                    Text(
                      'The limitations and exclusions of liability set out in this Section and elsewhere in these terms and conditions of use:',
                    ),
                    Text(
                      '(a) are subject to the preceding paragraph; and',
                    ),
                    Text(
                      '(b) govern all liabilities arising under the terms and conditions of use or in relation to the subject matter of the terms and conditions of use, including liabilities arising in contract, in tort (including negligence) and for breach of statutory duty.',
                    ),
                    Text(
                      'To the extent that the website and the information and services on the website are provided free-of-charge, we will not be liable for any loss or damage of any nature.',
                    ),
                    Text(
                      'We will not be liable to you in respect of any losses arising out of any event or events beyond our reasonable control.',
                    ),
                    Text(
                      'We will not be liable to you in respect of any business losses, including (without limitation) loss of or damage to profits, income, revenue, use, production, anticipated savings, business, contracts, commercial opportunities or goodwill.',
                    ),
                    Text(
                      'We will not be liable to you in respect of any loss or corruption of any data, database or software.',
                    ),
                    Text(
                      'We will not be liable to you in respect of any special, indirect or consequential loss or damage.',
                    ),
                    Text(
                      'You accept that we have an interest in limiting the personal liability of our officers and employees. Having regard to that interest, you accept that we are a limited liability entity and agree that you will not bring any claim personally against individual officers or employees in respect of any losses you suffer in connection with the website or these terms and conditions of use. This will not, of course, limit or exclude the liability of the company itself for the acts and omissions of our officers and employees.',
                    ),
                    Text(
                      'You agree to the publication of comments, reviews and/or feedback relating to you, by others, on our website. You acknowledge that such comments, reviews and/or feedback may be critical or defamatory or otherwise unlawful; and you agree that you will not hold us liable in respect of any such comments, reviews and/or feedback, irrespective of whether we are aware or ought to have been aware of such comments, reviews and/or feedback.',
                    ),
                    Text(
                      '(3) Indemnity',
                    ),
                    Text(
                      'You hereby indemnify us and undertake to keep us indemnified against any losses, damages, costs, liabilities and expenses (including without limitation legal expenses and any amounts paid by us to a third party in settlement of a claim or dispute on the advice of our legal advisers) incurred or suffered by us arising out of any breach by you of any provision of these terms and conditions of use, or arising out of any claim that you have breached any provision of these terms and conditions of use.',
                    ),
                    Text(
                      '(4) Breaches of these terms and conditions of use',
                    ),
                    Text(
                      'Without prejudice to our other rights under these terms and conditions of use, if you breach these terms and conditions of use in any way, or if we reasonably suspect that you have breached these terms and conditions of use in any way, we may:',
                    ),
                    Text(
                      '(a) send you one or more formal warnings;',
                    ),
                    Text(
                      '(b) temporarily suspend your access to the website;',
                    ),
                    Text(
                      '(c) permanently prohibit you from accessing the website;',
                    ),
                    Text(
                      '(d) block computers using your IP address from accessing the website;',
                    ),
                    Text(
                      '(e) contact your internet services provider and request that they block your access to the website;',
                    ),
                    Text(
                      '(f) bring court proceedings against you for breach of contract or otherwise;',
                    ),
                    Text(
                      '(g) suspend and/or delete your account with the website; and/or',
                    ),
                    Text(
                      '(h) delete and/or edit any or all of your user generated content.',
                    ),
                    Text(
                      'Where we suspend or prohibit or block your access to our website or a part of our website, you must not take any action to circumvent such suspension or prohibition or blocking (including without limitation creating and/or using a different account).',
                    ),
                    Text(
                      '(5) Third party websites and hyperlinks',
                    ),
                    Text(
                      'Our website includes hyperlinks to other websites owned and operated by third parties. These links are not recommendations. We have no control over the contents of third party websites, and we accept no responsibility for them or for any loss or damage that may arise from your use of them.',
                    ),
                    Text(
                      '(6) Third party trade marks',
                    ),
                    Text(
                      'The other registered and unregistered trade marks or service marks on our website are the property of their respective owners. Unless stated otherwise, we do not endorse and are not affiliated with any of the holders of any such rights and as such we cannot grant any license to exercise such rights.',
                    ),
                    Text(
                      '(7) Variation',
                    ),
                    Text(
                      'We may revise these terms and conditions of use from time-to-time. Revised terms and conditions of use will apply to the use of our website from the date of the publication of the revised terms and conditions of use on our website. Please check this page regularly to ensure you are familiar with the current version.',
                    ),
                    Text(
                      '(8) Assignment',
                    ),
                    Text(
                      'We may transfer, sub-contract or otherwise deal with our rights and/or obligations under these terms and conditions of use without notifying you or obtaining your consent. You may not transfer, sub-contract or otherwise deal with your rights and/or obligations under these terms and conditions of use.',
                    ),
                    Text(
                      '(9) Severability',
                    ),
                    Text(
                      'If a provision of these terms and conditions of use is determined by any court or other competent authority to be unlawful and/or unenforceable, the other provisions will continue in effect. If any unlawful and/or unenforceable provision would be lawful or enforceable if part of it were deleted, that part will be deemed to be deleted, and the rest of the provision will continue in effect.',
                    ),
                    Text(
                      '(10) Exclusion of third party rights',
                    ),
                    Text(
                      'These terms and conditions of use are for the benefit of you and us, and are not intended to benefit any third party or be enforceable by any third party. The exercise of our and your rights in relation to these terms and conditions of use is not subject to the consent of any third party.',
                    ),
                    Text(
                      '(11) Entire Agreement',
                    ),
                    Text(
                      'These terms and conditions of use, together with the other legal notices on this web page, constitute the entire agreement between you and us in relation to your use of our website, and supersede all previous agreements in respect of your use of this website.',
                    ),
                    Text(
                      '(12) Law and jurisdiction',
                    ),
                    Text(
                      'These terms and conditions of use will be governed by and construed in accordance with Indian law, and any disputes relating to these terms and conditions of use will be subject to the exclusive jurisdiction of the courts of India',
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
