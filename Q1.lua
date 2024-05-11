local STORAGE_KEY = 1000 -- constant for storage key incase the value needs to be changed in the future

local function releaseStorage(player, storage_key) -- added storage_key to the function arguments
    if player then
        -- Only set the storage value if the player is valid
        player:setStorageValue(storage_key, -1)
    else
        -- Log a warning if the player is invalid
        warn("Invalid player")
    end
end

function onLogout(player)
    if type(player) == "table" and player.getStorageValue then -- Check if the player is valid
        if player:getStorageValue(STORAGE_KEY) == 1 then 
            -- If the player has the storage value set to 1, release the storage
            addEvent(releaseStorage, player, STORAGE_KEY) -- resorted the arguments to match the function signature
        end
    else
        warn(string.format("%s was not released", player:getName()))

        return false -- Return false to indicate that the logout handling was not successful
    end
    -- Always return true to indicate successful logout handling
    return true
end
