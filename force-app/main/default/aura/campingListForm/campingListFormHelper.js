({
    createItem : function(component, event) {
        
        var validItem = component.find('CampingItemform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);   
        
        if(validItem) {
            
            var newItem = component.get("v.newItem");
            var addItem = component.getEvent("addItem");
            addItem.setParams({"item": newItem});
            addItem.fire();
            
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