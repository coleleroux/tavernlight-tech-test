function printSmallGuildNames(memberCount)
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    
    if resultId == false then -- check if resultId is not false
        print(string.format("No guilds that are found fewer than %s.", tostring(memberCount)))
        return
    end
    
    -- loop through the results, since the original function seemed to only print the first result.
    repeat
        local guildName = result.getDataString(resultId, "name")
        print(guildName)
    until not result.next(resultId)
    result.free(resultId) -- it's important that we free up resources to avoid memory leaks.
end