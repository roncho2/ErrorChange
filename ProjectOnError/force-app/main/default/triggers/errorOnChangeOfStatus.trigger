trigger errorOnChangeOfStatus on Account  (before update) {

    Set<Id> accId = new Set<Id>();
    for(Account acc : trigger.new){

        //Checking if there is a change in Status field.
        if(acc.Status__c != trigger.oldMap.get(acc.Id).Status__C){
            accId.add(acc.Id);

        }
        
    }
    List<Account> accList = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id =:accId];
    if(accList.size()>0){
        for(Account a : accList){
            //Checking if there is a related Contact
            if(a.Contacts.size()>0){
                //Error message to shown
                trigger.new[0].addError('You can not Change the Stratus Field because the Account has Related Contacts');

            }

        }
    }







 }
   