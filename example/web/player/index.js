function initPlayer() {
 
  

        console.log("init player111----->");

        var options = {
            plugins: {
                hotkeys: {
                  volumeStep: 0.1,
                  seekStep: 5,
                  enableModifiersForNumbers: false
                },
              },
            playbackRates: [0.5, 1, 1.5, 2],
            skipButtons: {
                forward: 5
              },
            //   autoplay: 'muted'
        };

        var player = videojs('player-1', options);
       

        player.on(['loadstart', 'play', 'playing', 'firstplay', 'pause', 'ended', 'adplay', 'adplaying', 'adfirstplay', 'adpause', 'adended', 'contentplay', 'contentplaying', 'contentfirstplay', 'contentpause', 'contentended', 'contentupdate'],
         function (e) {
            // console.warn('VIDEOJS player event: ', e.type);
        });


       

        player.httpSourceSelector(

        );


    
    

}


function setSrc( src ,srcType ) {
    const player = videojs.getPlayer('my-player');

    player.src({
        src:src,
        type: srcType,
    });

    
}


function play(  ) {
    const player = videojs.getPlayer('my-player');

    player.play();

    
}

function pause(  ) {
    const player = videojs.getPlayer('my-player');

    player.pause();

    
}


function getPosition(  ) {
    const player = videojs.getPlayer('my-player');

    let currentTime = player.currentTime();

return currentTime;
    
}

function getTotalDuration(  ) {
    const player = videojs.getPlayer('my-player');

    let duration = player.duration();

return duration;
    
}