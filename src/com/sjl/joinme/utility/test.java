package com.sjl.joinme.utility;

import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.Random;

import com.sjl.joinme.contact.ContactDAO;
import com.sjl.joinme.tags.TagsDAO;
import com.sjl.joinme.user.UserDAO;
import com.sun.org.apache.bcel.internal.generic.NEW;

public class test {

	public static void main(String[] args) {
		System.out.println(new ContactDAO().friendExist(70, 64));

		/* System.out.println((new UserDAO().getUser(46)).getFirst_name() ); */
	}

}