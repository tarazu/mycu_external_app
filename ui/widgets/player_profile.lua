local ffi = require("ffi")
local C = ffi.C

local output = {}

function output.handle()
    local playersector = C.GetContextByClass(C.GetPlayerID(), "sector", false)
    local sectorownerFaction = GetComponentData(ConvertStringTo64Bit(tostring(playersector)), "owner");
    local data = {
        name = ffi.string(C.GetPlayerName());
        factionname = ffi.string(C.GetPlayerFactionName(true));
        credits = GetPlayerMoney();
        sectorname = ffi.string(C.GetComponentName(playersector));
        sectorowner = GetFactionData(sectorownerFaction, "shortname");
        -- location will be where the player is
        location = ffi.string(C.GetComponentName(C.GetPlayerContainerID()));
        -- class will be ship class or station
        locationclass = ffi.string(C.GetComponentClass(C.GetPlayerContainerID()));
        -- location parent will be the station or ship we have docked at
        locationparent = ffi.string(C.GetComponentName(C.GetTopLevelContainer(C.GetPlayerContainerID())));
        -- last controlled ship will remain the ship after exiting to a station
        lastcontrolledship = ffi.string(C.GetComponentName(C.GetLastPlayerControlledShipID()));
    }

    return data;
end

return output