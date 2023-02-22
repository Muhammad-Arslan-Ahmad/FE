/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.util;

public class MyErrorClass {

    private Integer errorcode;
    private String errorMessage;

    public MyErrorClass() {
    }

    public MyErrorClass(Integer errorcode, String errorMessage) {
        this.errorcode = errorcode;
        this.errorMessage = errorMessage;
    }

    public Integer getErrorcode() {
        return errorcode;
    }

    public void setErrorcode(Integer errorcode) {
        this.errorcode = errorcode;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }
    

}
