({
	clickCreateCampingItem : function(component, event, helper) {
        var validItem = true;
        var nameValue = component.find("itemname");
        var itemname = nameValue.get("v.value");
        var quantityValue = component.find("quantity");
        var quantity = quantityValue.get("v.value");
        var priceValue = component.find("price");
        var price = priceValue.get("v.value");
        if($A.util.isEmpty(itemname) || $A.util.isEmpty(quantity) || $A.util.isEmpty(price)){
            validItem = false;
            nameValue.set("v.errors", [{message:"item name can't be blank"}]); 
        }
        else{
            nameValue.set("v.errors", null);
        }
        
        if(validItem){
            //var Item = component.get("v.newItem");
            //var Items = component.get("v.items");
            //console.log("create expense :" +JSON.stringify(newItem));
            //var newItem = JSON.parse(JSON.stringify(Item));
            //Items.push(newItem);
            //component.set("v.items", Items);
            //component.set("v.newItem",{sObjectType:'Camping_Item__c', 
            //                          Name:'',Quantity__c:0,price__c:0,
            //                           Packed__c:false});
            var newItem = component.get("v.newItem");                           
            helper.createItem(component, newItem);
        } 
		
	},
    
    doInit : function(component, event, helper){
        var action = component.get("c.getItems");
        //Action to be performed after async function is completed.
        //Handling server response.
        action.setCallback(this, function(response){
            var state = response.getState();
        	if (component.isValid() && state === "SUCCESS") {
            component.set("v.items", response.getReturnValue());
       		}
        	else {
            console.log("Failed with state: " + state);
            }
		});
        $A.enqueueAction(action);
	}
})