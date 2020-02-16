package com.ydgk.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author lujun
 * @create 2019-08-13 14:34
 * 字符编码过滤器,解决获取请求参数的中文乱码问题和响应的乱码问题
 */
@WebFilter("/*")
public class EncodingFilter implements Filter {

    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        //1.强转
        HttpServletRequest  request=(HttpServletRequest)req;
        HttpServletResponse  response=(HttpServletResponse)resp;
        //2.设置请求的编码，解决请求参数的中文乱码问题
        request.setCharacterEncoding("UTF-8");
        //3.设置响应的编码，解决响应的乱码问题
        response.setContentType("text/html;charset=UTF-8");
        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
