 

import org.jsoup.*; 
import org.jsoup.nodes.*;
import org.jsoup.parser.*;
import org.jsoup.select.*;
import java.io.*;
import java.net.*;
import java.util.*;
/**
 * Helper class for crawler, not meant to be instantiated 
 * 
 * @author Inderjit Jutla
 * @version 1.00 10/21/2013
 */
public abstract class LinkGen
{
    /** Creates first page url for a search (unspecified page)
     * @param a is a correctly formatted search input
     * @return String containing exact url
     */
    public static String search(String a) {
        a = a.trim();
        a = a.replaceAll("[\\s]+","-");
        return "http://www.shopping.com/" + a + "/products?CLT=SCH";
    }
    
    /** Creates url for some page of a search (may not exist) 
     * @param a is the correctly formatted search input
     * @param page is an unsigned integer
     * @return String containg exact url for search and page
     */
    public static String search(String a, int page) {
        a = a.trim();
        a = a.replaceAll("[\\s]+","-");
        return "http://www.shopping.com/" + a + "/products~PG-"+page;
    }
    
    /** Checks if search contains only numebrs and letters
     * @param search is the search input
     * @return boolean true if the search contains non numbers and letters
     */
    public static boolean badSearch(String search) {
        return search.matches("([a-zA-Z\\d\\s]*)([^a-zA-Z\\d\\s]+)([a-zA-Z\\d\\s]*)");
    }
    
    /** Checks if the specified page of a result exists
     * @param link is the exact, correct link for a page
     * @return boolean true if the 
     */
    public static boolean offPage(String link) throws IOException{
        Document doc = Jsoup.parse(new URL(link),10000);
        Element center = doc.body().getElementById("centerPanel");
        if(center == null) {
            return true;
        }
        center = center.getElementById("searchResultsContainer");
        if(center == null) {
            return true;
        }
        return false;
    }
    
}
