import { LightningElement, wire } from 'lwc';
import { subscribe, unsubscribe, MessageContext } from 'lightning/messageService';
import SA_LIST_MESSAGE from '@salesforce/messageChannel/SAmessageChannel__c';
export default class saMap extends LightningElement {
  mapMarkers = [];
  subscription = null;
  @wire(MessageContext)
  messageContext;
  connectedCallback() {
    // Subscribe to SAmessageChannel__c message
    this.subscription = subscribe(
        this.messageContext,
        SA_LIST_MESSAGE,
        (message) => {
            this.handleListUpdate(message);
        });
  }
  disconnectedCallback() {
    // Unsubscribe from SAmessageChannel__c message
    unsubscribe(this.subscription);
    this.subscription = null;
  }
  handleListUpdate(message) {
    this.mapMarkers = message.agents.map(sainfo => {
      const Latitude = sainfo.Location_TR1__Latitude__s;
      const Longitude = sainfo.Location_TR1__Longitude__s;
      return {
        location: { Latitude, Longitude },
        title: sainfo.Name_TR1__c,
        description: `Coords: ${Latitude}, ${Longitude}`,
        icon: 'standard:avatar'
      };
    });
  }
}