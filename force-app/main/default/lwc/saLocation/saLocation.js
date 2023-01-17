import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
// Set SA_Detail_TR1 object fields
const NAME_FIELD = 'SA_Detail_TR1__c.Name_TR1__c';
const LOCATION_LATITUDE_FIELD = 'SA_Detail_TR1__c.Location_TR1__Latitude__s';
const LOCATION_LONGITUDE_FIELD = 'SA_Detail_TR1__c.Location_TR1__Longitude__s';

const saFields = [
	NAME_FIELD,
	LOCATION_LATITUDE_FIELD,
	LOCATION_LONGITUDE_FIELD
];
export default class saLocation extends LightningElement {
  @api recordId;
  
  name;
  mapMarkers = [];

  @wire(getRecord, { recordId: '$recordId', fields: saFields })
  loadSA({ error, data }) {
    if (error) {
      // TODO: handle error
    } else if (data) {
      // Get sa data
      this.name =  getFieldValue(data, NAME_FIELD);
      const Latitude = getFieldValue(data, LOCATION_LATITUDE_FIELD);
      const Longitude = getFieldValue(data, LOCATION_LONGITUDE_FIELD);
      // Transform sa data into map markers
      this.mapMarkers = [{
        location: { Latitude, Longitude },
        title: this.name,
        description: `Coords: ${Latitude}, ${Longitude}`
      }];
    }
  }
  get cardTitle() {
    return (this.name) ? `${this.name}'s location` : 'SA location';
  }
}