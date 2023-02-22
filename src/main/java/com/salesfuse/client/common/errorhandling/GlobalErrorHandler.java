/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.common.errorhandling;
import com.salesfuse.client.authentication.service.CustomUser;
import com.salesfuse.client.util.MyErrorClass;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author User
 */
@Controller
public class GlobalErrorHandler implements ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request, Model m) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        MyErrorClass c = new MyErrorClass();
        c.setErrorMessage("Uh-Oh! Something went wrong !!!");
        if (status != null) {
            Integer statusCode = Integer.valueOf(status.toString());
            c.setErrorcode(statusCode);
            if (statusCode == HttpStatus.NOT_FOUND.value()) {
                c.setErrorMessage("Page Not Found Exception!!!");
            } else if (statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
                c.setErrorMessage("Internal Service Error!!!");
            } else if (statusCode == HttpStatus.FORBIDDEN.value()) {
                c.setErrorMessage("You are not authenticated user to access this page");
            }
        }
        m.addAttribute("error", c);
        CustomUser u = (CustomUser) request.getSession().getAttribute("user");
//        if (u != null) {
//            if (isIntranetUser(u.getUserType()) || isAdmin(u.getUserType()) || isExtranetUser(u.getUserType())) {
//                System.out.println("RCMS Error Handling: "+status);
//                return "/common/error";
//            }
//        }

        return "error";
    }

    @Override
    public String getErrorPath() {
        return "/error";
    }

    private boolean isExtranetUser(Integer id) {
        switch (id) {
            case 8:
            case 10:
            case 12:
                return true;
            default:
                return false;
        }
    }

    private boolean isAdmin(Integer id) {
        switch (id) {
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
                return true;
            default:
                return false;
        }
    }

    private boolean isIntranetUser(Integer id) {
        switch (id) {
            case 9:
            case 11:
            case 13:
            case 14:
                return true;
            default:
                return false;
        }
    }

}
