({
	showInfoToast : function(component, event, helper, msg, title) 
    {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : title,
            message: msg,
            messageTemplate: 'Record {0} created! See it {1}!',
            duration:' 5000',
            key: 'info_alt',
            type: title,
            mode: 'dismissible'
        });
        toastEvent.fire();
    }
})