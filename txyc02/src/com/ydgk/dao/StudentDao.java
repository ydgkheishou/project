package com.ydgk.dao;

import com.ydgk.entity.Course;
import com.ydgk.entity.Grade;
import com.ydgk.util.PageBean;

import java.util.List;

/**
 * @author asus
 * @create 2019-12-15 10:23
 */
public interface StudentDao {

    //查询分数列表
    List<Grade> gradeQueryList(PageBean<Grade> pb, String username, String gorder);

    //查询存在的个数
    int gradeQueryCount(String username, String gorder);

    //查询课程信息
    List<Course> queryCourseList(PageBean<Course> pb);

    //查询课程总数
    int queryCourseCount();

    //学生选课
    int insert(String[] cid, Integer userid);

    //查询选课
    List<Course> queryOptionCourseList(PageBean<Course> pb,Integer userid);

    //查询选课总量
    int queryOptionCourseCount(Integer userid);

    //删除选的课程
    int deleteCourse(String cid);
}
