import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
// Import SA_Detail_TR1 object fields
import SUPERVISOR_FIELD from '@salesforce/schema/SA_Detail_TR1__c.Supervisor_TR1__c';

const saFields = [SUPERVISOR_FIELD];
export default class saSupervisor extends LightningElement {
	@api recordId; // Sa Id
	@wire(getRecord, { recordId: '$recordId', fields: saFields })sa;
	get supervisorId() {
		return getFieldValue(this.sa.data, SUPERVISOR_FIELD);
	}
}