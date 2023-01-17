import { publish, MessageContext } from 'lightning/messageService';//Mesaj iÃ§eriÄŸini oluÅŸturmak ve gÃ¶ndermek iÃ§in kullanÄ±lan message service metodlarÄ±nÄ± import ediyoruz.
import SA_LIST_MESSAGE from '@salesforce/messageChannel/SAmessageChannel__c';//oluÅŸturduÄŸumuz message channeli kullanabilmek iÃ§in import etmemiz gerekiyor.
import { LightningElement, wire } from 'lwc';
import getSa from '@salesforce/apex/saDetailController.getSaDetails';
import findSaDetails from '@salesforce/apex/saDetailController.findSaDetails';
import { NavigationMixin } from 'lightning/navigation';


export default class saParent extends NavigationMixin (LightningElement) {
    sainfos;
    @wire(MessageContext) messageContext;

    @wire (getSa) 
    loadSA(result) {
        this.sainfos = result;
        if (result.data) {
    const message = {
        agents: result.data
    };
    publish(this.messageContext, SA_LIST_MESSAGE, message);
  }
};

    searchKey='';
    sainfos2;
    error;
   
    
    handleKeyChange(event){
        this.searchText=event.detail.value;
        findSaDetails({ searchKey: this.searchText })
            .then((result) => {
                this.sainfos2 = result;
                this.error = undefined;
                const message = {
                    agents: result
                };
                publish(this.messageContext, SA_LIST_MESSAGE, message);

            })
            .catch((error) => {
                this.error = error;
                this.sainfos2 = undefined;
            });
               
    }
    
    handlesaDetailView(event) {
		
		const recId = event.detail;
		
		this[NavigationMixin.Navigate]({
			type: 'standard__recordPage',
			attributes: {
				recordId: recId,
				objectApiName: 'SA_Detail_TR1__c',
				actionName: 'view',
			},
		});
    }
        

    

}