/***********************************************************************/
/** 	Consumable Alchemy - inventory (doses, refills, looting)
/***********************************************************************/

// Single choke point for every refill (meditation, bed, alchemy table, quests, NG+).
// Vanilla also calls it from OnItemAdded to initialize a newly acquired item;
// that first call gives one dose, every later call is ignored for consumables.
@wrapMethod(CInventoryComponent)
function SingletonItemRefillAmmo(id : SItemUniqueId, optional alchemyTableUsed : bool)
{
	if(!CA_IsConsumableItem(id))
	{
		wrappedMethod(id, alchemyTableUsed);
		return;
	}

	if(!GetItemModifierInt(id, 'is_initialized', 0))
	{
		SetItemModifierInt(id, 'ammo_current', 1);
		theGame.GetGlobalEventsManager().OnScriptedEvent( SEC_OnAmmoChanged );
	}
}

// Same as vanilla, but potions and bombs use a fixed base instead of the item's 'ammo'
// attribute (decoctions keep it). Skill, decoction and set bonuses still apply on top of it.
@replaceMethod(CInventoryComponent)
function SingletonItemGetMaxAmmo(itemID : SItemUniqueId) : int
{
	var ammo, i : int;
	var perk20Bonus, min, max : SAbilityAttributeValue;
	var atts : array<name>;
	var canUseSkill : bool;

	ammo = RoundMath(CalculateAttributeValue(GetItemAttributeValue(itemID, 'ammo')));

	if(ammo > 0 && CA_IsConsumableItem(itemID) && !IsItemMutagenPotion(itemID))
		ammo = CA_GetMaxAmmo();

	if( !ItemHasTag( itemID, 'NoAdditionalAmmo' ) )
	{
		if(GetEntity() == GetWitcherPlayer() && ammo > 0)
		{
			if(IsItemBomb(itemID) && thePlayer.CanUseSkill(S_Alchemy_s08) )
			{
				ammo += thePlayer.GetSkillLevel(S_Alchemy_s08);
			}

			if(thePlayer.HasBuff(EET_Mutagen03) && (IsItemBomb(itemID) || (!IsItemMutagenPotion(itemID) && IsItemPotion(itemID))) )
			{
				ammo += 1;
			}

			if( GetWitcherPlayer().IsSetBonusActive( EISB_RedWolf_2 ) && !IsItemMutagenPotion(itemID) )
			{
				theGame.GetDefinitionsManager().GetAbilityAttributeValue( GetSetBonusAbility( EISB_RedWolf_2 ), 'amount', min, max);
				ammo += (int)min.valueAdditive;
			}

			if( IsItemBomb( itemID ) && thePlayer.CanUseSkill( S_Perk_20 ) &&  GetItemName( itemID ) != 'Snow Ball' )
			{
				GetItemAttributes( itemID, atts );
				canUseSkill = thePlayer.CanUseSkill( S_Alchemy_s10 );
				perk20Bonus = GetWitcherPlayer().GetSkillAttributeValue( S_Perk_20, 'stack_multiplier', false, false );

				for( i=0 ; i<atts.Size() ; i+=1 )
				{
					if( canUseSkill || IsDamageTypeNameValid( atts[i] ) )
					{
						ammo = RoundMath( ammo * perk20Bonus.valueMultiplicative );
						break;
					}
				}
			}
		}
	}

	return ammo;
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

// Looting / buying a consumable the player already owns adds one dose
// (vanilla refused it). At the cap, vanilla's refusal and message are kept.
@wrapMethod(CInventoryComponent)
function GiveItemTo( otherInventory : CInventoryComponent, itemId : SItemUniqueId, optional quantity : int, optional refreshNewFlag : bool, optional forceTransferNoDrops : bool, optional informGUI : bool ) : SItemUniqueId
{
	var itemName : name;
	var playerItems : array<SItemUniqueId>;
	var newId : SItemUniqueId;
	var addDose, isNewConsumable : bool;

	// wrappedMethod may appear only once per wrapper, so decide first, call once.
	addDose = false;
	isNewConsumable = false;

	if(otherInventory == thePlayer.inv && IsItemSingletonItem(itemId))
	{
		itemName = GetItemName(itemId);

		if(CA_IsConsumableItemName(itemName) && !( !forceTransferNoDrops && ItemHasTag(itemId, 'NoDrop') && !ItemHasTag(itemId, 'Lootable') ))
		{
			playerItems = otherInventory.GetItemsByName(itemName);
			if(playerItems.Size() > 0)
				addDose = otherInventory.SingletonItemGetAmmo(playerItems[0]) < otherInventory.SingletonItemGetMaxAmmo(playerItems[0]);
			else
				isNewConsumable = true;
		}
	}

	if(addDose)
	{
		otherInventory.SingletonItemAddAmmo(playerItems[0], 1);
		RemoveItem(itemId, 1);
		return playerItems[0];
	}

	newId = wrappedMethod(otherInventory, itemId, quantity, refreshNewFlag, forceTransferNoDrops, informGUI);

	if(isNewConsumable && IsIdValid(newId))
		otherInventory.CA_SetConsumableAmmo(newId, 1);

	return newId;
}
