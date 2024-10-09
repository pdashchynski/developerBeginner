public without sharing class RemindContactOwners implements Database.Batchable<SObject>, Database.Stateful{

    public Map<Id, List<Contact>> ownerContactsMap = new Map<Id, List<Contact>>();

    public Database.QueryLocator start(Database.BatchableContext dbc) {
        return Database.getQueryLocator([SELECT Id, Name, OwnerId, Owner.Email FROM Contact WHERE IsPossiblyOutdated__c = true]);
    }

    public void execute(Database.BatchableContext dbc, List<Contact> contacts) {

        for(Contact c : contacts) {
            if (!ownerContactsMap.containsKey(c.OwnerId)) {
                ownerContactsMap.put(c.OwnerId, new List<Contact>());
            }
            ownerContactsMap.get(c.OwnerId).add(c);
        }
    }

    public void finish(Database.BatchableContext dbc) {
        EmailComposer.composeAndSend(ownerContactsMap);
    }
}