public without sharing class RemindContactOwnersBatch implements Database.Batchable<SObject>, Database.Stateful{

    public Map<String, List<Contact>> ownerContactsMap = new Map<String, List<Contact>>();

    public Database.QueryLocator start(Database.BatchableContext dbc) {
        return Database.getQueryLocator([SELECT Id, Name, Owner.Email FROM Contact WHERE IsPossiblyOutdated__c = true]);
    }

    public void execute(Database.BatchableContext dbc, List<Contact> contacts) {

        for(Contact c : contacts) {
            if (!ownerContactsMap.containsKey(c.Owner.Email)) {
                ownerContactsMap.put(c.Owner.Email, new List<Contact>());
            }
            ownerContactsMap.get(c.Owner.Email).add(c);
        }
    }

    public void finish(Database.BatchableContext dbc) {
        OutdatedContactsEmailManager.composeAndSendEmail(ownerContactsMap);
    }
}