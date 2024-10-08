import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future signInWithGoogle() async {
  try {

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // If the user cancels the sign-in, the `googleUser` will be null
    if (googleUser == null) {
      return null;
    }

    // Authenticate the Google user
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Get the credentials for Firebase Authentication
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the Google user credentials
    final UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);

    // Return the Firebase user
    return userCredential.user;
  } catch (e) {
    print("Error during Google Sign-In: $e");
    return null;
  }
}
