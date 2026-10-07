/***********************************************************************/
/** 	Consumable Alchemy - alchemy menu (crafting)
/***********************************************************************/

// Vanilla, but an owned consumable returns its copy recipe (see consumableAlchemy_recipes.ws).
// CanCookRecipe, CookItem and GetRequiredIngredients all read recipes through here.
@replaceMethod(W3AlchemyManager)
function GetRecipe(recipeName : name, out ret : SAlchemyRecipe) : bool
{
	var i : int;

	for(i=0; i<recipes.Size(); i+=1)
	{
		if(recipes[i].recipeName == recipeName)
		{
			ret = recipes[i];
			ret.requiredIngredients = CA_GetRecipeIngredients(ret);
			return true;
		}
	}

	return false;
}

// The recipe list shown in the alchemy menu.
@wrapMethod(W3AlchemyManager)
function GetRecipes(forceAll : bool) : array<SAlchemyRecipe>
{
	var ret : array<SAlchemyRecipe>;
	var i : int;

	ret = wrappedMethod(forceAll);

	for(i=0; i<ret.Size(); i+=1)
		ret[i].requiredIngredients = CA_GetRecipeIngredients(ret[i]);

	return ret;
}

// Vanilla reloads the menu's cached recipe list only after brewing level 2+,
// but every first brew switches the recipe to its copy, so always reload it.
@wrapMethod(CR4AlchemyMenu)
function CreateItem( recipeIndex : int )
{
	wrappedMethod(recipeIndex);

	m_recipeList = m_alchemyManager.GetRecipes(false);

	if(recipeIndex >= 0 && recipeIndex < m_recipeList.Size())
		UpdateItemsById(recipeIndex);
}

// Vanilla, except an owned consumable can be brewed again until it reaches the cap.
// At the cap the vanilla "already brewed" exception is returned, so the menu
// shows the original localized message.
@replaceMethod(W3AlchemyManager)
function CanCookRecipe(recipeName : name, optional ignorePlayerState:bool) : EAlchemyExceptions
{
	var i, cnt, itemLevel : int;
	var recipe : SAlchemyRecipe;
	var items  : array<SItemUniqueId>;
	var itemType : string;
	var itemName : name;
	var dm : CDefinitionsManagerAccessor;
	var isConsumable : bool;

	if(!GetRecipe(recipeName, recipe))
		return EAE_NoRecipe;

	if (!ignorePlayerState)
	{
		if (isPlayerMounted) return EAE_Mounted;
		if (isPlayerInCombat) return EAE_InCombat;
	}

	itemType = GetItemNameWithoutLevelAsString(recipe.cookedItemName);
	isConsumable = CA_IsConsumableItemName(recipe.cookedItemName);

	if( theGame.GetDefinitionsManager().IsItemSingletonItem(recipe.cookedItemName) )
	{
		thePlayer.inv.GetAllItems(items);
		for(i=0; i<items.Size(); i+=1)
		{
			itemName = thePlayer.inv.GetItemName(items[i]);

			if(itemName == recipe.cookedItemName)
			{
				if(!isConsumable || thePlayer.inv.SingletonItemGetAmmo(items[i]) >= thePlayer.inv.SingletonItemGetMaxAmmo(items[i]))
					return EAE_CannotCookMore;

				continue;
			}

			if(StrStartsWith(NameToString(itemName), itemType))
			{
				itemLevel = (int)CalculateAttributeValue(thePlayer.inv.GetItemAttributeValue(items[i], 'level'));
				if(itemLevel >= recipe.level)
					return EAE_CannotCookMore;
			}
		}
	}

	dm = theGame.GetDefinitionsManager();

	for(i=0; i<recipe.requiredIngredients.Size(); i+=1)
	{
		itemName = recipe.requiredIngredients[i].itemName;

		if (dm.ItemHasTag( itemName, 'MutagenIngredient' ))
		{
			cnt = thePlayer.inv.GetUnusedMutagensCount(itemName);
		}
		else
		{
			cnt = thePlayer.inv.GetItemQuantityByName(itemName);
		}

		if(cnt < recipe.requiredIngredients[i].quantity)
		{
			return EAE_NotEnoughIngredients;
		}
	}
	return EAE_NoException;
}

// One brew fills the item up to its limit, as meditation did in vanilla.
// Vanilla already does it for a new item, but leaves an owned one untouched.
@wrapMethod(W3AlchemyManager)
function CookItem(recipeName : name)
{
	var recipe : SAlchemyRecipe;
	var inv : CInventoryComponent;
	var items : array<SItemUniqueId>;
	var i, maxAmmo : int;

	wrappedMethod(recipeName);

	if(!GetRecipe(recipeName, recipe) || !CA_IsConsumableItemName(recipe.cookedItemName))
		return;

	inv = thePlayer.inv;
	items = inv.GetItemsByName(recipe.cookedItemName);
	for(i=0; i<items.Size(); i+=1)
	{
		maxAmmo = inv.SingletonItemGetMaxAmmo(items[i]);
		if(inv.SingletonItemGetAmmo(items[i]) < maxAmmo)
			inv.SingletonItemSetAmmo(items[i], maxAmmo);
	}
}
