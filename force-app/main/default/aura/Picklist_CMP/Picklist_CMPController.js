({
    doInit : function(component) {
        var action = component.get("c.getPickListValuesIntoList");
        var value = component.get('v.value');
        if(value == null) {
            value = '';
        }
        console.log(value);
        action.setParams({
            objectType: component.get("v.sObjectName"),
            selectedField: component.get("v.fieldName")
        });
        action.setCallback(this, function(response) {
            console.log(response.getReturnValue());
            var list = JSON.parse(response.getReturnValue());
            component.set("v.picklistValues", list);
            console.log(value);
            component.set('v.value',value);
        })
        $A.enqueueAction(action);
    }
})