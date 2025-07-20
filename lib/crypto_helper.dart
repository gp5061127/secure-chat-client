import 'dart:typed_data';
import 'package:flutter_sodium/flutter_sodium.dart';

class CryptoHelper {
  late Uint8List _key;

  CryptoHelper() {
    _key = Sodium.cryptoSecretboxKeygen();
  }

  Uint8List encrypt(String message) {
    final nonce = Sodium.randombytesBuf(Sodium.cryptoSecretboxNoncebytes);
    final messageBytes = Uint8List.fromList(message.codeUnits);
    final encrypted = Sodium.cryptoSecretboxEasy(messageBytes, nonce, _key);
    return Uint8List.fromList(nonce + encrypted);
  }

  String decrypt(Uint8List cipherWithNonce) {
    final nonceLength = Sodium.cryptoSecretboxNoncebytes;
    final nonce = cipherWithNonce.sublist(0, nonceLength);
    final ciphertext = cipherWithNonce.sublist(nonceLength);
    final decrypted = Sodium.cryptoSecretboxOpenEasy(ciphertext, nonce, _key);
    return String.fromCharCodes(decrypted);
  }
}
