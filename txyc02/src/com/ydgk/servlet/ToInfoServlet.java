package com.ydgk.servlet;

import com.ydgk.dao.AdminDao;
import com.ydgk.dao.impl.AdminDaoImpl;
import com.ydgk.entity.Infomation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


/**
 * @author asus
 * @create 2019-08-08 20:32
 */
@WebServlet("/toInfo.action")
public class ToInfoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //查询发布的消息
        AdminDao adminDao=new AdminDaoImpl();
        List<Infomation> list=adminDao.getInfomationList();
        request.setAttribute("infomationList",list);

        //请求转发到jsp/main/info.jsp
        request.getRequestDispatcher("WEB-INF/jsp/main/info.jsp").forward(request, response);
    }

}
