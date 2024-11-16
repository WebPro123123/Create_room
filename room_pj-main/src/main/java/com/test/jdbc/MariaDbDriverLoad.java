package com.test.jdbc;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

/**
 * Servlet implementation class MariaDbDriverLoad
 */
@WebServlet("/MariaDbDriverLoad")
public class MariaDbDriverLoad extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MariaDbDriverLoad() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		try {
			Class.forName("org.mariadb.jdbc.Driver");
		}
		catch(ClassNotFoundException cnfe)
		{
			cnfe.printStackTrace();		}
	}

}
