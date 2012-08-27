// This file assumes that all of the javascript and css files required
// as well as the required DOM objects are included on the page.

var ALBUMS_SOUP_NAME = "ct__albumsSoup";
var TRACKS_SOUP_NAME = "ct__tracksSoup";

function getUrlParamByName(name) {
  name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
  var regexS = "[\\?&]" + name + "=([^&#]*)";
  var regex = new RegExp(regexS);
  var results = regex.exec(window.location.search);
  if(results == null)
    return "";
  else
    return decodeURIComponent(results[1].replace(/\+/g, " "));
}

function hasSmartstore() {
    if (PhoneGap.hasResource("smartstore") && navigator.smartstore) {
        console.log("SmartStore plugin found and loaded");
        return true;
    }
    return false;
}

function resetOfflineStore() {
    if (SFHybridApp.deviceIsOnline()) {
        clearOfflineSoups(regOfflineSoups);
    }
}

function regOfflineSoups() {
      
    if (hasSmartstore()) {
    
        console.log("Registering soups");
        
        //Registering soup 1 for storing albums
        var indexesAlbums = [
            {path:"Name",type:"string"},
            {path:"Id",type:"string"}
        ];
        
        navigator.smartstore.registerSoup(ALBUMS_SOUP_NAME,
                                        indexesAlbums,                                  
                                        onSuccessRegSoup, 
                                        onErrorRegSoup);

        //Registering soup 2 for storing tracks
        var indexesTracks = [
            {path:"Name",type:"string"},
            {path:"Id",type:"string"},
            {path:"Album__c",type:"string"}
        ];
        navigator.smartstore.registerSoup(TRACKS_SOUP_NAME,
                                        indexesTracks,                                  
                                        onSuccessRegSoup, 
                                        onErrorRegSoup);
    }
}

function clearOfflineSoups(cb) {
      
    if (hasSmartstore()) {
    
      var cbCount = 0;
      var success = function() {
        console.log('cleared soup');
        if(++cbCount == 2 && typeof cb == 'function') cb();
      }
      navigator.smartstore.removeSoup(ALBUMS_SOUP_NAME, success, onErrorRemoveSoup);
      navigator.smartstore.removeSoup(TRACKS_SOUP_NAME, success, onErrorRemoveSoup);
    }
}

function addOfflineAlbums(entries, success, error) {
    if (hasSmartstore())
        navigator.smartstore.upsertSoupEntries(ALBUMS_SOUP_NAME,entries,
                                           success,
                                           error);
                
}


function addOfflineTracks(entries, success, error) {
    if (hasSmartstore())
        navigator.smartstore.upsertSoupEntries(TRACKS_SOUP_NAME,entries,
                                           success,
                                           error);
}

function fetchOfflineAlbums(success, error) {
    if (hasSmartstore()) {
        var querySpec = navigator.smartstore.buildAllQuerySpec("Name", null, 20);
        
        navigator.smartstore.querySoup(ALBUMS_SOUP_NAME,querySpec,
                                           function(cursor) { onSuccessQuerySoup(cursor, success); },
                                           error);
    }
}

function fetchOfflineTracks(albumId, success, error) {
    if (hasSmartstore()) {
        var querySpec = navigator.smartstore.buildExactQuerySpec("Album__c", albumId, 20);
        
        var querySuccess = function(cursor) {
            var curPageEntries = cursor.currentPageOrderedEntries;
            var entries = [];
        
            $j.each(curPageEntries, function(i,entry) {
                   entries.push(entry);
            });
            success(entries);
        }
                                    
        navigator.smartstore.querySoup(TRACKS_SOUP_NAME,querySpec,
                                           function(cursor) { onSuccessQuerySoup(cursor, success); },
                                           error);
    }
}

function onSuccessRegSoup(param) {
    console.log("onSuccessRegSoup: " + param);
}

function onErrorRegSoup(param) {
    console.log("onErrorRegSoup: " + param);
}

function onSuccessQuerySoup(cursor, success) {
    var entries = [];
    
    function onCursorIterationFinished() {
        success(entries);
    }
        
    function addEntriesFromCursor(cursor) {
        if (cursor.currentPageIndex < cursor.totalPages) {
            var curPageEntries = cursor.currentPageOrderedEntries;
            $j.each(curPageEntries, function(i, entry) {
                entries.push(entry);
            });
            if (cursor.currentPageIndex == cursor.totalPages - 1) {  // Last page, finish up.
                navigator.smartstore.closeCursor(cursor, onCursorIterationFinished);
            } else {
                navigator.smartstore.moveCursorToNextPage(cursor, addEntriesFromCursor);
            }
        }
    }
    
    // If there are no entries initially, just return to the success callback.
    if (!cursor || cursor.totalPages == 0) {
        if (cursor) {
            navigator.smartstore.closeCursor(cursor, onCursorIterationFinished);
        } else {
            onCursorIterationFinished();
        }
    } else {
        addEntriesFromCursor(cursor);
    }
}

function onErrorRemoveSoup(param) {
    console.log("onErrorRemoveSoup: " + param);
}