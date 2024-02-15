package com.pcwk.ehr.util;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;


public class ShaUtil {
	public static String generateSalt() {
        SecureRandom random;
        try {
            random = SecureRandom.getInstance("SHA1PRNG");
            byte[] bytes = new byte[16];
            random.nextBytes(bytes);
            return new String(Base64.getEncoder().encode(bytes));

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String hash(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(input.getBytes());
            return String.format("%064x", new BigInteger(1, md.digest()));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    public void saltGeneration() {  //salt 생성
        String salt = ShaUtil.generateSalt();
    }

    public void hashingWithoutSalt() throws NoSuchAlgorithmException { //Salt 없이 해싱
        String raw = "test1";
        String hex = ShaUtil.hash(raw);

    }

    public void hashingWithSalt() throws NoSuchAlgorithmException { //salt와 함께 해싱
        String raw = "test1";
        String salt = ShaUtil.generateSalt();
        String rawAndSalt = raw + salt;
        String hex = ShaUtil.hash(rawAndSalt);

    }
	}
