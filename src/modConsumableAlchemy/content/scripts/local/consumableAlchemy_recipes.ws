/***********************************************************************/
/** 	Consumable Alchemy - recipes (first brew vs. copies)
/***********************************************************************/

// The first brew of a consumable uses the full vanilla recipe. Once the player
// owns the item (also with no doses left), it is brewed from a shorter recipe:
// the base (alcohol / bomb powder) and the common ingredients, in smaller amounts.
// Rarer ingredients and the lower level item drop out. Mirrored by tools\recipes\rule.py.

// Ingredients with a base price up to this value stay in the copy recipe.
function CA_GetCopyPriceThreshold() : int
{
	return 16;
}

// Copy recipe amounts are divided by this value (rounded up). Alcohol is always 1.
function CA_GetCopyQuantityDivisor() : int
{
	return 2;
}

function CA_IsBombBase(itemName : name) : bool
{
	return itemName == 'Saltpetre' || itemName == 'Stammelfords dust' || itemName == 'Alchemists powder';
}

function CA_IsCopyRecipe(cookedItemName : name) : bool
{
	if(!thePlayer || !thePlayer.inv)
		return false;

	return CA_IsConsumableItemName(cookedItemName) && thePlayer.inv.GetItemQuantityByName(cookedItemName) > 0;
}

function CA_GetCopyIngredients(ingredients : array<SItemParts>) : array<SItemParts>
{
	var dm : CDefinitionsManagerAccessor;
	var ret : array<SItemParts>;
	var ing : SItemParts;
	var category : name;
	var i : int;

	dm = theGame.GetDefinitionsManager();

	for(i=0; i<ingredients.Size(); i+=1)
	{
		ing = ingredients[i];
		category = dm.GetItemCategory(ing.itemName);

		// lower level of the same item
		if(category == 'potion' || category == 'petard')
			continue;

		if(dm.ItemHasTag(ing.itemName, 'StrongAlcohol'))
		{
			if(ing.itemName == 'White Gull 1')
				ing.itemName = 'Alcohest';

			ing.quantity = 1;
		}
		else if(CA_IsBombBase(ing.itemName) || (!dm.ItemHasTag(ing.itemName, 'MutagenIngredient') && dm.GetItemPrice(ing.itemName) <= CA_GetCopyPriceThreshold()))
		{
			ing.quantity = CeilF((float)ing.quantity / (float)CA_GetCopyQuantityDivisor());
		}
		else
		{
			continue;
		}

		ret.PushBack(ing);
	}

	return ret;
}

// Ingredients the player has to pay for this recipe right now.
function CA_GetRecipeIngredients(recipe : SAlchemyRecipe) : array<SItemParts>
{
	if(CA_IsCopyRecipe(recipe.cookedItemName))
		return CA_GetCopyIngredients(recipe.requiredIngredients);

	return recipe.requiredIngredients;
}

// Recipe tooltip in the inventory and the pinned recipe read the XML directly.
@wrapMethod
function getAlchemyRecipeFromName(recipeName : name) : SAlchemyRecipe
{
	var rec : SAlchemyRecipe;

	rec = wrappedMethod(recipeName);
	rec.requiredIngredients = CA_GetRecipeIngredients(rec);

	return rec;
}
