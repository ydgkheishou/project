package com.ydgk.dao;

import com.ydgk.entity.Admin;
import com.ydgk.entity.Grade;
import com.ydgk.entity.Infomation;
import com.ydgk.util.PageBean;

import java.util.List;

/**
 * @author asus
 * @create 2019-08-08 19:19
 * 操作管理员表的Dao
 */
public interface AdminDao {
    //登录用户，根据用户名和密码查询一条记录
    Admin queryByNameAndPwd(String username, String userpwd,String roleid);

    //注册添加用户
    int insert(Admin admin);

    //查询当前页数据集合，也就是管理员信息
    List<Admin> queryList(PageBean<Admin> pb,String name,String roleid);

    //查询总记录数
    int queryCount(String name,String roleid);

    //根据id删除用户
    int deleteAdminById(String id);

    //查询跳转到修改页面需要的回显的用户信息
    Admin queryAdmin(String id);

    //通过id，进行密码修改
    int update(String id, String userpwd);


    //通过id，进行密码初始化
    int init(String userid);

    //查询当前页数据集合，也就是根据学生名称和成绩的次数查询学生成绩信息（所有学生）
    List<Grade> gradeQueryList(PageBean<Grade> pb, String name, String gorder);

    //查询所有学生总记录数
    int gradeQueryCount(String name,String gorder);

    //忘记密码，修改用户密码等信息
    //通过用户名查找用户设置的问题等信息
    Admin queryAdminByName(String username);

    //验证忘记密码后回答的问题是否匹配
    Admin queryAdminByAnswer(String username, String answer);

    //修改密码或问题等信息
    int updateAdminPwd(String username, String userpwd, String problem, String answer);

    //获取发布的消息
    List<Infomation> getInfomationList();

    //发布消息
    int insertInfomation(String text);

    //删除消息
    int deleteInfomationById(String nid);


    //查询教师信息
    List<Admin> queryTeacherList();

    //课程注册
    int insertCourse(String coursename, String courseclass, String tid);









   /*  //对学生成绩进行操作
    //通过gid进行分数修改
    int update(String gid, String chinese, String math, String english,String userid);

    //上传或添加成绩
    int insert(Grade grade);

    //删除成绩
    int delete(String gid);*/
}
