@isTest
private class TestDeleteRestrictAlbums {
    // Random number generator
    static double getRandomNumber() {
        return Math.random(); 
    }

    // Album generator, with or without a track
    static Album__c createNewAlbum(Boolean withTrack) {
        // Create test album and insert it into the database
        Album__c album = new Album__c(name = 'Test' + getRandomNumber());
        insert album;
        
        // Create test track and insert it into the database, if withTrack == true
        if (withTrack) {
            Track__c track = new Track__c(
                name = 'Test' + getRandomNumber(), 
                Album__c = album.Id
            );
            insert track;
        }        
        return album;
    }
    
    // Single row album with no tracks => delete
    static testMethod void verifyAlbumNoTracksDelete(){    
        // Create test album and insert it
        Album__c album = createNewAlbum(false);
        
        // Delete the album, capture the result.
        Database.DeleteResult result = Database.delete(album, false);
        
        // Assert success, because target album has tracks.       
        System.assert(result.isSuccess());   
    }
    
    // Single row album with tracks => delete restrict
    static testMethod void verifyAlbumTracksRestrict(){    
        // Create test album and track and insert them
        Album__c album = createNewAlbum(true);
        
        // Delete the album, capture the result.
        Database.DeleteResult result = Database.delete(album, false);
        
        // Assert not success, because target album has tracks.       
        System.assert(!result.isSuccess());
    }
    
    // Bulk delete of album, one without tracks, another with
    static testMethod void verifyBulkAlbumDeleteRestrict(){    
        // Create two test albums, one with and without track
        Album__c[] albums = new List<Album__c>();
        albums.add(createNewAlbum(false));
        albums.add(createNewAlbum(true));
        
        // Delete the albums, opt_allOrNone = false, capture the results.
        Database.DeleteResult[] results = Database.delete(albums, false);
        
        // Assert success for first album       
        System.assert(results[0].isSuccess());   
        // Assert not success for second album
        System.assert(!results[1].isSuccess());
    }
}