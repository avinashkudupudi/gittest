({
	clickCreateExpense : function(component, event, helper) {
        if(helper.validateExpenseForm(component)){
            var newExpense = component.get("v.newExpense");
            helper.createExpense(component, newExpense);
        }            
	},
    
    doInit : function(component, event, helper){
        var action = component.get("c.getExpenses");
        //Action to be performed after async function is completed.
        //Handling server response.
        action.setCallback(this, function(response){
            var state = response.getState();
        	if (component.isValid() && state === "SUCCESS") {
            component.set("v.expenses", response.getReturnValue());
       		}
        	else {
            console.log("Failed with state: " + state);
            }
		});
        $A.enqueueAction(action);
	}
})