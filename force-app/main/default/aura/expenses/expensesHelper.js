({
	createExpense : function(component, expense) {
        var action = component.get("c.saveExpense");
        action.setParams({"expense":expense});
		action.setCallback(this, function(response){
        var state = response.getState();
        if (component.isValid() && state === "SUCCESS") {
            var expenses = component.get("v.expenses");
            expenses.push(response.getReturnValue());
            component.set("v.expenses", expenses);
        }
    });
    $A.enqueueAction(action);
},

    validateExpenseForm: function(component) {
    	var validExpense = true;
    	var nameField = component.find("expname");
    	var expname = nameField.get("v.value");
    	if ($A.util.isEmpty(expname)){
        	validExpense = false;
        	nameField.set("v.errors", [{message:"Expense name can't be blank."}]);
    	}
    	else {
        	nameField.set("v.errors", null);
   		}

    	var amtField = component.find("amount");
    	var amt = amtField.get("v.value");
    	if ($A.util.isEmpty(amt) || isNaN(amt) || (amt <= 0.0)){
        	validExpense = false;
        	amtField.set("v.errors", [{message:"Enter an expense amount."}]);
   		}
    	else {
        	amtField.set("v.errors", null);
    	}
    	return(validExpense);
	}
})