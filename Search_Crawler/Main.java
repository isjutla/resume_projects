import org.jsoup.*; 
import org.jsoup.nodes.*;
import org.jsoup.parser.*;
import org.jsoup.select.*;
import java.io.*;
import java.net.*;
import java.util.*;
import java.lang.NumberFormatException;
/**
 * Main class of search crawler. Arguments are input as specified in BrightEdge specifications
 * 
 * @author Inderjit Jutla
 * @version 1.00 10/21/2013
 */
public final class Main
{
    /** Argument parser, takes care typical improper inputs 
     */
    public static void main (String args[]) throws IOException
    {
        if(args.length == 0) {
            System.out.println("no input");
        } else if(args.length == 1) {
            args[0] = args[0].trim();
            if(LinkGen.badSearch(args[0])) {
                System.out.println("Invalid Search, use only numbers and letters");
            } else {
                numOfResults(args[0]);
            }
  
        } else if(args.length == 2){
            args[0] = args[0].trim();
            args[1] = args[1].trim();
            try {
                if(LinkGen.badSearch(args[0])) {
                    System.out.println("Invalid Search, use only numbers and letters");
                } else {
                    String url = LinkGen.search(args[0],Integer.parseInt(args[1]));
                    if(LinkGen.offPage(url)) {
                        System.out.println("Exceeds last page of results");
                    } else {
                        int page = Integer.parseInt(args[1]);
                        if (page < 1) {
                            System.out.println("note: page numbers < 1 may give strange results");
                            System.exit(0);
                        }
                        pageResults(LinkGen.search(args[0],Integer.parseInt(args[1])));
                    }
                }
            } catch (NumberFormatException f) {
                System.out.println("Unrecognized input format");
            }
        } else {
            System.out.println("Unrecognized input format");
        }
        
    }
    
    /** Prints the number of results for a given search
     * @param url is the the exact, correct url of the search (first page of results)
     */
    public static void numOfResults(String url) throws IOException{
        Document doc = Jsoup.parse(new URL(LinkGen.search(url)),10000);
        Element center = doc.body().getElementById("centerPanel");
        Element total = center.getElementById("sortFiltersBox");
        Elements totals = total.children();
        Iterator<Element> tots = totals.iterator();
        while(tots.hasNext()){
            total = tots.next();
            if(total.className().equals("numTotalResults")) {
                String nums[] = (total.text()).split("(\\s+)");
                System.out.println("Number of results: "+nums[nums.length - 1]);          
            }
        }  
    }
    
    
    /** Prints out the main attributes of each result on a page
     * @param url is the correct, exact url of some search on some valid page
     */
    public static void pageResults(String url) throws IOException{
        Document doc = Jsoup.parse(new URL(url),10000);
        Element center = doc.body().getElementById("centerPanel");
        center = center.getElementById("searchResultsContainer");
        center = center.child(0);
        Elements result = center.children();
        SingleResult[] allResults = new SingleResult[result.size()-1];
         for(int i = 0; i < result.size() - 1; i++) {
            Elements items = result.get(i).getElementsByClass("gridItemBtm");
            Element productName = items.get(0).child(0).child(0);
            Elements productName2 = productName.children();
            
            String price = items.get(0).child(1).text();
            String pricetext[] = price.split("(\\s+)");
            
            Elements merchant = items.get(0).child(1).getElementsByClass("newMerchantName");
            Elements store = items.get(0).getElementsByClass("buyAtTxt");
            
            Element shipping = items.get(0).child(2);
            String shippingText = shipping.text();
            String shippingTextArray[] = shippingText.split("(\\s+)");
            String _title, _merchant, _price, _shipping;
                        
            if(productName2.size() == 0 || productName2.get(0).attr("class").equals("highlight")) {
                _title = productName.attr("title");
            } else {
                _title = productName2.get(0).attr("title");
            }
            _price = pricetext[0];
            
            if(store.size() < 1) {
                _merchant = merchant.get(0).text();
            } else {
                if(merchant.get(0).text().length() != 0) {
                    _merchant = merchant.get(0).text() + ", " + store.get(0).text();
                } else {
                    _merchant = store.get(0).text();
                }
            }
            
            if(shippingTextArray[0].equals("+")) {
                _shipping = shippingTextArray[1];
            } else {
                _shipping = shippingText;
            }
            allResults[i] = new SingleResult(_title, _price, _shipping, _merchant);
            allResults[i].print();
            System.out.println();
        }
    }
    
    /** Almost exactly the same as pageResults but returns an array of SingleResult 
     * objects containg the results for a page
     * @param url is the correct, exact url of some search on some valid page
     */
    public static SingleResult[] pageResultsArray(String url) throws IOException{
        Document doc = Jsoup.parse(new URL(url),10000);
        Element center = doc.body().getElementById("centerPanel");
        center = center.getElementById("searchResultsContainer");
        center = center.child(0);
        Elements result = center.children();
        SingleResult[] allResults = new SingleResult[result.size()-1];
         for(int i = 0; i < result.size() - 1; i++) {
            Elements items = result.get(i).getElementsByClass("gridItemBtm");
            Element productName = items.get(0).child(0).child(0);
            Elements productName2 = productName.children();
                      
            String price = items.get(0).child(1).text();
            String pricetext[] = price.split("(\\s+)");
            
            Elements merchant = items.get(0).child(1).getElementsByClass("newMerchantName");
            Elements store = items.get(0).getElementsByClass("buyAtTxt");
            
            Element shipping = items.get(0).child(2);
            String shippingText = shipping.text();
            String shippingTextArray[] = shippingText.split("(\\s+)");
            String _title, _merchant, _price, _shipping;           
            
            if(productName2.size() == 0 || productName2.get(0).attr("class").equals("highlight")) {
                _title = productName.attr("title");
            } else {
                _title = productName2.get(0).attr("title");
            }
            _price = pricetext[0];
            
            if(store.size() < 1) {
                _merchant = merchant.get(0).text();
            } else {
                 if(merchant.get(0).text().length() != 0) {
                    _merchant = merchant.get(0).text() + ", " + store.get(0).text();
                } else {
                    _merchant = store.get(0).text();
                }
            }
            
            if(shippingTextArray[0].equals("+")) {
                _shipping = shippingTextArray[1];
            } else {
                _shipping = shippingText;
            }
            allResults[i] = new SingleResult(_title, _price, _shipping, _merchant);
            allResults[i].print();
            System.out.println();
        }
        return allResults;
    }
    

}
