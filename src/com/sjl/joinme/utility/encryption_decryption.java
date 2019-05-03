package com.sjl.joinme.utility;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class encryption_decryption {

    public static Cipher getCipher(String synchro1, String synchro2,
            String synchro3, String synchro4, boolean isEncryptMode) throws Exception {
        byte raw[] = (synchro1 + synchro2 + synchro3 + synchro4).getBytes();
        SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
        Cipher cipher = Cipher.getInstance("AES");
        if (isEncryptMode) {
            cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
        } else {
            cipher.init(Cipher.DECRYPT_MODE, skeySpec);
        }
        return cipher;
    }

    public static byte[] hexToByte(String hex) {
        byte bts[] = new byte[hex.length() / 2];
        for (int i = 0; i < bts.length; i++) {
            bts[i] = (byte) Integer.parseInt(hex.substring(2 * i, 2 * i + 2), 16);
        }

        return bts;
    }

    public static String toHexString(byte bytes[]) {
        StringBuilder retString = new StringBuilder();
        for (int i = 0; i < bytes.length; i++) {
            retString.append(Integer.toHexString(256 + (bytes[i] & 0xff)).substring(1));
        }

        return retString.toString();
    }

    public static String encrypt(String text) throws Exception {
        javax.crypto.Cipher cipher = getCipher("bb5", "1860", "17a74", "213f", true);
        return toHexString(cipher.doFinal(text.getBytes()));
    }

    public static String decrypt(String text) throws Exception {
        javax.crypto.Cipher cipher = getCipher("bb5", "1860", "17a74", "213f", false);
        String st = new String(cipher.doFinal(hexToByte(text)));
        return st;
    }

    public static void main(String[] args) throws Exception {
        String s = "Raja";
        System.out.println(encrypt("sudhanshu"));
        System.out.println(decrypt("b551e9022328cd8690a1f6a4b1a08fb8"));
    }

}
