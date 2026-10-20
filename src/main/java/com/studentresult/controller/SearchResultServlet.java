package com.studentresult.controller;

import com.studentresult.dao.ResultDAO;
import com.studentresult.model.Result;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/search-results")
public class SearchResultServlet extends HttpServlet {

    private ResultDAO resultDAO;

    @Override
    public void init() {
        resultDAO = new ResultDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        if (keyword == null) {
            keyword = "";
        }

        try {

            List<Result> results =
                    resultDAO.searchResults(keyword);

            request.setAttribute("results", results);
            request.setAttribute("keyword", keyword);

            request.getRequestDispatcher(
                            "search-results.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "<h1>Database Error</h1>"
            );
        }
    }
}