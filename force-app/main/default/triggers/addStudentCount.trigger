trigger addStudentCount on Registration__c (before insert) {
    System.debug('Hello World!');
}