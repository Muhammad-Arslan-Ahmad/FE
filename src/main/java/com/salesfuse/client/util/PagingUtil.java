/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.salesfuse.client.util;

public class PagingUtil {

    public int totalRecords;
    public int pageSizes;
    public int currentPage;
    public int startIndex;
    public int endIndex;           
    public String pagingStr;
    public String resultStr;
    
    public PagingUtil(Integer totalResult, Integer currentIndex, Integer rpp){
        if(rpp == null){
            rpp = 10;
        }
        if(currentIndex == null){
            currentIndex = 0;
        }
        if(totalResult == null){
            totalResult = 0;
        }
        pagingStr = getPagingString(totalResult, currentIndex + 1, rpp);
        Integer to = (currentIndex + 1) * rpp;
        if(to > totalResult){
            to = totalResult;
        }
        if(totalResult > 0) {
            resultStr = "Showing " + (currentIndex * rpp + 1) + " to " + to + " of " + totalResult + " entries";        
        }
        else{            
            resultStr = "No record available";            
        }
    }
        
    public String getPagingString(int totalResult, int currentIndex, int rpp) {
        String pagingStr = "<ul class=\"pagination pagination-rounded justify-content-end mb-2\">";
        int totalPage = (int) Math.ceil((double) totalResult / rpp);

        if (totalPage > 1) {

            if (currentIndex != 1) {
                pagingStr = pagingStr + "<li class=\"page-item\"><a class=\"page-link\" href='#' class='previous' onclick='goToPage(\"" + (currentIndex - 1) + "\");'>Previous</a></li>";                
            }

            int begin;
            int end;

            begin = currentIndex - 2;
            if (begin <= 1) {
                begin = 1;
            }

            end = currentIndex + 2;
            if (end >= totalPage) {
                end = totalPage;
            }

            if (begin != 1) {
                pagingStr = pagingStr + "<li class=\"page-item\"><a class=\"page-link\" href='#' onclick='goToPage(\"" + 1 + "\");'>" + 1 + "</a></li>";
            }

            if (begin > 2) {
                pagingStr = pagingStr + " <li class=\"page-item\"><a class=\"page-link\" href='#'>...</a></li>";
            }

            for (int i = begin; i <= end; i++) {
                if (i == currentIndex) {
                    pagingStr = pagingStr + "<li class='page-item active'><a class=\"page-link\" href='#' class='current' onclick='goToPage(\"" + i + "\");'>" + i + "</a></li>";
                } else {
                    pagingStr = pagingStr + "<li class=\"page-item\"><a class=\"page-link\" href='#' onclick='goToPage(\"" + i + "\");'>" + i + "</a></li>";
                }
            }

            if (end < totalPage - 1) {
                pagingStr = pagingStr + " <li class=\"page-item\"><a class=\"page-link\" href='#'>...</a></li>";
            }

            if (end != totalPage) {
                pagingStr = pagingStr + "<li class=\"page-item\"><a class=\"page-link\" href='#' onclick='goToPage(\"" + totalPage + "\");'>" + totalPage + "</a></li>";
            }

            if (currentIndex != totalPage) {                
                pagingStr = pagingStr + "<li class=\"page-item\"><a class=\"page-link\" href='#' class='next' onclick='goToPage(\"" + (currentIndex + 1) + "\");'>Next</a></li>";                
            }
            pagingStr = pagingStr + "</ul>";
            System.out.println("PAGE STRING::" + pagingStr);
        }
        return pagingStr;

    }

    /**
     * @return the totalRecords
     */
    public int getTotalRecords() {
        return totalRecords;
    }

    /**
     * @param aTotalRecords the totalRecords to set
     */
    public void setTotalRecords(int aTotalRecords) {
        totalRecords = aTotalRecords;
    }

    /**
     * @return the pageSizes
     */
    public int getPageSizes() {
        return pageSizes;
    }

    /**
     * @param aPageSizes the pageSizes to set
     */
    public void setPageSizes(int aPageSizes) {
        pageSizes = aPageSizes;
    }

    /**
     * @return the startIndex
     */
    public int getStartIndex() {
        return startIndex;
    }

    /**
     * @param aStartIndex the startIndex to set
     */
    public void setStartIndex(int aStartIndex) {
        startIndex = aStartIndex;
    }

    /**
     * @return the endIndex
     */
    public int getEndIndex() {
        return endIndex;
    }

    /**
     * @param aEndIndex the endIndex to set
     */
    public void setEndIndex(int aEndIndex) {
        this.endIndex = aEndIndex;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }


    public String getPagingStr() {
        return pagingStr;
    }

    public void setPagingStr(String pagingStr) {
        this.pagingStr = pagingStr;
    }        

    public String getResultStr() {
        return resultStr;
    }

    public void setResultStr(String resultStr) {
        this.resultStr = resultStr;
    }
    
}