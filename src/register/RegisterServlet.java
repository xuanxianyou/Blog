package register;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

import utils.GenerateCode;
import utils.SaltCrypto;
import utils.SendEmail;

import static java.lang.System.out;

@WebServlet(name = "register.RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=gb2312");
        request.setCharacterEncoding("gb2312");
        String username=request.getParameter("user");
        String email=request.getParameter("email");
        String pwd=request.getParameter("pwd");
        String pwdRepeat=request.getParameter("pwdRepeat");
        System.out.println(username+"\n"+email+"\n"+pwd+"\n"+pwdRepeat);
        //获取信息不成功
        if(username.equals("null")||email.equals("null")||pwd.equals("null")){
            System.out.println("信息有空");
            request.getRequestDispatcher("login.jsp").forward(request,response);
        }else{
            //成功获取信息，判断用户是否存在
            if(isUserExists(username,email)){
                out.println("用户已经存在！");
                request.getRequestDispatcher("login.jsp").forward(request,response);
            }else{
                //存取用户信息
                SaltCrypto saltCrypto=new SaltCrypto(pwd);
                String pwdHash="";
                try {
                    pwdHash=saltCrypto.passwordCrypto();
                } catch (NoSuchAlgorithmException e) {
                    e.printStackTrace();
                }
                String salt=saltCrypto.getSalt();
                saveUserInfo(username,email,pwdHash,salt);
                out.println("用户信息存取成功");
                //开启一个线程发送邮件
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        String verifyCode="";
                        try {
                            verifyCode=GenerateCode.GenerateSixBitCode().toString();
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                        try {
                            SendEmail.sendMessage(email,username,verifyCode);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        //将验证码存到数据库
                        saveVerifyCode(email,verifyCode);

                    }
                }).start();
                //将用户email存到session
                HttpSession session=request.getSession();
                session.setAttribute("EMAIL",email);
                //跳转到缓冲页面
                request.getRequestDispatcher("registerSuccess.jsp").forward(request,response);
            }
        }




    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=gb2312");
        request.setCharacterEncoding("gb2312");
        request.getRequestDispatcher("login.jsp").forward(request,response);
    }
    protected boolean isUserExists(String username,String email){
        int userID=0;
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
                    "`phone` VARCHAR(20) DEFAULT '',\n" +
                    "`address` VARBINARY(64) DEFAULT '',\n" +
                    "`isChecked` ENUM(\"True\",\"False\") DEFAULT \"False\", \n" +
                    "PRIMARY KEY(`id`)\n" +
                    ")ENGINE=InnoDB DEFAULT CHARSET=utf8;";
            PreparedStatement statement=conn.prepareStatement(createUserTable);
            int success=statement.executeUpdate();
            if (success==0){
                out.println("Table Create Successfully...");
            }
            //查询语句
            String findUserTable=" SELECT id FROM USER WHERE username=? or email=?;";
            statement=conn.prepareStatement(findUserTable);
            statement.setBytes(1,username.getBytes());
            statement.setString(2,email);
            ResultSet result=statement.executeQuery();
            while(result.next()){
                userID = result.getInt(1);
            }
            conn.close();
        }catch (Exception e ){
            e.printStackTrace();
        }
        return userID != 0;
    }
    protected void saveUserInfo(String username,String email,String pwdHash,String salt){
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
                    "`phone` VARCHAR(20),DEFAULT ''\n" +
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
    protected void saveVerifyCode(String email,String verifyCode){
        try{
            //连接数据库
            Class.forName("com.mysql.cj.jdbc.Driver");
            String URL = "jdbc:mysql://127.0.0.1:3306/Login?characterEncoding=utf-8";
            String USER = "root";
            String PASSWORD = "123456";
            Connection conn= DriverManager.getConnection(URL, USER, PASSWORD);
            out.println("Database Connecting...");
            //创建数据表
            String createVerifyCodeTable="CREATE TABLE IF NOT EXISTS `VERIFYCODE`(\n" +
                    "`id` INT UNSIGNED AUTO_INCREMENT,\n" +
                    "`email` VARCHAR(20) NOT NULL,\n" +
                    "`verifyCode` CHAR(6)NOT NULL,\n" +
                    "PRIMARY KEY(`id`)\n" +
                    ");";
            PreparedStatement statement=conn.prepareStatement(createVerifyCodeTable);
            int success=statement.executeUpdate();
            if (success==0){
                out.println("Table Create Successfully...");
            }
            //插入语句
            String insertVerifyCodeTable="  INSERT INTO VERIFYCODE (email,verifyCode) VALUES (?,?);";
            statement=conn.prepareStatement(insertVerifyCodeTable);
            statement.setString(1,email);
            statement.setString(2,verifyCode);
            int result=statement.executeUpdate();
            if (result>0){
                out.println("Save VerifyCodeInfo Successfully...");
            }
            conn.close();
        }catch (Exception e ){
            e.printStackTrace();
        }

    }
    //杂七乱八函数
    protected String getRegisterTime(){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        return df.format(new Date());// new Date()为获取当前系统时间
    }
    protected String byteConvertString(byte[] usernameByte) throws UnsupportedEncodingException {
        return new String(usernameByte, "GB2312");
    }
}
