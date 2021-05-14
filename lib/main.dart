import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const emphasisTextStyle = TextStyle(fontSize: 19, fontWeight: FontWeight.bold);
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Report Abuse Page Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? _currentIndex = 0;
  bool _isSubmitting = false;
  Map<String, String> _abuseMap = {
    'Nudity':
        "We don't allow the sharing or publishing of content depicting nudity, graphic sex acts, or other sexually explicit material. We also don't allow content that drives traffic to commercial pornography sites or that promotes pedophilia, incest, or bestiality.\n\nWe have a zero tolerance policy towards content that exploits children. This means that we will terminate the accounts of any user we find sharing or publishing child sexual abuse imagery. We will also report the content and its owner to law enforcement.\n\nWe also do not allow the sharing or publishing of content that encourages or promotes sexual attraction towards children.",
    'Promotes hate, violence or illegal/offensive activities':
        "Users may not share or publish content that promotes hate or violence towards other groups based on race, ethnicity, religion, disability, gender, age, veteran status, or sexual orientation/gender identity. Please note that individuals are not considered a protected group.\n\nUsers may not share or publish crude content or violent content that is shockingly graphic.\n\nWe will also remove content that threatens, harasses or bullies other people or promotes dangerous and illegal activities.",
    'Spam, malware or "pishing" (fake login)':
        "We do not allow spamming or content that transmits viruses, causes pop-ups, attempts to install software with the user's consent, or otherwise impacts users with malicious code or scripts. Also, we do not allow phishing activity. Our products should also not be used to solicit or collect sensitive data, including but not limited to passwords, financial details, and social security numbers.",
    'Private and confidential information':
        "We do not allow the posting of another person's personal and confidential account or identification information. For example, we do not allow the sharing or publishing of another person's credit card number or account passwords.",
    'Copyright infringement':
        "It is our policy to respond to clear notices of alleged copyright infringement. If you own the copyright to material in this document, please use this form to report an official Digital Millennium Copyright Act (DMCA) complaint:"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: FlutterLogo(
                    size: 60,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Type of abuse',
                  style: emphasisTextStyle,
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _abuseMap.length,
                itemBuilder: (context, index) {
                  return RadioListTile<int>(
                    contentPadding: EdgeInsets.zero,
                    value: index,
                    title: Text(
                      _abuseMap.keys.elementAt(index),
                      style: TextStyle(fontSize: 16),
                    ),
                    groupValue: _currentIndex,
                    onChanged: (value) {
                      setState(() => _currentIndex = value);
                      print(
                        _abuseMap.keys.elementAt(value == null ? 0 : value),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 18),
              Text(
                  'Our policy on ${_abuseMap.keys.elementAt(_currentIndex!).toLowerCase()}',
                  style: emphasisTextStyle),
              SizedBox(height: 18),
              SelectableText(
                _abuseMap.values.elementAt(_currentIndex!),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 22),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Pressed cancel'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Text('CANCEL'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _isSubmitting
                        ? null
                        : () {
                            setState(() => _isSubmitting = true);
                            ScaffoldMessenger.of(context).clearSnackBars();
                            //Give some delay to show progress indicator
                            Future.delayed(Duration(milliseconds: 790))
                                .then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Pressed submit'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              setState(() => _isSubmitting = false);
                            });
                          },
                    child: Text(
                      'SUBMIT ABUSE REPORT',
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  _isSubmitting
                      ? Center(
                          child: SizedBox(
                              width: 10,
                              height: 10,
                              child: CircularProgressIndicator()),
                        )
                      : SizedBox.shrink(),
                ],
              ),
              SizedBox(
                height: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
