public without sharing class RestGetLead {

    public static Lead getLeadByParameter(String param) {
        
        List<Lead> leads;

        if (String.isBlank(param)) {
            throw new HandledException('Lead Id or Email must be provided.');
        }

        if (param.startsWith('00Q')) {
            leads = [SELECT Id, Email FROM Lead WHERE Id = :param WITH SECURITY_ENFORCED];
        }
        else if (param.contains('@')) {
            leads = [SELECT Id, Email FROM Lead WHERE Email = :param WITH SECURITY_ENFORCED];
        } else {
            throw new HandledException('Correct Lead Id or Email must be provided.');                
        }

        if (leads.isEmpty()) {
            throw new HandledException('No Lead found for the provided Id or Email.');
        }

        return leads[0];
    }

    public static Lead getLeadByParameterMap(Map <String, String> params) {
   
        List<Lead> leads;

        if (params == null || params.isEmpty()) {
            throw new HandledException('Lead Id or Email must be provided.');
        }

        String id = params.get('id');
        String email = params.get('email');     

        if (String.isNotBlank(id) && id.startsWith('00Q')) {
            leads = [SELECT Id, Email FROM Lead WHERE Id = :id WITH SECURITY_ENFORCED LIMIT 1];
        }
        else if (String.isNotBlank(email)) {
            leads = [SELECT Id, Email FROM Lead WHERE Email = :email WITH SECURITY_ENFORCED LIMIT 1];
        } else {
            throw new HandledException('Correct Lead Id or Email must be provided.');                
        }

        if (leads.isEmpty()) {
            throw new HandledException('No Lead found for the provided Id or Email.');
        }

        return leads[0];
    }
}