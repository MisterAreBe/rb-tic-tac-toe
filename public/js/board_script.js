function showHideStuff() {
    var showBoard = document.getElementById('show_board');
    var showSetUp = document.getElementById('show_set_up');
    var showWinner = document.getElementById('show_winner');
    var showReset = document.getElementById('show_reset');
    var showOptions = document.getElementById('show_options');
    var board = document.getElementById('board');
    var setUp = document.getElementById('set_up');
    var winner = document.getElementById('winner');
    var reset = document.getElementById('reset');
    var options = document.getElementById('options');
    var showHide = [showBoard, showSetUp, showWinner, showReset, showOptions]
    var changeView = [board, setUp, winner, reset, options]

    for(var i = 0; i < showHide.length; i++) {
        if(showHide[i].value == 'show') {
            changeView[i].style.display = "block";
        }else if(showHide[i].value == 'hide') {
            changeView[i].style.display = "none";
        }
    }

    var showPlayers = document.getElementById('show_players');
    var player1 = document.getElementById('player1');
    var player2 = document.getElementById('player2');
    if(showPlayers.value == 'show') {
        player1.style.display = "inline-block";
        player2.style.display = "inline-block";
    }else if(showPlayers.value == 'hide') {
        player1.style.display = "none";
        player2.style.display = "none";
    }

    var x = document.getElementsByTagName('input');
    for(var i = 0; i < x.length; i++){
        if(x[i].type == 'radio'){
            if(x[i].checked == true){
                x[i].labels[0].style.color = 'red';
            }else if(x[i].checked == false){
                x[i].labels[0].style.color = 'goldenrod';
            }
        }
    }

    var tileSize = document.getElementById('tile_size');
    var grid = document.getElementsByTagName('td');
    tileSize = 100/tileSize.value;
    for(var i = 0; i < grid.length; i++) {
        grid[i].style.height = `${tileSize}%`;
        grid[i].style.width = `${tileSize}%`;
    }

    var autoMove = document.getElementById('bot_battle');
    var form = document.getElementById('main_form');
    if(autoMove.value == "bot battle"){
        form.submit();
    }
}
function setUp() {
    var form = document.getElementById('main_form');
    form.action = '/set_up';
    form.submit();
}
function startOver() {
    var form = document.getElementById('main_form');
    form.action = '/start_over';
    form.submit();
}
function resetBoard() {
    var form = document.getElementById('main_form');
    form.action = '/reset';
    form.submit();
}
function redMeUp() {
    var x = document.getElementsByTagName('input');

    for(var i = 0; i < x.length; i++){
        if(x[i].type == 'radio'){
            if(x[i].checked == true){
                x[i].labels[0].style.color = 'red';
            }else if(x[i].checked == false){
                x[i].labels[0].style.color = 'goldenrod';
            }
        }
    }
}