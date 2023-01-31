import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as devtools show log;

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int userColorScheme = 999;
  bool isShowLicense = false;

  initPrefs() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        userColorScheme = value.getInt('userColorScheme') ?? 0;
        devtools.log('about page : ${userColorScheme.toString()}');
      });
    });
  }

  @override
  void initState() {
    initPrefs();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor:
            setColorScheme(numScheme: userColorScheme, numcolor: 0),
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: setColorScheme(numScheme: userColorScheme, numcolor: 3),
            ),
            onTap: () {
              Navigator.of(context).pop(false);
            },
          ),
          title: Text(
            'About',
            style: TextStyle(
              color: setColorScheme(numScheme: userColorScheme, numcolor: 3),
            ),
          ),
          centerTitle: true,
          elevation: 1,
          foregroundColor:
              setColorScheme(numScheme: userColorScheme, numcolor: 3),
          backgroundColor:
              setColorScheme(numScheme: userColorScheme, numcolor: 0),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'This app is developed by ',
                    style: TextStyle(
                        color: setColorScheme(
                            numScheme: userColorScheme, numcolor: 3),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  const Image(
                    image: AssetImage('assets/images/logo_1.png'),
                    width: 100,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 60),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isShowLicense = !isShowLicense;
                        });
                      },
                      child: Center(
                        child: Text(
                          isShowLicense
                              ? 'Tap to hide Licences'
                              : 'Tap to view Licenses',
                          style: TextStyle(
                            color: setColorScheme(
                                numScheme: userColorScheme, numcolor: 3),
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              isShowLicense
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 50),
                          child: Text(
                            '''The following sets forth attribution notices for third party software that may be contained in this application.
                        \n\nfl_chart\nhttps://pub.dev/packages/fl_chart\nMIT License
                        \nshared_preferences\nhttps://pub.dev/packages/shared_preferences\nBSD-3-Clause License
                        \nintl\nhttps://pub.dev/packages/intl\nBSD-3-Clause License
                        \naudioplayers\nhttps://pub.dev/packages/audioplayers\nMIT License
                        \nimage\nhttps://pub.dev/packages/image\nMIT License
                        \npixabay\nhttps://pixabay.com\nhttps://pixabay.com/service/terms/#license
                        \nflutter_native_splash\nhttps://pub.dev/packages/flutter_native_splash\nMIT License
                        \nflutter_launcher_icons\nhttps://pub.dev/packages/flutter_launcher_icons\nMIT License''',
                            style: TextStyle(
                              color: isShowLicense
                                  ? setColorScheme(
                                      numScheme: userColorScheme, numcolor: 3)
                                  : setColorScheme(
                                      numScheme: userColorScheme, numcolor: 0),
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 50),
                          child: Text(
                            '''The 3-Clause BSD License
        
SPDX short identifier: BSD-3-Clause
        
        
        
Note: This license has also been called the "New BSD License" or "Modified BSD License". See also
        
the 2-clause BSD License.
        
        
        
Copyright <YEAR> <COPYRIGHT HOLDER>
        
        
        
Redistribution and use in source and binary forms, with or without modification, are permitted
        
provided that the following conditions are met:
        
        
        
1. Redistributions of source code must retain the above copyright notice, this list of conditions and the
        
following disclaimer.
        
        
        
2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions
        
and the following disclaimer in the documentation and/or other materials provided with the
        
distribution.
        
        
        
3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse
        
or promote products derived from this software without specific prior written permission.
        
        
        
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
        
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
        
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
        
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
        
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
        
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
        
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
        
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
        
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
        
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
        
THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.''',
                            style: TextStyle(
                              color: setColorScheme(
                                  numScheme: userColorScheme, numcolor: 3),
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 50),
                          child: Text(
                            '''\n\nThe MIT License

Copyright (c) <year> <copyright holders>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.''',
                            style: TextStyle(
                              color: setColorScheme(
                                  numScheme: userColorScheme, numcolor: 3),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 10,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
