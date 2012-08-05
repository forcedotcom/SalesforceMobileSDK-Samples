var currentTracks = new Array();
var currentAlbums = new Array();

var $j = jQuery.noConflict(); 

$j(document).ready(init);
    
function init() {
    if(window.location.href.indexOf('#') > 0) {
        window.location.href = window.location.href.split("#")[0];
    }
        
    $j.mobile.showPageLoadingMsg();
    getAlbums(function(){
        $j.mobile.hidePageLoadingMsg();
    });
}

function getAlbums(callback) {
    $j('#albumlist').empty();
    CloudtunesController.queryAlbums(function(records, e) { showAlbums(records, callback) }, {escape:true}); 
}

function showAlbums(records, callback) {
    currentAlbums.length = 0;
    for(var i = 0; i < records.length; i++) { currentAlbums[records[i].Id] = records[i]; }

    $j.each(records,
        function() {
        $j('<li></li>')
        .attr('id',this.Id)
        .hide()
        .append('<h2>' + this.Name + '</h2>')
        .click(function(e) {
            e.preventDefault();
            $j.mobile.showPageLoadingMsg();
            $j('#AlbumName').html(currentAlbums[this.id].Name);
            $j('#AlbumPrice').html('$'+currentAlbums[this.id].Price__c);
            if($j('#AlbumPrice').html().indexOf(".") > 0 && $j('#AlbumPrice').html().split(".")[1].length == 1) {
                                $j('#AlbumPrice').html($j('#AlbumPrice').html()+"0"); //add trailing zero
                            }
            $j('#AlbumId').val(currentAlbums[this.id].Id);
            var onTracksLoaded = function() {
                $j.mobile.hidePageLoadingMsg();
                $j.mobile.changePage('#detailpage', {changeHash: true});
            }
            getTracks(currentAlbums[this.id].Id, onTracksLoaded);
            })
        .appendTo('#albumlist')
        .show();
        });
    
    $j('#albumlist').listview('refresh');
    if(callback != null) { callback(); }
}


function getTracks(albumid, callback) {
     $j('#tracklist').empty();
     CloudtunesController.queryTracks(albumid,
            function(records, e) { showTracks(records,callback) }, {escape:true} );
     return true;
}

function showTracks(records, callback) {
    currentTracks.length = 0;
    for(var i = 0; i < records.length; i++) { currentTracks[records[i].Id] = records[i]; }

    $j.each(records, function() {
        $j('<li></li>')
        .hide()
        .attr('id',this.Id)
        .append(this.Name)
        .appendTo('#tracklist')
        .click(function(e) {
            e.preventDefault();
            $j.mobile.showPageLoadingMsg();
            $j('#TrackName').html(currentTracks[this.id].Name);
            $j('#TrackAlbum').html(currentTracks[this.id].Album__r.Name);
            $j('#TrackPrice').html('$'+currentTracks[this.id].Price__c);
            if($j('#TrackPrice').html().indexOf(".") > 0 && $j('#TrackPrice').html().split(".")[1].length == 1) {
                                $j('#TrackPrice').html($j('#TrackPrice').html()+"0"); //add trailing zero
                            }
            var onLoadComplete = function() {
                $j.mobile.hidePageLoadingMsg();
                $j.mobile.changePage('#trackpage', {changeHash: true});
            }
            setTimeout(onLoadComplete, 10);
        })
        .show();
    });
    
    console.log('Done ');
    if(callback != null) { console.log('Callback '); callback(); $j('#tracklist').listview('refresh'); }
}
