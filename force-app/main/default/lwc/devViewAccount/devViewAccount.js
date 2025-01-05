import { LightningElement, api } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
export default class DevViewAccount extends LightningElement {
    @api recordId;
    @api objectApiName;
    fields = ['AccountId', 'Name', 'Title', 'Phone', 'Email'];
}