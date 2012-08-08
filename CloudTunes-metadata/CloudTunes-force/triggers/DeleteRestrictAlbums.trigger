trigger DeleteRestrictAlbums on Album__c (before delete) {

   // With each of the albums targeted by the trigger that have tracks,
   // add an error to prevent them from being deleted.
   for (Album__c targetAlbum : [SELECT Id 
                                 FROM Album__c 
                                 WHERE Id IN (SELECT Album__c FROM Track__c) AND
                                       Id IN :Trigger.old]){
       Trigger.oldMap.get(targetAlbum.id).addError(
            'Cannot delete album with tracks');
            
   }  
}