package utils;

import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.text.SimpleDateFormat;

import static java.lang.System.out;

public class Test {
    public static void main(String[] args) throws NoSuchAlgorithmException {
        saveUser();
        User user=new User();
        try{
            //连接数据库
            Class.forName("com.mysql.cj.jdbc.Driver");
            String URL = "jdbc:mysql://127.0.0.1:3306/Login?characterEncoding=utf-8";
            String USER = "root";
            String PASSWORD = "123456";
            Connection conn= DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Database Connecting...");
            //查询语句
            String findUserTable=" SELECT id,username,email,work,phone,address,registerTime FROM USER WHERE email=?;";
            PreparedStatement statement=conn.prepareStatement(findUserTable);
            statement.setString(1,"123456789@qq.com");
            ResultSet result=statement.executeQuery();
            while(result.next()){
                String id = result.getString(1);
                byte[] username=result.getBytes(2);
                String email=result.getString(3);
                String work=new String(result.getBytes(4));;
                String phone=result.getString(5);
                String address=new String(result.getBytes(6));
                String registerTime=result.getString(7);
                System.out.println(id);
                System.out.println(new String(username));
                System.out.println(email);
                System.out.println(work);
                System.out.println(phone);
                System.out.println(address);
                System.out.println(registerTime);
            }
            System.out.println(user.toString());
            conn.close();
        }catch (Exception e ){
            e.printStackTrace();
        }
    }
    protected static void saveUser() throws NoSuchAlgorithmException {
        SaltCrypto saltCrypto=new SaltCrypto("123456789");
        String username="玄弦幽";
        String email="123456789@qq.com";
        String pwdHash=saltCrypto.passwordCrypto();
        String salt=saltCrypto.getSalt();
        try{
            //连接数据库
            Class.forName("com.mysql.cj.jdbc.Driver");
            String URL = "jdbc:mysql://127.0.0.1:3306/Login?characterEncoding=utf-8";
            String USER = "root";
            String PASSWORD = "123456";
            Connection conn= DriverManager.getConnection(URL, USER, PASSWORD);
            out.println("Database Connecting...");
            //创建数据表
            String createUserTable="CREATE TABLE IF NOT EXISTS `USER`(\n" +
                    "`id` INT UNSIGNED AUTO_INCREMENT,\n" +
                    "`username` VARBINARY(10) NOT NULL,\n" +
                    "`email` VARCHAR(20) NOT NULL,\n" +
                    "`password` VARCHAR(64) NOT NULL,\n" +
                    "`salt` VARCHAR(64) NOT NULL,\n" +
                    "`registerTime` DATETIME NOT NULL,\n" +
                    "`work` VARBINARY(64) DEFAULT '',\n" +
                    "`phone` VARCHAR(20),\n" +
                    "`address` VARBINARY(64) DEFAULT '',\n" +
                    "`isChecked` ENUM(\"True\",\"False\") DEFAULT \"False\", \n" +
                    "PRIMARY KEY(`id`)\n" +
                    ");";
            PreparedStatement statement=conn.prepareStatement(createUserTable);
            int success=statement.executeUpdate();
            if (success==0){
                out.println("Table Create Successfully...");
            }
            //插入语句
            String insertUserTable="INSERT INTO USER\n" +
                    "(username,email,password,salt,registerTime)\n" +
                    "VALUES\n" +
                    "(?,?,?,?,?);";
            statement=conn.prepareStatement(insertUserTable);
            statement.setBytes(1,username.getBytes());
            statement.setString(2,email);
            statement.setString(3,pwdHash);
            statement.setString(4,salt);
            statement.setString(5,getRegisterTime());
            int result=statement.executeUpdate();
            if (result>=0){
                out.println("Save UserInfo Successfully...");
            }
            conn.close();
        }catch (Exception e ){
            e.printStackTrace();
        }
    }
    protected static String getRegisterTime(){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        return df.format(new java.util.Date());// new Date()为获取当前系统时间
    }
}
