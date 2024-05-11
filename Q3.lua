function removeMemberFromParty(playerId, memberName) -- remove a member from the party
    local player = Player(playerId)
    local party = player:getParty()
    if not party then -- check if party is not nil
        warn("Party not found for playerId: " .. playerId)
        return
    end

    -- loop through the party members and remove the member with the given name
    local memberToRemove = Player(memberName) -- create a player object with the given name
    for _, member in pairs(party:getMembers()) do -- loop through the party members
        if member == memberToRemove then -- check if the member is the same as the player object
            party:removeMember(memberToRemove) -- remove the member from the party
            break -- exit the loop
        end
    end
end