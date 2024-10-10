public without sharing class OutdatedContactsEmailManager {

    public static void composeAndSendEmail(Map<String, List<Contact>> ownerContactsMap) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for (String ownerEmail : ownerContactsMap.keySet()) {
            List<Contact> contacts = ownerContactsMap.get(ownerEmail);

            String emailBody = 'Contacts that need review:<br/>';
            for (Contact c : contacts) {
                emailBody += '<a href=' + Url.getOrgDomainUrl().toExternalForm() + '/' + c.Id + '>' + c.Name + '</a><br/>';
            }

            emails.add(composeEmail(ownerEmail, emailBody));
        }

        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
    }

    private static Messaging.SingleEmailMessage composeEmail(String toAddress, String body) {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

        email.setToAddresses(new String[] { toAddress });
        email.setSubject('The list of possible outdated Contacts that needs review!');
        email.setHtmlBody(body);

        return email;
    }
}