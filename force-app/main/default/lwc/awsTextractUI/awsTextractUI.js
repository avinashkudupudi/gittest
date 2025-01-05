import { LightningElement, track,api } from 'lwc';
import callTextractService from '@salesforce/apex/AmazonTextractService.callTextractService';
import getData from '@salesforce/apex/AmazonTextractService.getData';
import getOverview from '@salesforce/apex/AmazonTextractService.getOverview';

const columns = [   
    { label: 'Attribute', fieldName: 'key' },
    { label: 'Value', fieldName: 'value' },];

export default class awsTextractUI extends LightningElement {
    @api recordId;
    identityDocumentFields = [];
    isLoading = false;
    simpleMap = [];
    simpleMapStr;
    showDataCard = false;
    columns = columns;
    searchString;
    initialRecords = [];

    viewLease(){
        getData({ recordId: this.recordId,docType:'Lease' }).then((result) => {
            console.log('result', result);
            this.simpleMap = [];
            for (var key in result) {
                this.simpleMap.push({ key: key, value: result[key] });
                this.initialRecords.push({ key: key, value: result[key] });
                console.log('key', key, result[key]);
            }
            this.simpleMapStr = JSON.stringify(result, null, 2);
            this.showDataCard = true;
        }).catch((error) => {
            console.log(error);
        });
    }
    viewLedger(){
        getData({ recordId: this.recordId,docType:'Ledger' }).then((result) => {
            console.log('result', result);
            this.simpleMap = [];
            for (var key in result) {
                this.simpleMap.push({ key: key, value: result[key] });
                this.initialRecords.push({ key: key, value: result[key] });
                console.log('key', key, result[key]);
            }
            this.simpleMapStr = JSON.stringify(result, null, 2);
            this.showDataCard = true;
        }).catch((error) => {
            console.log(error);
        });
    }
    viewFAS(){
        getData({ recordId: this.recordId,docType:'FAS' }).then((result) => {
            console.log('result', result);
            this.simpleMap = [];
            for (var key in result) {
                this.simpleMap.push({ key: key, value: result[key] });
                this.initialRecords.push({ key: key, value: result[key] });
                console.log('key', key, result[key]);
            }
            this.simpleMapStr = JSON.stringify(result, null, 2);
            this.showDataCard = true;
        }).catch((error) => {
            console.log(error);
        });
    }
    
    getOverview(){
        getOverview({ recordId: this.recordId }).then((result) => {
            console.log('result', result);
            this.simpleMap = [];
            for (var key in result) {
                this.simpleMap.push({ key: key, value: result[key] });
                this.initialRecords.push({ key: key, value: result[key] });
                console.log('key', key, result[key]);
            }
            this.simpleMapStr = JSON.stringify(result, null, 2);
            this.showDataCard = true;
        }).catch((error) => {
            console.log(error);
        });
    }
    handleSearch(event){
        const searchKey = event.target.value.toLowerCase();
        if(searchKey){
            this.simpleMap = this.initialRecords;
            if(this.simpleMap){
                let recs = [];
                for(let rec of this.simpleMap){
                    if(rec.key.toLowerCase().includes(searchKey)){
                        recs.push(rec);
                    }
                }
                this.simpleMap = recs;
            }
        }
        else{
            this.simpleMap = this.initialRecords;
        }
    }

    handleTextract(){
        callTextractService({ recordId: this.recordId,docType:'Lease' }).then((result) => {
            console.log('result', result);
            this.simpleMap = [];
            for (var key in result) {
                this.simpleMap.push({ key: key, value: result[key] });
                console.log('key', key, result[key]);
            }
            this.simpleMapStr = JSON.stringify(result, null, 2);
            this.showDataCard = true;
        }).catch((error) => {
            console.log(error);
        });
    }
    handleLedger(){
        callTextractService({ recordId: this.recordId,docType:'Ledger' }).then((result) => {
            console.log('result', result);
            this.simpleMap = [];
            for (var key in result) {
                this.simpleMap.push({ key: key, value: result[key] });
                console.log('key', key, result[key]);
            }
            this.simpleMapStr = JSON.stringify(result, null, 2);
            this.showDataCard = true;
        }).catch((error) => {
            console.log(error);
        });
    }
    handleFAS(){
        callTextractService({ recordId: this.recordId,docType:'FAS' }).then((result) => {
            console.log('result', result);
            this.simpleMap = [];
            for (var key in result) {
                this.simpleMap.push({ key: key, value: result[key] });
                console.log('key', key, result[key]);
            }
            this.simpleMapStr = JSON.stringify(result, null, 2);
            this.showDataCard = true;
        }).catch((error) => {
            console.log(error);
        });
    }

    /*connectedCallback(){
        callTextractService().then(response =>{
            this.identityDocumentFields = (JSON.parse(response)[0]).IdentityDocumentFields;
            this.isLoading = false;
        }).catch();
    }

    renderedCallback() {
        this.videoElement = this.template.querySelector('.videoElement');
        this.canvasElement = this.template.querySelector('.canvas');
    }


    async initCamera() {
        if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
            try {
                this.videoElement.srcObject = await navigator.mediaDevices.getUserMedia({video: true, audio: false});
            } catch (error) {
                console.error('Error accessing the camera: ', JSON.stringify(error));
            }
        } else {
            console.error('getUserMedia is not supported in this browser');
        }
    }

    async captureImage() {
        if(this.videoElement && this.videoElement.srcObject !== null) {
            this.canvasElement.height = this.videoElement.videoHeight;
            this.canvasElement.width = this.videoElement.videoWidth;
            const context = this.canvasElement.getContext('2d');
            context.drawImage(this.videoElement, 0, 0, this.canvasElement.width, this.canvasElement.height);
            const imageData = this.canvasElement.toDataURL('image/png');
            const imageElement = this.template.querySelector('.imageElement');
            imageElement.setAttribute('src', imageData);
            imageElement.classList.add('slds-show');
            imageElement.classList.remove('slds-hide');
            const base64Canvas = imageData.split(';base64,')[1];
            this.isLoading = true;
            callTextractService({image : base64Canvas}).then(response => {
                this.identityDocumentFields = (JSON.parse(response)[0]).IdentityDocumentFields;
                this.isLoading = false;
            }).catch(error => {
                console.error('Error From Apex call ',error);
                this.isLoading = false;
            })

        }
    }

    async stopCamera(){
        const video = this.template.querySelector(".videoElement");
        video.srcObject.getTracks().forEach((track) => track.stop());
        video.srcObject = null;
        this.hideImageElement();
    }

    hideImageElement(){
        const imageElement = this.template.querySelector('.imageElement');
        imageElement.setAttribute('src', "");
        imageElement.classList.add('slds-hide');
        imageElement.classList.remove('slds-show');
    }*/
}