({
    createItem : function(component, event) {
        
        var validItem = component.find('CampingItemform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);   
        
        if(validItem) {
            console.log("valid items!");
            let newItem = component.get("v.newItem");
            let addItemEvt = component.getEvent("addItem");
            //let addItemEvt = $A.get("e.c:addItemEvent");
            addItemEvt.setParams({"item": newItem});
            addItemEvt.fire();   
            console.log("event fired!");
            console.log("addItemEvt: "+addItemEvt);
            
            //reset the new item form
            component.set("v.newItem",
                          {'sobjectType' : 'Camping_Item__c',
                           'Name' : '',
                           'Quantity__c' : 0,
                           'Price__c' : 0,
                           'Packed__c' : false});       
        } 
    }
})