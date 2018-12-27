trigger accountOwnerTrigger on Account (before insert) {
    for (Account accnt : trigger.new) {
        //the following code snippet is used to find the available user for account assignment
        List<User> availableUsers = [select Id
                                     from User
                                     where Id not in (select Account_User__c 
                                                      from Exclusion__c
                                                      where Available__c = false)
                                     and Assign_Round_Robin_Number__c > 0];
        Id ownerId = [select OwnerId from Account
                              order by createddate desc Limit 1][0].OwnerId;
   
        if( availableUsers.size() > 0 ){
            //System.debug(availableUsers);
            User assignedUser = [select Id, Account_Work_Load__c
                                 from User
                                 where Id in :availableUsers
                                 order by Account_Work_Load__c asc limit 1];
            if(assignedUser != null) {
                //System.debug(assignedUser);
                accnt.OwnerId = assignedUser.Id;
                assignedUser.Account_Work_Load__c += 1;
                update assignedUser;
                //System.debug([select Name from User where Id = :assignedUser.Id]);
            }
        }
    }
}