public without sharing class RestGetLead {
    private static final String LEAD_ID_PREFIX = '00Q';

    public static Lead getLeadByParameter(String param) {

        if (String.isBlank(param)) {
            throw new HandledException('Lead Id or Email must be provided.');
        }

        return queryLead(param);
    }

    public static Lead getLeadByParameterMap(Map <String, String> params) {

        if (params == null || params.isEmpty()) {
            throw new HandledException('Lead Id or Email must be provided.');
        }

        String id = params.get('id');
        String email = params.get('email');     

        if (String.isNotBlank(id) && id.startsWith(LEAD_ID_PREFIX)) {
            return queryLead(id);
        } else if (String.isNotBlank(email)) {
            return queryLead(email);
        } else {
            throw new HandledException('Correct Lead Id or Email must be provided.');                
        }
    }

    private static Lead queryLead(String param) {
        List<Lead> leads;

        if (param.startsWith(LEAD_ID_PREFIX)) {
            leads = [SELECT Id, Email FROM Lead WHERE Id = :param WITH SECURITY_ENFORCED LIMIT 1];
        } else if (param.contains('@')) {
            leads = [SELECT Id, Email FROM Lead WHERE Email = :param WITH SECURITY_ENFORCED LIMIT 1];
        } else {
            throw new HandledException('Correct Lead Id or Email must be provided.');                
        }

        if (leads.isEmpty()) {
            throw new HandledException('No Lead found for the provided Id or Email.');
        }

        return leads[0];
    }
}