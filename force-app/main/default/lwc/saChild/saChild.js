import { api, LightningElement } from 'lwc';

export default class saChild extends LightningElement {
    @api sainfo; //parentta sainfo'ya atama yapacagiz

    onClickSearch(){
    const selectEvent = new CustomEvent('sadetailview', {
        detail: this.sainfo.Id
    });
    this.dispatchEvent(selectEvent);
    }
    

}