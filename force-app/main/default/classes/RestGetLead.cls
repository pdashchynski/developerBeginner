public without sharing class RestGetLead {

    public static Lead getLead(String param) {
        
        Lead lead;

        if (String.isNotBlank(param)) {
            if (param.contains('@')) {
                lead = [SELECT Id, Email FROM Lead WHERE Email = :param WITH SECURITY_ENFORCED LIMIT 1];
            } else if (param.startsWith('00Q')) {
                lead = [SELECT Id, Email FROM Lead WHERE Id = :param WITH SECURITY_ENFORCED LIMIT 1];
            } else {
                throw new HandledException('Correct Lead Id or Email must be provided.');                
            }
        } else {
            throw new HandledException('Lead Id or Email must be provided.');
        }

        return lead;
    }
}