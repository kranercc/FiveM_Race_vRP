/*
DATE: 12.09.2021
AUTHOR: KRANE IC (krane#2890)
<!> <!> <!>
! ROMANIA !
<!> <!> <!> 
*/

$(function() {
    var data = {}
    data.lobby = {}
    function send_data() { $.post('https://race/race_main',JSON.stringify(data)) }
    function display(bool) {
        if (bool) {
            $("#container").show()
        }else{
            $("#container").hide()
        }
    }
    display(false)
    
    $("#btnClose").click(function () {
        $.post('https://race/exit', JSON.stringify({}));
        return
    })
    //https://www.youtube.com/watch?v=YpMCoTgyRTs viata mea nu-i un aaaaaeeeeeeeroooooooooport cine pleaca sa plece de tot
    $("#btnAeroport").click(function () {
            var zoom = false;
            resert_verified()
            var liniuta = document.createElement("img")
            liniuta.innerText = "Liniuta"
            liniuta.src = "images/liniuta.png"
            liniuta.id = "btnLiniuta"
            liniuta.className = "btnNewFromImg"
            liniuta.onclick = function () {
                if (zoom) { // pfu pe mine de destept
                    $("#btnAeroport").show()
                    $("#btnAvansat").remove()
                    $("#btnLiniuta").remove()
                    //change class name of btnAeroport
                    $("#btnAeroport").addClass("verifiedMap")
                    data.game_mode = "Aeroport Liniuta"
                }
                if (!zoom) {
                    liniuta.className = "btnNewFromImg zoom"
                    $("#btnAvansat").hide()
                }
                zoom = !zoom;                
            }
            var avansat = document.createElement("img")
            avansat.innerText = "Avansat"
            avansat.id = "btnAvansat"
            avansat.src = "images/avansat.png"
            avansat.className = "btnNewFromImg"
            avansat.onclick = function () {
                if (zoom) { // pfu pe mine de destept
                    $("#btnAeroport").show()
                    $("#btnAvansat").remove()
                    $("#btnLiniuta").remove()
                    //change class name of btnAeroport
                    $("#btnAeroport").addClass("verifiedMap")
                    data.game_mode = "Aeroport Avansat"

                }
                if (!zoom) {
                    avansat.className = "btnNewFromImg zoom"
                    $("#btnLiniuta").hide()
                }
                zoom = !zoom; 
            }
            // move the buttons into the container
            $("#game_mods").append(liniuta)
            $("#game_mods").append(avansat)
            //remove the img button from there
            $("#btnAeroport").hide()

        return
    })

    //vinewood hills
    $("#btnVinewood").click(function () {
            var zoom = false;
            resert_verified()
            var vinewood_race = document.createElement("img")
            vinewood_race.innerText = "VineWood"
            vinewood_race.src = "images/vinewood_hills.png"
            vinewood_race.id = "btnVinewoodrace"
            vinewood_race.className = "btnNewFromImg"
            vinewood_race.onclick = function () {
                if (zoom) { // pfu pe mine de destept
                    $("#btnVinewood").show()
                    $("#btnVinewoodrace").remove()
                    //change class name of btnAeroport
                    $("#btnVinewood").addClass("verifiedMap")
                    data.game_mode = "Vinewood Race"
                }
                if (!zoom) {
                    vinewood_race.className = "btnNewFromImg zoom"
                }
                zoom = !zoom;                
            }
            // move the buttons into the container
            $("#game_mods_vinewood").append(vinewood_race)
            //remove the img button from there
            $("#btnVinewood").hide()
            return
    })
    
    //sandy shores
    $("#btnSandy").click(function() {

        var zoom = false;
        resert_verified()
        var sandy_race = document.createElement("img")
        sandy_race.innerText = "sandy"
        sandy_race.src = "images/sandyrace.png"
        sandy_race.id = "btnSandyrace"
        sandy_race.className = "btnNewFromImg"
        sandy_race.onclick = function () {
            if (zoom) { // pfu pe mine de destept
                $("#btnSandy").show()
                $("#btnSandyrace").remove()
                //change class name of btnAeroport
                $("#btnSandy").addClass("verifiedMap")
                data.game_mode = "Sandy Shores Race"
            }
            if (!zoom) {
                sandy_race.className = "btnNewFromImg zoom"
            }
            zoom = !zoom;                
        }
        // move the buttons into the container
        $("#game_mods_sandy").append(sandy_race)
        //remove the img button from there
        $("#btnSandy").hide()
        return
    })

    window.addEventListener("message", function(event) {
        var item = event.data
        if (item.type == "raceui") {
            if (item.status == true) {
                display(true)

            }else{
                display(false)
            }
            
        }

    }, false);

    document.onkeyup = function(data) {
        if (data.key == "Escape") {
            display(false)
            send_data()
            $.post("https://race/exit") // it triggers here

            // fetch(`https://${GetParentResourceName()}/exit`, { //if you remove this it all goes to shit
            //     method: 'POST',
            //     headers: {
            //         'Content-Type': 'application/json; charset=UTF-8',
            //     },
            //     body: JSON.stringify({
            //         itemId: 'lol'
            //     })
            // }).then(resp => resp.json()).then(resp => console.log(resp));
            

        }
    }

    function resert_verified()
    {
        $("#btnAeroport").removeClass("verifiedMap")
        $("#btnVinewood").removeClass("verifiedMap")
        $("#btnSandy").removeClass("verifiedMap")
    }

    // lobby area
    $("#playerInviteButton").click(function () {
        //get the player name
        var playerName = $("#playerSelectorText").val()
        var bet = $("#moneybet").val()
        //if it doesn't exists already
        if ($(`#playerinfo_${playerName}`).val() == "") {
            return
        }
        $("#playerList").append(`<div class="playerInfo" id="playerinfo_${playerName}">`)
        $(`#playerinfo_${playerName}`).append(`<h4 class="text player_data"> ${playerName}</h4>`)
        $(`#playerinfo_${playerName}`).append(`<h4 class="text player_data"> ${bet}</h4>`)
        data.lobby[playerName] = bet;
    })
    $("#playerKickButton").click(function () {
        //remove the playerinfo from playerlist
        var playerName = $("#playerSelectorText").val()
        $(`#playerinfo_${playerName}`).remove()
        data.lobby[playerName] = null;
    })
})

