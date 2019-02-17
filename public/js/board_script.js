function showHideStuff() {
    
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
    
   var tile = document.getElementsByName("tile");
   var size = document.getElementById("tile_size");
   for (var i = 0; i < tile.length; i++) {
        if(size.value == 3){
            tile[i].style.height = "25%";
            tile[i].style.width = "85%";
        }else if(size.value == 5){
            tile[i].style.height = "16%";
            tile[i].style.width = "68%";
            tile[i].style.margin = "10px";
        }else if(size.value == 7){
            tile[i].style.height = "11%";
            tile[i].style.width = "68%";
            tile[i].style.margin = "10px";
        }else if(size.value == 9){
            tile[i].style.height = "8%";
            tile[i].style.width = "68%";
            tile[i].style.margin = "10px";
        }else if(size.value == 11){
            tile[i].style.height = "6%";
            tile[i].style.width = "68%";
            tile[i].style.margin = "10px";
        }else if(size.value == 13){
            tile[i].style.height = "6%";
            tile[i].style.width = "68%";
            tile[i].style.margin = "10px";
        }else if(size.value == 15){
            tile[i].style.height = "5%";
            tile[i].style.width = "60%";
            tile[i].style.margin = "10px";
        }
   }


    var autoMove = document.getElementById('bot_battle');
    var form = document.getElementById('main_form');
    if(autoMove.value == "bot battle"){
        form.submit();
    }
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
function gameRules() {
    document.getElementById("rules_modal").style.display = "block";
}
function closeModal() {
    document.getElementById("rules_modal").style.display = "none";
}

window.onclick = function(event) {
    var modal = document.getElementById("rules_modal");
    if (event.target == modal) {
        document.getElementById("rules_modal").style.display = "none";
    }
}