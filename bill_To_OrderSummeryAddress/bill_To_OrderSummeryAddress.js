import { LightningElement,api,wire,track } from 'lwc';
import getCartBillingAddress from '@salesforce/apex/B2B_MyAddressSelectorFlowController.getCartBillingAddress';
//import getOrderBillingAddress from '@salesforce/apex/B2BAddressController.getOrderBillingAddress';
export default class Bill_To_OrderSummeryAddress extends LightningElement {
    @api cartId;
   
    @track billTo;
    connectedCallback() {
        
        
            this.getCart(this.cartId);

    }

    getCart(cartId)
    {
        console.log('inside cart');
        console.log('oid'+cartId);
        getCartBillingAddress({ cartId: cartId })
            .then(result => {
                // this.defaultAddr = result;
                this.billTo = result;
                console.log(JSON.stringify(this.billTo));
            })
            .catch(error => {
                console.log('** error' + JSON.stringify(error));
            });
    }
   
}