/***********************************************************************/
/** 	Consumable Alchemy - recipes (first brew vs. copies)
/***********************************************************************/

// The first brew of a consumable uses the full recipe. Once the player owns
// the item (also with no doses left), it is brewed from the shorter copy recipe.
// Both come from the recipe table (consumableAlchemy_recipes_table.ws, generated
// from tools\recipes\recipes_table.json). Recipes missing from the table stay vanilla.

function CA_IsCopyRecipe(cookedItemName : name) : bool
{
	if(!thePlayer || !thePlayer.inv)
		return false;

	return CA_IsConsumableItemName(cookedItemName) && thePlayer.inv.GetItemQuantityByName(cookedItemName) > 0;
}

// Ingredients the player has to pay for this recipe right now.
function CA_GetRecipeIngredients(recipe : SAlchemyRecipe) : array<SItemParts>
{
	var ingredients : array<SItemParts>;

	if(CA_GetTableIngredients(recipe.recipeName, CA_IsCopyRecipe(recipe.cookedItemName), ingredients))
		return ingredients;

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
