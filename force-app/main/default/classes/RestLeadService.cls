@RestResource(urlMapping='/Leads/*')
global without sharing class RestLeadService {

    @HttpGet
    global static Lead getLead() {
        RestRequest req = RestContext.request;
        //String param = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
        Map <String, String> params = RestContext.request.params;

        Lead lead;

        try {
            lead = RestGetLead.getLeadByParameterMap(params);
            setResponse(200, 'Get request successfully completed');
        } catch (Exception e) {
            setResponse(404, e.getMessage());
        }
        return lead;
    }

    @HttpPost
    global static void postLead() {
        String requestBodyString = RestContext.request.requestBody.toString();

        try {
            TaskCreationRequest req = (TaskCreationRequest)System.JSON.deserialize(requestBodyString, TaskCreationRequest.class);
            Lead lead = RestGetLead.getLeadByParameter(req.leadIdentifier);

            Task newTask = new Task();
            newTask.Subject = req.taskBody;
            newTask.WhoId = lead.Id;
            insert newTask;
            setResponse(201, 'Task created successfully with Id: ' + newTask.Id);
        } catch (Exception e){
            setResponse(400, e.getMessage());
        }
    }

    private static void setResponse(Integer statusCode, String messageBody){
        RestContext.response.addHeader('Content-Type', 'application/json;charset=UTF-8');
        RestContext.response.statusCode = statusCode;
        RestContext.response.responseBody = Blob.valueOf(messageBody);
    }

    private class TaskCreationRequest {
        public String taskBody;
        public String leadIdentifier;
    }
}