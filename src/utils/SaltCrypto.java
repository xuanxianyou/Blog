package utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;
public class SaltCrypto {
    String password;
    String salt;
    public SaltCrypto(String password){
        this.password=password;
        this.salt=UUID.randomUUID().toString();
    }
    public SaltCrypto(String password, String salt){
        this.password=password;
        this.salt=salt;
    }
    //获取盐值
    public String getSalt() {
        return salt;
    }
    //密码加盐加密
    public String passwordCrypto() throws NoSuchAlgorithmException {
        String originalText=password+salt;
        MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
        byte[] bytes = messageDigest.digest(originalText.getBytes());
        return Hex.bytesToHexString(bytes);
    }
    //验证密码
    public static boolean verifyPassword(String password,String salt,String hashPassword) throws NoSuchAlgorithmException {
        SaltCrypto pwdCrypto=new SaltCrypto(password,salt);
        return hashPassword.equals(pwdCrypto.passwordCrypto());
    }
    public static void main(String []args) throws NoSuchAlgorithmException {
//        System.out.println("你哈哦");
//        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
//        System.out.println(df.format(new Date()));// new Date()为获取当前系统时间
//        String s="豹王冰冰，抱王冰冰";
//        byte[] b=s.getBytes();
//        System.out.println(s);
//        System.out.println(new String(b));
//        String password="123456";
//        SaltCrypto saltCrypto=new SaltCrypto(password);
//        String salt=saltCrypto.getSalt();
//        String pwdHash=saltCrypto.passwordCrypto();
//        System.out.println(verifyPassword(password,salt,pwdHash));
        String s=new String(new byte[]{});
        System.out.println(s);
    }

}
