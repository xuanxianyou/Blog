package findPwd;

import utils.GenerateCode;
import utils.SaltCrypto;
import utils.SendEmail;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import static java.lang.System.out;

@WebServlet(name = "FindPwdServlet")
public class FindPwdServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email=request.getParameter("forgetPwd");
        //开启发送邮箱线程
        if(email!=null&&!email.equals("")){
            //发送找回密码的邮件
            String username=findUsername(email);
            String href=generateURL(email);
            out.println(href);
            //开启一个线程发送邮件
            new Thread(() -> {
                try {
                    SendEmail.sendFindPwdMail(email,username,href);
                } catch (Exception e) {
                    e.printStackTrace();
                }

            }).start();
        }
        //修改密码
//        if(yourEmail != null && password != null && !yourEmail.equals("") && !password.equals("") && password.equals(confirmPassword)){
//            try {
//                modifyPassword(yourEmail,password);
//            } catch (NoSuchAlgorithmException e) {
//                e.printStackTrace();
//            }
//        }
        request.getRequestDispatcher("login.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request,response);
    }
    protected String  findUsername(String email){
        String username="";
        try{
            //连接数据库
            Class.forName("com.mysql.cj.jdbc.Driver");
            String URL = "jdbc:mysql://127.0.0.1:3306/Login?characterEncoding=utf-8";
            String USER = "root";
            String PASSWORD = "123456";
            Connection conn= DriverManager.getConnection(URL, USER, PASSWORD);
            out.println("Database Connecting...");
            //查询语句
            String findUserTable=" SELECT username FROM USER WHERE email=?;";
            PreparedStatement statement=conn.prepareStatement(findUserTable);
            statement.setString(1,email);
            ResultSet result=statement.executeQuery();
            while(result.next()){
                byte[] temp = result.getBytes(1);
                username=new String(temp);
            }
            conn.close();
        }catch (Exception e ){
            e.printStackTrace();
        }
        return username;
    }
    protected String generateURL(String email){
        String password="";
        String href="http://localhost:8080/Login_war_exploded/resetPwd?user=";
        try{
            //连接数据库
            Class.forName("com.mysql.cj.jdbc.Driver");
            String URL = "jdbc:mysql://127.0.0.1:3306/Login?characterEncoding=utf-8";
            String USER = "root";
            String PASSWORD = "123456";
            Connection conn= DriverManager.getConnection(URL, USER, PASSWORD);
            out.println("Database Connecting...");
            //查询语句
            String findUserTable=" SELECT password FROM USER WHERE email=?;";
            PreparedStatement statement=conn.prepareStatement(findUserTable);
            statement.setString(1,email);
            ResultSet result=statement.executeQuery();
            while(result.next()){
                password = result.getString(1);
            }
            conn.close();
        }catch (Exception e ){
            e.printStackTrace();
        }
        return href+password;
    }
}
