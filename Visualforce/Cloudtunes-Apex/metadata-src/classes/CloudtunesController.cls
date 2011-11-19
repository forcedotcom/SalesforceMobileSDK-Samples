global with sharing class CloudtunesController {

    @RemoteAction
    global static List<Album__c> queryAlbums() {
    	 return [SELECT Id, Name, Price__c FROM Album__c ORDER BY Name LIMIT 20];
    }
    
    @RemoteAction
    global static List<Track__c> queryTracks(String albumId) {
         return [SELECT Id, Name, Price__c, Album__c, Album__r.Name FROM Track__c WHERE Album__c = :albumId ORDER BY CREATEDDATE LIMIT 200];
    }
}