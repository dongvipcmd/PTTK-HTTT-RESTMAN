RESTMAN - 2 MODULE (Java JSP + Servlet + DAO + MySQL)
=====================================================
Module 1: Khach hang tim kiem mon an (khong can dang nhap)
Module 2: Nhan vien kho nhap nguyen lieu (dang nhap: kho1 / 123)

CAC BUOC:
1. Chay sql/restman.sql trong MySQL Workbench.
2. NetBeans: copy
     src/model, src/dao, src/controller  -> Source Packages
     web/*  (index.jsp, *.jsp, css/)     -> Web Pages
   (Maven: src/... -> src/main/java ; web/... -> src/main/webapp)
3. Add 2 thu vien: mysql-connector-j.jar va jstl-1.2.jar.
4. Sua USER / PASSWORD trong src/dao/DBContext.java.
5. Project Properties > Sources > Encoding = UTF-8.
6. Run project (F6). Tomcat 9: dung javax.servlet.
   Tomcat 10+: doi javax.servlet -> jakarta.servlet va taglib JSTL sang jakarta.
