@isTest
private class TestSchedulableClass {
  public static String CRON_EXP = '0 0 0 15 3 ? 2022';
  
  static testmethod void test() {
    Test.StartTest();
    String jobId = System.schedule('ScheduleApexClassTest', CRON_EXP, new MySchedulableClass());
    CronTrigger ct = [select Id, CronExpression, TimesTriggered, NextFireTime
                      from CronTrigger
                      where id = :jobId];
    System.assertEquals(CRON_EXP, ct.CronExpression);
    System.assertEquals(0, ct.TimesTriggered);
    System.assertEquals('2022-03-15 00:00:00', String.valueOf(ct.NextFireTime));
    Merchandise__c[] ml = [SELECT Id FROM Merchandise__c
                           WHERE Name = 'Scheduled Job Item']; 
    System.assertEquals(ml.size(),0);                                        
    Test.StopTest();
    
    ml = [SELECT Id FROM Merchandise__c WHERE Name = 'Scheduled Job Item'];
    System.assertEquals(ml.size(), 1);
  }

}