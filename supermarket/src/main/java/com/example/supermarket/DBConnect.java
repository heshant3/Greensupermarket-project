package com.example.supermarket;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/supermarket";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }
}