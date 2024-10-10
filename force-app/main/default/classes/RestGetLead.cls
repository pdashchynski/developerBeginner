public without sharing class RestGetLead {

    public static Lead getLeadByParameter(String param) {
        
        Lead lead;

        if (String.isBlank(param)) {
            throw new HandledException('Lead Id or Email must be provided.');
        }

        try {
            if (param.startsWith('00Q')) {
                lead = [SELECT Id, Email FROM Lead WHERE Id = :param WITH SECURITY_ENFORCED LIMIT 1];
            }
            else if (param.contains('@')) {
                lead = [SELECT Id, Email FROM Lead WHERE Email = :param WITH SECURITY_ENFORCED LIMIT 1];
            } else {
                throw new HandledException('Correct Lead Id or Email must be provided.');                
            }

            if (lead == null) {
                throw new HandledException('No Lead found for the provided Id or Email.');
            }
        } catch (QueryException e) {
            throw new HandledException('An error occurred while querying the Lead: ' + e.getMessage());
        } catch (Exception e) {
            throw new HandledException('An unexpected error occurred: ' + e.getMessage());
        }

        return lead;
    }

    public static Lead getLeadByParameterMap(Map <String, String> params) {
   
        Lead lead;

        if (params == null || params.isEmpty()) {
            throw new HandledException('Lead Id or Email must be provided.');
        }

        String id = params.get('id');
        String email = params.get('email');     

        try {
            if (String.isNotBlank(id) && id.startsWith('00Q')) {
                lead = [SELECT Id, Email FROM Lead WHERE Id = :id WITH SECURITY_ENFORCED LIMIT 1];
            }
            else if (String.isNotBlank(email)) {
                lead = [SELECT Id, Email FROM Lead WHERE Email = :email WITH SECURITY_ENFORCED LIMIT 1];
            } else {
                throw new HandledException('Correct Lead Id or Email must be provided.');                
            }

            if (lead == null) {
                throw new HandledException('No Lead found for the provided Id or Email.');
            }
        } catch (QueryException e) {
            throw new HandledException('An error occurred while querying the Lead: ' + e.getMessage());
        } catch (Exception e) {
            throw new HandledException('An unexpected error occurred: ' + e.getMessage());
        }

        return lead;
    }
}