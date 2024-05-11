void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId) {
    Player* player = g_game.getPlayerByName(recipient);
    bool isNewPlayer = false;

    if (!player) {
        player = new Player(nullptr);
        isNewPlayer = true;
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player; // Delete the newly created player if loading fails
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        if (isNewPlayer) {
            delete player; // Delete the newly created player if item creation fails
        }
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }

    if (isNewPlayer) {
        delete player; // Delete the newly created player after use if it was created in this method
    }
}