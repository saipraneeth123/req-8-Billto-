import { LightningElement,api,wire,track } from 'lwc';
import getCartShippingAddress from '@salesforce/apex/B2B_MyAddressSelectorFlowController.getCartShippingAddress';
//import getOrderShippingAddress from '@salesforce/apex/B2BAddressController.getOrderShippingAddress';

export default class Ship_to_OrderSummaryAddress extends LightningElement {
    @api cartId;
   
    @track shipTo;
    connectedCallback() {
       
            this.getCart(this.cartId);

    }
    getCart(cartId)
    {
        getCartShippingAddress({ cartId: cartId })
            .then(result => {
                // this.defaultAddr = result;
                this.shipTo = result;
                console.log(JSON.stringify(this.shipTo));
            })
            .catch(error => {
                console.log('** error' + JSON.stringify(error));
            });
    }
   
}