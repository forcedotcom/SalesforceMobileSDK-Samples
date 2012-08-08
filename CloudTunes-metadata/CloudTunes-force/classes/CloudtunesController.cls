/** 
* Apex Controller to provide relevant data binding to a Visualforce page.
**/
global with sharing class CloudtunesController {

    public String phoneGapUrl {
            get {
                String userAgent = ApexPages.currentPage().getHeaders().get('User-Agent');
                if (userAgent.contains('android'))
                    return 'phonegap-1.2.0-android.js';
                else
                    return 'phonegap-1.2.0-ios.js';
                    
                // iOS-specific checks that you could make.  Above, we assume it's iOS if it's not Android.
                //if (userAgent.contains('iPhone')
                //    || userAgent.contains('iPod')
                //    || userAgent.contains('iPad')
                //    || userAgent.contains('i386')
                //    || userAgent.contains('x86_64'))
                //    return 'phonegap-1.2.0-ios.js';
            }
    }

    /**
    * Method to query details of albums from the database.
    * returm the list of 20 albums with their Id, name and price information
    */
    @RemoteAction
    global static List<Album__c> queryAlbums() {
         return [SELECT Id, Name, Price__c FROM Album__c ORDER BY Name LIMIT 20];
    }
    
    /**
    * Method to query the list of tracks for a particular album.
    * returm the list of 200 tracks with their Id, name, price and album information
    */
    @RemoteAction
    global static List<Track__c> queryTracks(String albumId) {
         return [SELECT Id, Name, Price__c, Album__c, Album__r.Name FROM Track__c WHERE Album__c = :albumId ORDER BY CREATEDDATE LIMIT 200];
    }
    
    /** TEST METHODS **/
    public static testmethod void testController() {
        Album__c album = new Album__c(name = 'Title', Released_On__c=Date.newInstance(1965,08,06));
        insert album;
        
        Track__c track = new Track__c(name = 'Track title', album__c = album.id, Price__c = 1.99);
        insert track;
        
        List<Album__c> albums = queryAlbums();
        System.assert(albums != null && albums.size() > 0);
        
        List<Track__c> tracks = queryTracks(album.id);
        System.assert(tracks != null && tracks.size() > 0);
    }
}