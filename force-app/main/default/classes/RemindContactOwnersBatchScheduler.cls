public without sharing class RemindContactOwnersBatchScheduler implements Schedulable{

    public void execute(SchedulableContext sc) {
        RemindContactOwnersBatch batch = new RemindContactOwnersBatch();
        Database.executeBatch(batch, 200);
    }

    public static void schedule() {
        RemindContactOwnersBatchScheduler scheduler = new RemindContactOwnersBatchScheduler();
        String cronExp = '0 0 8 * * ?';
        System.schedule('Daily Outdated Contacts Batch', cronExp, scheduler);
    }
}