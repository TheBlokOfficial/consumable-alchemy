/***********************************************************************/
/** 	Consumable Alchemy - inventory (doses, refills)
/***********************************************************************/

// Single choke point for every refill (meditation, bed, alchemy table, quests, NG+).
// Vanilla also calls it from OnItemAdded to initialize a newly acquired item;
// that first call stays vanilla (full doses), every later call is ignored for consumables.
@wrapMethod(CInventoryComponent)
function SingletonItemRefillAmmo(id : SItemUniqueId, optional alchemyTableUsed : bool)
{
	// wrappedMethod may appear only once per wrapper.
	if(CA_IsConsumableItem(id) && GetItemModifierInt(id, 'is_initialized', 0) != 0)
		return;

	wrappedMethod(id, alchemyTableUsed);
}

// Consumables never need a refill, so they must not trigger alcohol use
// or the "items refilled" / "cannot refill" notifications.
@replaceMethod(CInventoryComponent)
function HasNotFilledSingletonItem( optional alchemyTableUsed : bool ) : bool
{
	var i : int;
	var singletonItems : array<SItemUniqueId>;
	var hasLab : bool;
	var l_bed : W3WitcherBed;

	hasLab = false;
	if( FactsQuerySum( "PlayerInsideOuterWitcherHouse" ) >= 1 && FactsQuerySum( "AlchemyTableExists" ) >= 1 )
	{
		l_bed = (W3WitcherBed)theGame.GetEntityByTag( 'witcherBed' );
		if( l_bed.GetWasUsed() || alchemyTableUsed )
		{
			hasLab = true;
		}
	}

	singletonItems = GetSingletonItems();
	for(i=0; i<singletonItems.Size(); i+=1)
	{
		if( CA_IsConsumableItem( singletonItems[i] ) )
			continue;

		if( hasLab && !IsItemMutagenPotion( singletonItems[i] ) )
		{
			if(SingletonItemGetAmmo(singletonItems[i]) <= SingletonItemGetMaxAmmo(singletonItems[i]))
			{
				return true;
			}
		}
		else if(SingletonItemGetAmmo(singletonItems[i]) < SingletonItemGetMaxAmmo(singletonItems[i]))
		{
			return true;
		}
	}

	return false;
}

// Same as vanilla, but an empty consumable doesn't trigger the "refill with alcohol" tutorial.
@replaceMethod(CInventoryComponent)
function SingletonItemRemoveAmmo(itemID : SItemUniqueId, optional quantity : int)
{
	var ammo : int;

	if(!IsItemSingletonItem(itemID) || ItemHasTag(itemID, theGame.params.TAG_INFINITE_AMMO))
		return;

	if(quantity <= 0)
		quantity = 1;

	ammo = GetItemModifierInt(itemID, 'ammo_current');
	ammo = Max(0, ammo - quantity);
	SetItemModifierInt(itemID, 'ammo_current', ammo);

	if(ammo == 0 && !CA_IsConsumableItem(itemID) && ShouldProcessTutorial('TutorialAlchemyRefill') && FactsQuerySum("q001_nightmare_ended") > 0)
	{
		FactsAdd('tut_alch_refill', 1);
	}
	theGame.GetGlobalEventsManager().OnScriptedEvent( SEC_OnAmmoChanged );
}

// Corvo Bianco alchemy table: its bonus only ever affected potions, decoctions
// and bombs, which are now consumables, so it has nothing to do.
@replaceMethod(CInventoryComponent)
function ManageSingletonItemsBonus()
{
	theSound.SoundEvent("gui_global_denied");
}
