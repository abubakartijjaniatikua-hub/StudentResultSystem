package com.studentresult.controller;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {
        "/admin-dashboard.jsp",
        "/student-dashboard",
        "/student-dashboard.jsp",

        "/students",
        "/courses",
        "/results",
        "/gpa",
        "/search-results",
        "/report",
        "/academic-settings",

        "/student-dashboard.jsp"
})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(
            jakarta.servlet.ServletRequest request,
            jakarta.servlet.ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req =
                (HttpServletRequest) request;

        HttpServletResponse res =
                (HttpServletResponse) response;

        HttpSession session =
                req.getSession(false);

        // Prevent browser from showing protected pages
        // after logout using the Back button.
        res.setHeader("Cache-Control",
                "no-cache, no-store, must-revalidate");

        res.setHeader("Pragma", "no-cache");

        res.setDateHeader("Expires", 0);

        // Check whether user is logged in
        if (session == null ||
                session.getAttribute("userId") == null) {

            res.sendRedirect("login.jsp");
            return;
        }

        String role =
                (String) session.getAttribute("role");

        String path =
                req.getServletPath();

        // ADMIN PAGES
        boolean adminPage =
                path.equals("/admin-dashboard.jsp") ||
                        path.equals("/students") ||
                        path.equals("/courses") ||
                        path.equals("/results") ||
                        path.equals("/gpa") ||
                        path.equals("/search-results") ||
                        path.equals("/report") ||
                        path.equals("/academic-settings");

        if (adminPage) {

            if (!"Admin".equals(role)) {

                res.sendRedirect("student-dashboard.jsp");
                return;
            }
        }

        // STUDENT DASHBOARD
        if (path.equals("/student-dashboard") ||
                path.equals("/student-dashboard.jsp") ||
                path.equals("/student-gpa")) {

            if (!"Student".equals(role)) {

                res.sendRedirect("admin-dashboard.jsp");
                return;
            }
        }

        // Allow request to continue
        chain.doFilter(request, response);
    }
}