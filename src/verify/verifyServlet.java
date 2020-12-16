package verify;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import static java.lang.System.out;

@WebServlet(name = "verifyServlet")
public class verifyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session=request.getSession();
        String email=session.getAttribute("EMAIL").toString();
        System.out.println(email);
        //检索用户验证码与用户是否对应，并将IsCheck设置为True
        String verifyCode=request.getParameter("verifyCode");
        System.out.println(verifyCode);
        if(!verifyCode.equals("")){
            //如果验证码验证成功
            if(checkVerifyCode(email,verifyCode)){
                request.getRequestDispatcher("blog.jsp").forward(request,response);
            }else{
                session.setAttribute("EMAIL",email);
                request.getRequestDispatcher("verify.jsp").forward(request,response);
            }
        }else{
            request.getRequestDispatcher("verify.jsp").forward(request,response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("verify.jsp").forward(request,response);
    }
    protected boolean checkVerifyCode(String email,String verifyCode){
        boolean isMatch=false;
        try{
            //连接数据库
            Class.forName("com.mysql.cj.jdbc.Driver");
            String URL = "jdbc:mysql://127.0.0.1:3306/Login?characterEncoding=utf-8";
            String USER = "root";
            String PASSWORD = "123456";
            Connection conn= DriverManager.getConnection(URL, USER, PASSWORD);
            out.println("Database Connecting...");
            //查询语句
            String findVerifyCodeTable=" SELECT verifyCode FROM VERIFYCODE WHERE email=? ;";
            PreparedStatement statement=conn.prepareStatement(findVerifyCodeTable);
            statement.setString(1,email);
            ResultSet result=statement.executeQuery();
            while(result.next()){
                String s = result.getString(1);
                if(verifyCode.equals(s)){
                    isMatch=true;
                    break;
                }
            }
            if(isMatch){
                //删除语句
                String delVerifyCodeTable="DELETE FROM VERIFYCODE WHERE email=?;";
                statement=conn.prepareStatement(delVerifyCodeTable);
                statement.setString(1,email);
                int i=statement.executeUpdate();
                if(i>0){
                    out.println("Delete VerifyCode Successfully!");
                }
                //修改用户状态
                String updateUserTable=" UPDATE USER SET isChecked=\"True\" WHERE email =?;";
                statement=conn.prepareStatement(updateUserTable);
                statement.setString(1,email);
                i=statement.executeUpdate();
                if(i>0){
                    out.println("Delete VerifyCode Successfully!");
                }
            }


            conn.close();
        }catch (Exception e ){
            e.printStackTrace();
        }
        return isMatch;
    }
}
