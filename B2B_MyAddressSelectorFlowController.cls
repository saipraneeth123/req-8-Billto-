public without sharing class B2B_MyAddressSelectorFlowController {
    //public B2B_MyAddressSelectorFlowController() {


 /*       @AuraEnabled
        public static List<ContactPointAddress> getShippingAddressesContactId(String cartId) {
           
    
        List<ContactPointAddress> shippingAddresses= [SELECT Id, Name, ParentId, BestTimeToContactEndTime, BestTimeToContactStartTime, BestTimeToContactTimezone, IsPrimary, AddressType, ContactPointPhoneId, Street, City, State, PostalCode, Country, Latitude, Longitude, GeocodeAccuracy, Address, IsDefault FROM ContactPointAddress WHERE AddressType='Shipping'  ORDER BY CREATEDDATE DESC LIMIT 200];
            return shippingAddresses;
        }
    
    @AuraEnabled
        public static List<ContactPointAddress> getBillingAddressesContactId(List<Id> contactIds) {
        
            List<ContactPointAddress> billingAddess= [SELECT Id, Name, ParentId, BestTimeToContactEndTime, BestTimeToContactStartTime, BestTimeToContactTimezone, IsPrimary, AddressType, ContactPointPhoneId, Street, City, State, PostalCode, Country, Latitude, Longitude, GeocodeAccuracy, Address, IsDefault FROM ContactPointAddress WHERE AddressType='Billing' ORDER BY CREATEDDATE DESC LIMIT 200];
            return billingAddess;
            
        }

        public with sharing class B2BAddressController {
            public B2BAddressController() {
        
            }*/
            @AuraEnabled(cacheable=true)
            public static List<ContactPointAddress> getShipToAddress(){
                try {
                    //String userid = UserInfo.getUserId();
                    User myUser=[Select Id,name,accountId  from user Where Id=:UserInfo.getUserId() ];
                    List<ContactPointAddress> shipTolist=[select Id,Name,isDefault,Street, city,State,country,postalCode from 
                    ContactPointAddress where ParentId='0018I00000IxrvsQAB' and AddressType='Shipping']; 
                    return shipTolist;
                    
                } catch (Exception e) {
                    throw new AuraHandledException(e.getMessage());
                }
            }


            @AuraEnabled(cacheable=true)
            public static List<ContactPointAddress> getBillToAddress(){
                try {
                    //String userid = UserInfo.getUserId();
                    User myUser=[Select Id,name,accountId  from user Where Id=:UserInfo.getUserId() ];
                    List<ContactPointAddress> billTolist=[select Id,Name,isDefault,Street, city,State,country,postalCode from 
                    ContactPointAddress where ParentId='0018I00000IxrvsQAB' and AddressType='Billing'];
                    return billTolist;
                    
                } catch (Exception e) {
                    throw new AuraHandledException(e.getMessage());
                }
            }


    //        @AuraEnabled(cacheable=true)

    // public static User getBuyerInfo(){

    //     try {



    //         User u=[Select Id,Name,accountId,email,phone ,Account.Name from user Where Id=:UserInfo.getUserId() Limit 1];//:UserInfo.getUserId() ];

    //         return u;

    //     } catch (Exception e) {

    //         throw new AuraHandledException(e.getMessage());

    //     }

    // }

    @AuraEnabled
    public static String createShipToAddress(String name,String street,String city,String state,
                                                 String country,String postalCode){
        try{
        User u=[Select Id,name,accountId  from user Where Id='0058I000000ugfEQAQ'];
        ContactPointAddress shippingAddress=new ContactPointAddress();
        shippingAddress.name=name;
        shippingAddress.street=street;
        shippingAddress.city=city;
        shippingAddress.state=state;
        shippingAddress.country=country;
        shippingAddress.postalCode=postalCode;
        shippingAddress.AddressType='Shipping';
        shippingAddress.ParentId='0018I00000IxrvsQAB';
        insert shippingAddress;
        return shippingAddress.id;
    }
        catch(Excpetion e ){
            throw new AuraHandleExcpetion(e.getMessage());
        }
    }

 

@AuraEnabled(cacheable=true)
    public static User getBuyerInfo(){

            User u=[Select Id,Name,accountId,email,phone ,Account.Name, Contact.Name from user Where Id=:'0058I000000ugfEQAQ'];//:UserInfo.getUserId() ];
            return u;
    }



    @AuraEnabled
    public static WebCart getCartBillingAddress(String cartId){
       
            WebCart billTo= [select Id ,Name,  BillingStreet, BillingCity, BillingState, BillingCountry,
            BillingPostalCode from WebCart where Id=:cartId];
           return billTo;
       
    }

    @AuraEnabled
    public static CartDeliveryGroup getCartShippingAddress(String cartId){
       
            CartDeliveryGroup shipTo= [select Id,DeliverToName, DeliverToStreet, DeliverToCity, DeliverToState, DeliverToCountry ,DeliverToPostalCode  from 
            CartDeliveryGroup where CartId =:cartId];
           return shipTo;
    }

    //updateBillToAddress

    @AuraEnabled

    public static string updateBillToAddress(String cartId,String contactPointAddressId){
        try{
            ContactPointAddress billToAddlist=[select Id,Name,isDefault,Street, City,State,country,PostalCode from

            ContactPointAddress where Id=:contactPointAddressId and AddressType='Billing' Limit 1];

            WebCart billingCartAddress= [select Id ,Name,  BillingStreet, BillingCity, BillingState, BillingCountry,

            BillingPostalCode from WebCart where Id=:cartId];

            billingCartAddress.BillingStreet=billToAddlist.Street;

            billingCartAddress.BillingCity=billToAddlist.City;

            billingCartAddress.BillingState=billToAddlist.State;

            billingCartAddress.BillingCountry=billToAddlist.Country;

            billingCartAddress.BillingPostalCode=billToAddlist.PostalCode;

            update billingCartAddress;

            return 'Cart Bill to address has succesfully updated';
        }
        catch(Exception e ){
            throw new AuraHandleExcpetion(e.getMessage());
        }

           

    }


    @AuraEnabled

    public static string updateShipToAddress(String cartId,String contactPointAddressId){
        try{
        ContactPointAddress shippingAddresslist=[select Id,Name,isDefault,Street, City,State,country,PostalCode from

        ContactPointAddress where Id=:contactPointAddressId and AddressType='Shipping' Limit 1];

        CartDeliveryGroup cartAddress=[select Id,DeliverToName, DeliverToStreet, DeliverToCity, DeliverToState, DeliverToCountry ,DeliverToPostalCode  from

        CartDeliveryGroup where CartId =:cartId];

        cartAddress.DeliverToName=shippingAddresslist.Name;

        cartAddress.DeliverToStreet=shippingAddresslist.Street;

        cartAddress.DeliverToCity=shippingAddresslist.City;

        cartAddress.DeliverToState=shippingAddresslist.State;

        cartAddress.DeliverToCountry=shippingAddresslist.Country;

        cartAddress.DeliverToPostalCode=shippingAddresslist.PostalCode;

        update cartAddress;

        return 'succesfully updated';
        }
        catch(Exception e ){
            throw new AuraHandleException(e.getMessage());
        }

           

    }
        

}
