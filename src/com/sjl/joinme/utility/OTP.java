package com.sjl.joinme.utility;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.Random;

public class OTP {

	public static void main(String[] args) {
		System.out.println(MessageOTP("7748993409", RandomOTP(), "sudhanshu"));

	}

	// return -1 if fails else return otp that has been sent
	public static int MessageOTP(String mobile_number, int OTP, String user_name) {

		int flag = -1;
		String authkey = "243559AOgoDxv1Kz8K5c9a634d";
		String mobiles = "917024912074";
		String senderId = "JOINME";
		String message = "Welcome " + user_name + " your OTP is " + OTP;
		String route = "default";

		URLConnection myURLConnection = null;
		URL myURL = null;
		BufferedReader reader = null;
		String encoded_message = URLEncoder.encode(message);
		String mainUrl = "http://control.msg91.com/api/sendotp.php?";
		StringBuilder sbPostData = new StringBuilder(mainUrl);
		sbPostData.append("authkey=" + authkey);
		sbPostData.append("&mobiles=" + mobile_number);
		sbPostData.append("&message=" + encoded_message);
		sbPostData.append("&route=" + route);
		sbPostData.append("&sender=" + senderId);
		sbPostData.append("&otp=" + OTP);
		mainUrl = sbPostData.toString();
		try {
			myURL = new URL(mainUrl);
			myURLConnection = myURL.openConnection();
			myURLConnection.connect();
			reader = new BufferedReader(new InputStreamReader(myURLConnection.getInputStream()));
			String response;
			while ((response = reader.readLine()) != null)
				System.out.println("+++" + response);
			flag = OTP;
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e) {
				}

			}
			return flag;

		}

	}

	public static int RandomOTP() {
		int OTP = new Random().nextInt(10000);
		OTP += OTP < 1000 ? 1000 : 0;
		return OTP;
	}

}