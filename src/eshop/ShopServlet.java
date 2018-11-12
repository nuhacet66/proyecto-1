package eshop;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import eshop.beans.Book;
import eshop.beans.CartItem;
import eshop.model.DataManager;
import java.util.Hashtable;

public class ShopServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
	private static final long serialVersionUID = 1L;

	public ShopServlet() {
		super();
	}

	public void init(ServletConfig config) throws ServletException {
		System.out.println("*** initializing controller servlet.");
		super.init(config);

		DataManager dataManager = new DataManager();
		dataManager.setDbURL(config.getInitParameter("dbURL"));
		dataManager.setDbUserName(config.getInitParameter("dbUserName"));
		dataManager.setDbPassword(config.getInitParameter("dbPassword"));

		ServletContext context = config.getServletContext();
		context.setAttribute("base", config.getInitParameter("base"));
		context.setAttribute("imageURL", config.getInitParameter("imageURL"));
		context.setAttribute("dataManager", dataManager);

		try { // load the database JDBC driver
			Class.forName(config.getInitParameter("jdbcDriver"));
		} catch (ClassNotFoundException e) {
			System.out.println(e.toString());
		}
	}

	protected void addItem(HttpServletRequest request, DataManager dm) {
		HttpSession session = request.getSession(true);
		Hashtable<String, CartItem> shoppingCart = (Hashtable<String, CartItem>) session.getAttribute("carrito");
		if (shoppingCart == null) {
			shoppingCart = new Hashtable<String, CartItem>(10);
		}
		String action = request.getParameter("action");
		if (action != null && action.equals("addItem")) {
			try {
				String bookId = request.getParameter("bookId");
				Book book = dm.getBookDetails(bookId);
				if (book != null) {
					CartItem item = new CartItem(book, 1);
					shoppingCart.remove(bookId);
					shoppingCart.put(bookId, item);
					session.setAttribute("carrito", shoppingCart);
				}
			} catch (Exception e) {
				System.out.println("Error adding the selected book to the shopping cart!");
			}
		}
	}

	protected void updateItem(HttpServletRequest request) {
		
		HttpSession session = request.getSession(true);
		Hashtable<String, CartItem> shoppingCart = (Hashtable<String, CartItem>) session.getAttribute("carrito");
		 String action = request.getParameter("action");
		 if (action != null && action.equals("updateItem")) {
			    try {
			      String bookId = request.getParameter("bookId");
			      String quantity = request.getParameter("quantity");
			      CartItem item = shoppingCart.get(bookId);
			      if (item != null) {
			        item.setQuantity(quantity);
			        }
			      }
			    catch (Exception e) {
			      System.out.println("Error updating shopping cart!");
			      }
			    }
		

	}

	protected void deleteItem(HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		Hashtable<String, CartItem> shoppingCart = (Hashtable<String, CartItem>) session.getAttribute("carrito");
		 String action = request.getParameter("action");
		 if (action != null && action.equals("deleteItem")) {
			    try {
			      String bookId = request.getParameter("bookId");
			      shoppingCart.remove(bookId);
			      }
			    catch (Exception e) {
			      System.out.println("Error deleting the selected item from the shopping cart!");
			      }
			    }

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String base = "/jsp/";
		String url = base + "index.jsp";
		String action = request.getParameter("action");
		// recuperar  datamanager del contexto
		DataManager datamanager = (DataManager) request.getServletContext().getAttribute("dataManager");
		if (action != null) {
			switch (action) {
			case "search":
				url = base + "SearchOutcome.jsp";
				break;
			case "selectCatalog":
				url = base + "SelectCatalog.jsp";
				break;
			case "bookDetails":

				url = base + "BookDetails.jsp";
				break;
			case "checkOut":
				url = base + "Checkout.jsp";
				break;
			case "orderConfirmation":
				url = base + "OrderConfirmation.jsp";
				break;
			case "addItem":
				addItem(request, datamanager);
				url = base + "ShoppingCart.jsp";

				break;
			case "updateItem":
				updateItem(request);
				url = base + "ShoppingCart.jsp";

				break;
			case "deleteItem":
				deleteItem(request);
				url = base + "ShoppingCart.jsp";

				break;
			case "showCart":
				
				url = base + "ShoppingCart.jsp";

				break;

			}
		}
		RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher(url);
		requestDispatcher.forward(request, response);
	}
}
