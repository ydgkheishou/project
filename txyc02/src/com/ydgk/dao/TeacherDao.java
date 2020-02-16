package com.ydgk.dao;

import com.ydgk.entity.Admin;
import com.ydgk.entity.Grade;
import com.ydgk.util.PageBean;

import java.util.List;

/**
 * @author asus
 * @create 2019-12-13 8:49
 */
public interface TeacherDao {
    //教师页面方法
    //查询当前页数据集合，也就是查询学生信息
    List<Admin> studentQueryList(PageBean<Admin> pb, String name,Integer userid);

    //查询学生总记录数
    int studentQueryCount(String name,Integer userid);

    //查询当前页数据集合，也就是根据学生名称和成绩的次数查询学生成绩信息
    List<Grade> gradeQueryList(PageBean<Grade> pb, String name,String gorder,Integer userid);

    //查询学生总记录数
    int gradeQueryCount(String name,String gorder,Integer userid);

    //查询跳转到修改页面需要的回显的用户信息
    Grade queryGrade(String userid,String gid);

    //通过gid进行分数修改
    int update(String gid, String chinese, String math, String english,String userid);

    //上传或添加成绩
    int insert(Grade grade);

    //删除成绩
    int delete(String gid);

    /*//查询所有学生成绩信息
    List<Grade> gradeQueryListAll(PageBean<Grade> pb, String name);*/
}
