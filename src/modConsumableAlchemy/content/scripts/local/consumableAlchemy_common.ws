/***********************************************************************/
/** 	Consumable Alchemy - shared helpers
/***********************************************************************/

// Base maximum number of doses of a single potion / bomb type (vanilla bonuses add to it).
// Decoctions keep their vanilla limit (1).
function CA_GetMaxAmmo() : int
{
	return 3;
}

// Potions, decoctions and bombs use the consumable system. Oils, quest items
// and infinite-ammo items keep the vanilla singleton behaviour.
function CA_IsConsumableItemName(itemName : name) : bool
{
	var dm : CDefinitionsManagerAccessor;

	if(!IsNameValid(itemName))
		return false;

	dm = theGame.GetDefinitionsManager();

	if(!dm.IsItemSingletonItem(itemName))
		return false;

	// Quest / tutorial items that vanilla expects to be refilled.
	if(itemName == 'Snow Ball' || itemName == 'Tutorial Bomb' || itemName == 'Village drink')
		return false;

	if(dm.ItemHasTag(itemName, 'Quest') || dm.ItemHasTag(itemName, 'NoAdditionalAmmo') || dm.ItemHasTag(itemName, theGame.params.TAG_INFINITE_AMMO))
		return false;

	return dm.IsItemBomb(itemName) || dm.IsItemPotion(itemName);
}

@addMethod(CInventoryComponent)
function CA_IsConsumableItem(itemID : SItemUniqueId) : bool
{
	if(GetEntity() != thePlayer)
		return false;

	return CA_IsConsumableItemName(GetItemName(itemID));
}

// Sets doses and marks the item as initialized, so OnItemAdded won't overwrite them.
@addMethod(CInventoryComponent)
function CA_SetConsumableAmmo(itemID : SItemUniqueId, amount : int)
{
	SetItemModifierInt(itemID, 'is_initialized', 1);
	SingletonItemSetAmmo(itemID, amount);
}
