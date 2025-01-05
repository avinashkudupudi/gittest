({
    handleCancel : function(component, event, helper)
    {
        component.destroy();
    },
    handleSubmit : function(component,event,helper){
        component.set('v.errorMsg','');
        var action = component.get("c.saveCase");
        action.setParams
        ({
            'caserec' : component.get('v.CaseRec'),
            'l1rec' : component.get('v.Level1Rec')
        });
        action.setCallback(this, function(response){
            var state =response.getState();
            console.log(state);
            if(state == 'SUCCESS'){
                helper.showInfoToast(component, event, helper, 'Update successful','success');
            } 
            else if (state === "ERROR")
            {
                helper.showInfoToast(component, event, helper, 'Unknown Error','Error');
            }
        
        });
        $A.enqueueAction(action);  
    },
    handleSuccess : function(component,event,helper)
    {
        helper.showToast('Record is Successfully Updated.', 'Success!', 'success');
        component.destroy();
    },
})