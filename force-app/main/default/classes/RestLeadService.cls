@RestResource(urlMapping='/Leads/*')
global without sharing class RestLeadService {

    @HttpGet
    global static Lead getLead() {
        RestRequest req = RestContext.request;
        //String param = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
        Map <String, String> params = RestContext.request.params;
        String param = params.get('id');

        return RestGetLead.getLead(param);
    }

    @HttpPost
    global static String postLead() {
        String requestBodyString = RestContext.request.requestBody.toString();
        TaskCreationRequest req = (TaskCreationRequest)System.JSON.deserialize(requestBodyString, TaskCreationRequest.class);

        Lead lead = RestGetLead.getLead(req.leadIdentifier);

        Task newTask = new Task();
        if (lead!=Null) {
            newTask.Subject = req.taskBody;
            newTask.WhoId = lead.Id;
            insert newTask;
        }

        return 'Task created successfully with Id: ' + newTask.Id;
    }

    public class TaskCreationRequest {
        public String taskBody;
        public String leadIdentifier;
    }
}