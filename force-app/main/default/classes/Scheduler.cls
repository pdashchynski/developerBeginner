public without sharing class Scheduler implements Schedulable{

    public void execute(SchedulableContext sc) {
        RemindContactOwners batch = new RemindContactOwners();
        Database.executeBatch(batch, 200);
    }

    public static void schedule() {
        Scheduler scheduler = new Scheduler();
        String cronExp = '0 0 8 * * ?';
        System.schedule('Daily Outdated Contacts Batch', cronExp, scheduler);
    }
}