package findPwd;

import utils.SaltCrypto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import static java.lang.System.out;

@WebServlet(name = "ResetPwdServlet")
public class ResetPwdServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session=request.getSession();
        String toSetEmail=session.getAttribute("email").toString();
        String userEmail=request.getParameter("YourEmail");
        String newPwd=request.getParameter("Password");
        String confirmEmail=request.getParameter("confirmPassword");
        if(toSetEmail.equals(userEmail)){
            if(newPwd.equals(confirmEmail)){
                try {
                    modifyPassword(toSetEmail,newPwd);
                } catch (NoSuchAlgorithmException e) {
                    e.printStackTrace();
                }
                out.println("密码已修改！");
                request.getRequestDispatcher("login.jsp").forward(request,response);
            }else{
                out.println("两次密码不一致！");
                request.getRequestDispatcher("login.jsp").forward(request,response);
            }
        }else{
            out.println("将要修改的邮箱与用户发送的邮箱不一致！");
            request.getRequestDispatcher("login.jsp").forward(request,response);
        }

    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=gb2312");
        request.setCharacterEncoding("gb2312");
        String user=request.getParameter("user");
        HttpSession session=request.getSession();
        String username=getUsername(user);
        String email=getEmail(user);
        session.setAttribute("username",username);
        session.setAttribute("email",email);
        if(!username.equals("")){
            request.getRequestDispatcher("resetPwd.jsp").forward(request,response);
        }else{
            request.getRequestDispatcher("login.jsp").forward(request,response);
        }
    }
    protected String getUsername(String password){
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
            String findUserTable=" SELECT username FROM USER WHERE password=?;";
            PreparedStatement statement=conn.prepareStatement(findUserTable);
            statement.setString(1,password);
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
    protected String getEmail(String password){
        String email="";
        try{
            //连接数据库
            Class.forName("com.mysql.cj.jdbc.Driver");
            String URL = "jdbc:mysql://127.0.0.1:3306/Login?characterEncoding=utf-8";
            String USER = "root";
            String PASSWORD = "123456";
            Connection conn= DriverManager.getConnection(URL, USER, PASSWORD);
            out.println("Database Connecting...");
            //查询语句
            String findUserTable=" SELECT email FROM USER WHERE password=?;";
            PreparedStatement statement=conn.prepareStatement(findUserTable);
            statement.setString(1,password);
            ResultSet result=statement.executeQuery();
            while(result.next()){
                email=result.getString(1);
            }
            conn.close();
        }catch (Exception e ){
            e.printStackTrace();
        }
        return email;
    }

    protected void modifyPassword(String email,String password) throws NoSuchAlgorithmException {
        SaltCrypto saltCrypto=new SaltCrypto(password);
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

            //修改用户状态
            String updateUserTable=" UPDATE USER SET password=?,salt=? WHERE email =?;";
            PreparedStatement statement=conn.prepareStatement(updateUserTable);
            statement.setString(1,pwdHash);
            statement.setString(2,salt);
            statement.setString(3,email);
            int i=statement.executeUpdate();
            if(i>0){
                out.println("Update Password Successfully");
            }


            conn.close();
        }catch (Exception e ){
            e.printStackTrace();
        }
    }
}
