/**
 * README
 * 
 * @author Inderjit Jutla 
 * @version 1.0 10/21/2013
 */

-----Summary-----
This code is used to crawl through the search results of shopping.com. Be sure to use included library for jsoup.
There are 2 explicit ways to query the results with this program:

Query 1: (requires a single argument)
java -jar Assignment.jar <keyword> (e.g. java -jar Assignment.jar "baby strollers")
Query 2: (requires two arguments)
java -jar Assignment.jar <keyword> <page number> (e.g. java -jar Assignment.jar "baby strollers" 2)

The code handles basic input errors such as extra arguments, no input, and invalid page numbers



-----Special Thanks to Jsoup-----
Jsoup was used to do the main parsing work and is
used extensively in this project



-----Assumptions-----
To function,  the code used to crawl through search results uses many assumptions about
the structure of the site and its html. I outline the main assumptions below:

-URL assumptions-
The URL is for shopping.com, main search only

The URL for the first page of results should be format:
"http://www.shopping.com/" + a + "/products?CLT=SCH"
where 'a' is the search term with the space(s) between words replace
by a single '-'

The URL for the nth result page should be formatted:
"http://www.shopping.com/" + a + "/products~PG-"+n
where 'a' is the search term with the space(s) between words replace
by a single '-'. And 'n' is the integer (> 0) number of the page. The page
indexing should start at 1. And page one should correspond to the same
page as the URL without the page number specified

The code only allows for number and letter searches. Shopping.com doesn't actually
seem to index by anything else but numbers and letters. In fact, if one enters a single
non-letter/number, it returns and invalid search

-HTML code assumptions-
All the results information is extracted from parsing throug the html of the page.
It would make the problem infinitely harder if one were not to assume any structure in 
the page or html with respect to search result attributes, assuming some structure 
would also be difficult and not always valid, thus the code assumes a very sepcific structure. 

The results should default to grid view (which appears to be typical as of now)

For number of results:
1) Firstly, all the results information must be contained within an element that has the unique id 'centerPanel'.
2) There must be an element, below the above one, with the unique id 'sortFilterBox'
3) The childen of the above element must include an element with the unique className 'numTotalResults'
4) The above element will contain the text that shows the current result numbers out off all of the result numbers
5) The last string (space delimited) in the above text must be the total number of pages

For result object and printing out all the result attributes:
1) Firstly, all the results information must be contained within an element that has the unique id 'centerPanel'.
2) Under the above element, there must be an element with the unique id 'searchResultsContainer'
3) There will be at least one child element below the above element
4) Under precisely the first child of the one mentioned in (3), there must (only) be the individual search results box elements
plus one additional misc element at the end
5) Each search result box element specified above, must contain an element with the unique class 'gridItemBtm'
6) The first child of the first child of the above element must contain the product name under the attribute 'title'
7) The text of the second child element of (5) must contain the price. The price should be the first String in 
the text (space delimited)
8) The second child of (5) must also contain an element with the unique classname "newMerchantName" which contains 
the name of the main merchant. And/or there must be an element under (5) with the unique classname 'buyAtTxt', whose text
shows how many stores you can buy from
9) The third child of element (5) must contain text that contains the shipping price (whether free or not). If not free, the text must
start with '+'

Any deviation from the assumptions for a valid url, especially after (2), is interpreted as the page number exceeding the number of results