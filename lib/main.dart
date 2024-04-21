import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mydiary/firebase_options.dart';
import 'package:mydiary/views/login_view.dart';
import 'package:mydiary/views/register_view.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Color.fromARGB(255, 188, 162, 66),
    // ));
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.purple,
      // ···
      brightness: Brightness.dark,
    ),
    ),
    home: const HomePage(),
    routes: {
      '/login/' :(context) => const LoginView(),
      '/register/':(context) => const RegisterView()
    },
  ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // final user = FirebaseAuth.instance.currentUser;
              // if(user?.emailVerified??false){
              //   return const Text("Done");
              // }else{
              //  return const VerifyEmailView();
              // }          
              return const LoginView();
            default:
              return const CircularProgressIndicator();
          }
        },
      );
  }
}
class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(      
      appBar: AppBar(
        title: const Text('Email Verification!'),
      ),
      body: Column(children: [
          const Text('Please verify your mail!'),
          TextButton(
            onPressed: () async{
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            },
            child: const Text('send email verification!')
          ),
        ]),
    );
  }
}