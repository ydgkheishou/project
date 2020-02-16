package com.ydgk.entity;

/**
 * @author asus
 * @create 2019-12-17 11:55
 */
public class Course {
    private Integer cid;
    private String coursename;
    private String courseclass;
    private Admin admin;

    @Override
    public String toString() {
        return "Course{" +
                "cid=" + cid +
                ", coursename='" + coursename + '\'' +
                ", courseclass='" + courseclass + '\'' +
                ", admin=" + admin +
                '}';
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public String getCoursename() {
        return coursename;
    }

    public void setCoursename(String coursename) {
        this.coursename = coursename;
    }

    public String getCourseclass() {
        return courseclass;
    }

    public void setCourseclass(String courseclass) {
        this.courseclass = courseclass;
    }

    public Admin getAdmin() {
        return admin;
    }

    public void setAdmin(Admin admin) {
        this.admin = admin;
    }
}
