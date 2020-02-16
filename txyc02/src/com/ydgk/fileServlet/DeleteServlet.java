package com.ydgk.fileServlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;

/**
 * @author asus
 * @create 2019-12-11 21:54
 */
@WebServlet("/servlet/DeleteServlet")
public class DeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //得到要删除的文件名
        String fileName = request.getParameter("filename");  //23239283-92489-阿凡达.avi
        //获取文件所在的路径
        String fileSaveRootPath = this.getServletContext().getRealPath("/WEB-INF/upload");
        //得到要删除的文件
        File file = new File(fileSaveRootPath + "\\" + fileName);
        file.delete();
        request.getRequestDispatcher("/servlet/ListFileServlet").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
