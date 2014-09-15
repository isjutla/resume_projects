
/**
 * Results object to contain main details of a result
 * 
 * @author Inderjit Jutla 
 * @version 1.0 10/21/2013
 */
class SingleResult
{
    private String ProductName;
    private String price;
    private String shipping;
    private String Vendor;
  
    /** Main Constructor for SingleResult object
     * @param _name is the name of the product
     * @param _price is the price of the product (may include '$' sign)
     * @param _ship is the shippping cost (may includ '$' sign)
     * @param _vendor is the name of the vendor, including number of additions stors
     */
    public SingleResult(String _name, String _price, String _ship, String _vendor)
    {
        ProductName = _name;
        price = _price;
        shipping = _ship;
        Vendor = _vendor;
    }
    
   /** Prints out the attributes of the SingleResults object in a convienent format
    */
    public void print() {
        System.out.println("Product Name: "+ProductName);
        System.out.println("Price: "+price);
        if(shipping.length() == 0) {
            System.out.println("shipping cost: (No shipping cost listed)");
        } else {
            System.out.println("shipping cost: "+shipping);
        }
        System.out.println("Vendor: "+Vendor);
    }

    
}
