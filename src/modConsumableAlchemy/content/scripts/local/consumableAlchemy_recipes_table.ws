/***********************************************************************/
/** 	Consumable Alchemy - recipe table
/***********************************************************************/

// GENERATED FILE - DO NOT EDIT BY HAND.
// Source: tools/recipes/recipes_table.json, generator: tools/recipes/generate.py.

// Full (first brew) or copy recipe from the table. False if the recipe is not in the table.
function CA_GetTableIngredients(recipeName : name, isCopy : bool, out ingredients : array<SItemParts>) : bool
{
	ingredients.Clear();

	if(CA_GetTableIngredients_Potion(recipeName, isCopy, ingredients))
		return true;

	if(CA_GetTableIngredients_Bomb(recipeName, isCopy, ingredients))
		return true;

	if(CA_GetTableIngredients_Decoction(recipeName, isCopy, ingredients))
		return true;

	return false;
}

function CA_AddTableIngredient(out ingredients : array<SItemParts>, itemName : name, quantity : int)
{
	var ing : SItemParts;

	ing.itemName = itemName;
	ing.quantity = quantity;
	ingredients.PushBack(ing);
}

function CA_GetTableIngredients_Potion(recipeName : name, isCopy : bool, out ingredients : array<SItemParts>) : bool
{
	switch(recipeName)
	{
		case 'Recipe for Black Blood 1':
			CA_TableRecipe_Black_Blood_1(isCopy, ingredients);
			return true;
		case 'Recipe for Black Blood 2':
			CA_TableRecipe_Black_Blood_2(isCopy, ingredients);
			return true;
		case 'Recipe for Black Blood 3':
			CA_TableRecipe_Black_Blood_3(isCopy, ingredients);
			return true;
		case 'Recipe for Blizzard 1':
			CA_TableRecipe_Blizzard_1(isCopy, ingredients);
			return true;
		case 'Recipe for Blizzard 2':
			CA_TableRecipe_Blizzard_2(isCopy, ingredients);
			return true;
		case 'Recipe for Blizzard 3':
			CA_TableRecipe_Blizzard_3(isCopy, ingredients);
			return true;
		case 'Recipe for Cat 1':
			CA_TableRecipe_Cat_1(isCopy, ingredients);
			return true;
		case 'Recipe for Cat 2':
			CA_TableRecipe_Cat_2(isCopy, ingredients);
			return true;
		case 'Recipe for Cat 3':
			CA_TableRecipe_Cat_3(isCopy, ingredients);
			return true;
		case 'Recipe for Full Moon 1':
			CA_TableRecipe_Full_Moon_1(isCopy, ingredients);
			return true;
		case 'Recipe for Full Moon 2':
			CA_TableRecipe_Full_Moon_2(isCopy, ingredients);
			return true;
		case 'Recipe for Full Moon 3':
			CA_TableRecipe_Full_Moon_3(isCopy, ingredients);
			return true;
		case 'Recipe for Golden Oriole 1':
			CA_TableRecipe_Golden_Oriole_1(isCopy, ingredients);
			return true;
		case 'Recipe for Golden Oriole 2':
			CA_TableRecipe_Golden_Oriole_2(isCopy, ingredients);
			return true;
		case 'Recipe for Golden Oriole 3':
			CA_TableRecipe_Golden_Oriole_3(isCopy, ingredients);
			return true;
		case 'Recipe for Killer Whale 1':
			CA_TableRecipe_Killer_Whale_1(isCopy, ingredients);
			return true;
		case 'Recipe for Maribor Forest 1':
			CA_TableRecipe_Maribor_Forest_1(isCopy, ingredients);
			return true;
		case 'Recipe for Maribor Forest 2':
			CA_TableRecipe_Maribor_Forest_2(isCopy, ingredients);
			return true;
		case 'Recipe for Maribor Forest 3':
			CA_TableRecipe_Maribor_Forest_3(isCopy, ingredients);
			return true;
		case 'Recipe for Petris Philtre 1':
			CA_TableRecipe_Petris_Philtre_1(isCopy, ingredients);
			return true;
		case 'Recipe for Petris Philtre 2':
			CA_TableRecipe_Petris_Philtre_2(isCopy, ingredients);
			return true;
		case 'Recipe for Petris Philtre 3':
			CA_TableRecipe_Petris_Philtre_3(isCopy, ingredients);
			return true;
		case 'Recipe for Bear Pheromone Potion 1':
			CA_TableRecipe_Bear_Pheromone_Potion_1(isCopy, ingredients);
			return true;
		case 'Recipe for Drowner Pheromone Potion 1':
			CA_TableRecipe_Drowner_Pheromone_Potion_1(isCopy, ingredients);
			return true;
		case 'Recipe for Nekker Pheromone Potion 1':
			CA_TableRecipe_Nekker_Pheromone_Potion_1(isCopy, ingredients);
			return true;
		case 'Recipe for Pops Antidote':
			CA_TableRecipe_Pops_Antidote(isCopy, ingredients);
			return true;
		case 'Recipe for Swallow 1':
			CA_TableRecipe_Swallow_1(isCopy, ingredients);
			return true;
		case 'Recipe for Swallow 2':
			CA_TableRecipe_Swallow_2(isCopy, ingredients);
			return true;
		case 'Recipe for Swallow 3':
			CA_TableRecipe_Swallow_3(isCopy, ingredients);
			return true;
		case 'Recipe for Tawny Owl 1':
			CA_TableRecipe_Tawny_Owl_1(isCopy, ingredients);
			return true;
		case 'Recipe for Tawny Owl 2':
			CA_TableRecipe_Tawny_Owl_2(isCopy, ingredients);
			return true;
		case 'Recipe for Tawny Owl 3':
			CA_TableRecipe_Tawny_Owl_3(isCopy, ingredients);
			return true;
		case 'Recipe for Thunderbolt 1':
			CA_TableRecipe_Thunderbolt_1(isCopy, ingredients);
			return true;
		case 'Recipe for Thunderbolt 2':
			CA_TableRecipe_Thunderbolt_2(isCopy, ingredients);
			return true;
		case 'Recipe for Thunderbolt 3':
			CA_TableRecipe_Thunderbolt_3(isCopy, ingredients);
			return true;
		case 'Recipe for White Honey 1':
			CA_TableRecipe_White_Honey_1(isCopy, ingredients);
			return true;
		case 'Recipe for White Honey 2':
			CA_TableRecipe_White_Honey_2(isCopy, ingredients);
			return true;
		case 'Recipe for White Honey 3':
			CA_TableRecipe_White_Honey_3(isCopy, ingredients);
			return true;
		case 'Recipe for White Raffards Decoction 1':
			CA_TableRecipe_White_Raffards_Decoction_1(isCopy, ingredients);
			return true;
		case 'Recipe for White Raffards Decoction 2':
			CA_TableRecipe_White_Raffards_Decoction_2(isCopy, ingredients);
			return true;
		case 'Recipe for White Raffards Decoction 3':
			CA_TableRecipe_White_Raffards_Decoction_3(isCopy, ingredients);
			return true;
	}

	return false;
}

function CA_GetTableIngredients_Bomb(recipeName : name, isCopy : bool, out ingredients : array<SItemParts>) : bool
{
	switch(recipeName)
	{
		case 'Recipe for Dancing Star 1':
			CA_TableRecipe_Dancing_Star_1(isCopy, ingredients);
			return true;
		case 'Recipe for Dancing Star 2':
			CA_TableRecipe_Dancing_Star_2(isCopy, ingredients);
			return true;
		case 'Recipe for Dancing Star 3':
			CA_TableRecipe_Dancing_Star_3(isCopy, ingredients);
			return true;
		case 'Recipe for Devils Puffball 1':
			CA_TableRecipe_Devils_Puffball_1(isCopy, ingredients);
			return true;
		case 'Recipe for Devils Puffball 2':
			CA_TableRecipe_Devils_Puffball_2(isCopy, ingredients);
			return true;
		case 'Recipe for Devils Puffball 3':
			CA_TableRecipe_Devils_Puffball_3(isCopy, ingredients);
			return true;
		case 'Recipe for Dragons Dream 1':
			CA_TableRecipe_Dragons_Dream_1(isCopy, ingredients);
			return true;
		case 'Recipe for Dragons Dream 2':
			CA_TableRecipe_Dragons_Dream_2(isCopy, ingredients);
			return true;
		case 'Recipe for Dragons Dream 3':
			CA_TableRecipe_Dragons_Dream_3(isCopy, ingredients);
			return true;
		case 'Recipe for Dwimeritium Bomb 1':
			CA_TableRecipe_Dwimeritium_Bomb_1(isCopy, ingredients);
			return true;
		case 'Recipe for Dwimeritium Bomb 2':
			CA_TableRecipe_Dwimeritium_Bomb_2(isCopy, ingredients);
			return true;
		case 'Recipe for Dwimeritium Bomb 3':
			CA_TableRecipe_Dwimeritium_Bomb_3(isCopy, ingredients);
			return true;
		case 'Recipe for Grapeshot 1':
			CA_TableRecipe_Grapeshot_1(isCopy, ingredients);
			return true;
		case 'Recipe for Grapeshot 2':
			CA_TableRecipe_Grapeshot_2(isCopy, ingredients);
			return true;
		case 'Recipe for Grapeshot 3':
			CA_TableRecipe_Grapeshot_3(isCopy, ingredients);
			return true;
		case 'Recipe for Samum 1':
			CA_TableRecipe_Samum_1(isCopy, ingredients);
			return true;
		case 'Recipe for Samum 2':
			CA_TableRecipe_Samum_2(isCopy, ingredients);
			return true;
		case 'Recipe for Samum 3':
			CA_TableRecipe_Samum_3(isCopy, ingredients);
			return true;
		case 'Recipe for Silver Dust Bomb 1':
			CA_TableRecipe_Silver_Dust_Bomb_1(isCopy, ingredients);
			return true;
		case 'Recipe for Silver Dust Bomb 2':
			CA_TableRecipe_Silver_Dust_Bomb_2(isCopy, ingredients);
			return true;
		case 'Recipe for Silver Dust Bomb 3':
			CA_TableRecipe_Silver_Dust_Bomb_3(isCopy, ingredients);
			return true;
		case 'Recipe for White Frost 1':
			CA_TableRecipe_White_Frost_1(isCopy, ingredients);
			return true;
		case 'Recipe for White Frost 2':
			CA_TableRecipe_White_Frost_2(isCopy, ingredients);
			return true;
		case 'Recipe for White Frost 3':
			CA_TableRecipe_White_Frost_3(isCopy, ingredients);
			return true;
	}

	return false;
}

function CA_GetTableIngredients_Decoction(recipeName : name, isCopy : bool, out ingredients : array<SItemParts>) : bool
{
	switch(recipeName)
	{
		case 'Recipe for Mutagen 1':
			CA_TableRecipe_Mutagen_1(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 2':
			CA_TableRecipe_Mutagen_2(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 3':
			CA_TableRecipe_Mutagen_3(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 4':
			CA_TableRecipe_Mutagen_4(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 5':
			CA_TableRecipe_Mutagen_5(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 6':
			CA_TableRecipe_Mutagen_6(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 7':
			CA_TableRecipe_Mutagen_7(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 8':
			CA_TableRecipe_Mutagen_8(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 9':
			CA_TableRecipe_Mutagen_9(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 10':
			CA_TableRecipe_Mutagen_10(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 11':
			CA_TableRecipe_Mutagen_11(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 12':
			CA_TableRecipe_Mutagen_12(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 13':
			CA_TableRecipe_Mutagen_13(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 14':
			CA_TableRecipe_Mutagen_14(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 15':
			CA_TableRecipe_Mutagen_15(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 16':
			CA_TableRecipe_Mutagen_16(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 17':
			CA_TableRecipe_Mutagen_17(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 18':
			CA_TableRecipe_Mutagen_18(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 19':
			CA_TableRecipe_Mutagen_19(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 20':
			CA_TableRecipe_Mutagen_20(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 21':
			CA_TableRecipe_Mutagen_21(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 22':
			CA_TableRecipe_Mutagen_22(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 23':
			CA_TableRecipe_Mutagen_23(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 24':
			CA_TableRecipe_Mutagen_24(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 25':
			CA_TableRecipe_Mutagen_25(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 26':
			CA_TableRecipe_Mutagen_26(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 27':
			CA_TableRecipe_Mutagen_27(isCopy, ingredients);
			return true;
		case 'Recipe for Mutagen 28':
			CA_TableRecipe_Mutagen_28(isCopy, ingredients);
			return true;
	}

	return false;
}

// Black Blood 1
function CA_TableRecipe_Black_Blood_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 2);
		CA_AddTableIngredient(ingredients, 'Ghoul blood', 4);
	}
}

// Black Blood 2
function CA_TableRecipe_Black_Blood_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Hellebore petals', 1);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 3);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Black Blood 1', 1);
		CA_AddTableIngredient(ingredients, 'Hellebore petals', 1);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 5);
		CA_AddTableIngredient(ingredients, 'Ghoul blood', 5);
	}
}

// Black Blood 3
function CA_TableRecipe_Black_Blood_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Hellebore petals', 3);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 3);
		CA_AddTableIngredient(ingredients, 'Han', 1);
		CA_AddTableIngredient(ingredients, 'Nostrix', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'White Gull 1', 1);
		CA_AddTableIngredient(ingredients, 'Black Blood 2', 1);
		CA_AddTableIngredient(ingredients, 'Hellebore petals', 5);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 5);
		CA_AddTableIngredient(ingredients, 'Han', 1);
		CA_AddTableIngredient(ingredients, 'Nostrix', 1);
		CA_AddTableIngredient(ingredients, 'Rebis', 1);
	}
}

// Blizzard 1
function CA_TableRecipe_Blizzard_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'White myrtle', 3);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'White myrtle', 5);
		CA_AddTableIngredient(ingredients, 'Golem heart', 1);
	}
}

// Blizzard 2
function CA_TableRecipe_Blizzard_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Celandine', 1);
		CA_AddTableIngredient(ingredients, 'White myrtle', 3);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Blizzard 1', 1);
		CA_AddTableIngredient(ingredients, 'Celandine', 1);
		CA_AddTableIngredient(ingredients, 'White myrtle', 5);
		CA_AddTableIngredient(ingredients, 'Golem heart', 1);
	}
}

// Blizzard 3
function CA_TableRecipe_Blizzard_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Celandine', 2);
		CA_AddTableIngredient(ingredients, 'White myrtle', 2);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 1);
		CA_AddTableIngredient(ingredients, 'Buckthorn', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'White Gull 1', 1);
		CA_AddTableIngredient(ingredients, 'Blizzard 2', 1);
		CA_AddTableIngredient(ingredients, 'Celandine', 4);
		CA_AddTableIngredient(ingredients, 'White myrtle', 4);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 1);
		CA_AddTableIngredient(ingredients, 'Buckthorn', 1);
		CA_AddTableIngredient(ingredients, 'Rebis', 1);
	}
}

// Cat 1
function CA_TableRecipe_Cat_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 2);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 4);
		CA_AddTableIngredient(ingredients, 'Water essence', 2);
	}
}

// Cat 2
function CA_TableRecipe_Cat_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 3);
		CA_AddTableIngredient(ingredients, 'Cortinarius', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Cat 1', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 5);
		CA_AddTableIngredient(ingredients, 'Cortinarius', 1);
		CA_AddTableIngredient(ingredients, 'Water essence', 3);
	}
}

// Cat 3
function CA_TableRecipe_Cat_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 2);
		CA_AddTableIngredient(ingredients, 'Cortinarius', 2);
		CA_AddTableIngredient(ingredients, 'Moleyarrow', 1);
		CA_AddTableIngredient(ingredients, 'Allspice root', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'White Gull 1', 1);
		CA_AddTableIngredient(ingredients, 'Cat 2', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 4);
		CA_AddTableIngredient(ingredients, 'Cortinarius', 4);
		CA_AddTableIngredient(ingredients, 'Moleyarrow', 1);
		CA_AddTableIngredient(ingredients, 'Allspice root', 1);
		CA_AddTableIngredient(ingredients, 'Aether', 1);
	}
}

// Full Moon 1
function CA_TableRecipe_Full_Moon_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Wolfsbane', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Wolfsbane', 2);
		CA_AddTableIngredient(ingredients, 'Nightwraith dark essence', 1);
	}
}

// Full Moon 2
function CA_TableRecipe_Full_Moon_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Crows eye', 1);
		CA_AddTableIngredient(ingredients, 'Wolfsbane', 3);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Full Moon 1', 1);
		CA_AddTableIngredient(ingredients, 'Crows eye', 2);
		CA_AddTableIngredient(ingredients, 'Wolfsbane', 5);
		CA_AddTableIngredient(ingredients, 'Nightwraith dark essence', 2);
	}
}

// Full Moon 3
function CA_TableRecipe_Full_Moon_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Mistletoe', 1);
		CA_AddTableIngredient(ingredients, 'Verbena', 1);
		CA_AddTableIngredient(ingredients, 'Crows eye', 2);
		CA_AddTableIngredient(ingredients, 'Wolfsbane', 2);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'White Gull 1', 1);
		CA_AddTableIngredient(ingredients, 'Full Moon 2', 1);
		CA_AddTableIngredient(ingredients, 'Mistletoe', 1);
		CA_AddTableIngredient(ingredients, 'Verbena', 1);
		CA_AddTableIngredient(ingredients, 'Crows eye', 4);
		CA_AddTableIngredient(ingredients, 'Wolfsbane', 4);
		CA_AddTableIngredient(ingredients, 'Quebrith', 1);
	}
}

// Golden Oriole 1
function CA_TableRecipe_Golden_Oriole_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 2);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 4);
		CA_AddTableIngredient(ingredients, 'Noonwraith light essence', 1);
	}
}

// Golden Oriole 2
function CA_TableRecipe_Golden_Oriole_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 3);
		CA_AddTableIngredient(ingredients, 'Celandine', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Golden Oriole 1', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 6);
		CA_AddTableIngredient(ingredients, 'Celandine', 1);
		CA_AddTableIngredient(ingredients, 'Noonwraith light essence', 2);
	}
}

// Golden Oriole 3
function CA_TableRecipe_Golden_Oriole_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 2);
		CA_AddTableIngredient(ingredients, 'Celandine', 2);
		CA_AddTableIngredient(ingredients, 'Han', 1);
		CA_AddTableIngredient(ingredients, 'Ranogrin', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'White Gull 1', 1);
		CA_AddTableIngredient(ingredients, 'Golden Oriole 2', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 4);
		CA_AddTableIngredient(ingredients, 'Celandine', 4);
		CA_AddTableIngredient(ingredients, 'Han', 1);
		CA_AddTableIngredient(ingredients, 'Ranogrin', 1);
		CA_AddTableIngredient(ingredients, 'Quebrith', 1);
	}
}

// Killer Whale 1
function CA_TableRecipe_Killer_Whale_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Balisse fruit', 3);
		CA_AddTableIngredient(ingredients, 'Buckthorn', 3);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 2);
		CA_AddTableIngredient(ingredients, 'Balisse fruit', 5);
		CA_AddTableIngredient(ingredients, 'Buckthorn', 6);
		CA_AddTableIngredient(ingredients, 'Drowned dead tongue', 5);
	}
}

// Maribor Forest 1
function CA_TableRecipe_Maribor_Forest_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 2);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 3);
		CA_AddTableIngredient(ingredients, 'Alghoul bone marrow', 1);
		CA_AddTableIngredient(ingredients, 'Drowned dead tongue', 4);
	}
}

// Maribor Forest 2
function CA_TableRecipe_Maribor_Forest_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 3);
		CA_AddTableIngredient(ingredients, 'Crows eye', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Maribor Forest 1', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 5);
		CA_AddTableIngredient(ingredients, 'Crows eye', 1);
		CA_AddTableIngredient(ingredients, 'Drowned dead tongue', 2);
	}
}

// Maribor Forest 3
function CA_TableRecipe_Maribor_Forest_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 2);
		CA_AddTableIngredient(ingredients, 'Crows eye', 2);
		CA_AddTableIngredient(ingredients, 'Hellebore petals', 1);
		CA_AddTableIngredient(ingredients, 'Ribleaf', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'White Gull 1', 1);
		CA_AddTableIngredient(ingredients, 'Maribor Forest 2', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 4);
		CA_AddTableIngredient(ingredients, 'Crows eye', 4);
		CA_AddTableIngredient(ingredients, 'Hellebore petals', 1);
		CA_AddTableIngredient(ingredients, 'Ribleaf', 1);
		CA_AddTableIngredient(ingredients, 'Vermilion', 1);
	}
}

// Petri Philtre 1
function CA_TableRecipe_Petris_Philtre_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Arenaria', 3);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Arenaria', 5);
		CA_AddTableIngredient(ingredients, 'Specter dust', 1);
	}
}

// Petri Philtre 2
function CA_TableRecipe_Petris_Philtre_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Arenaria', 3);
		CA_AddTableIngredient(ingredients, 'Buckthorn', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Petri Philtre 1', 1);
		CA_AddTableIngredient(ingredients, 'Arenaria', 6);
		CA_AddTableIngredient(ingredients, 'Buckthorn', 1);
		CA_AddTableIngredient(ingredients, 'Specter dust', 2);
	}
}

// Petri Philtre 3
function CA_TableRecipe_Petris_Philtre_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Arenaria', 2);
		CA_AddTableIngredient(ingredients, 'Buckthorn', 2);
		CA_AddTableIngredient(ingredients, 'Longrube', 1);
		CA_AddTableIngredient(ingredients, 'Ranogrin', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'White Gull 1', 1);
		CA_AddTableIngredient(ingredients, 'Petri Philtre 2', 1);
		CA_AddTableIngredient(ingredients, 'Arenaria', 4);
		CA_AddTableIngredient(ingredients, 'Buckthorn', 4);
		CA_AddTableIngredient(ingredients, 'Longrube', 1);
		CA_AddTableIngredient(ingredients, 'Ranogrin', 1);
		CA_AddTableIngredient(ingredients, 'Rubedo', 1);
	}
}

// Pheromone Potion Bear 1
function CA_TableRecipe_Bear_Pheromone_Potion_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 1);
		CA_AddTableIngredient(ingredients, 'Ergot seeds', 1);
		CA_AddTableIngredient(ingredients, 'Hellebore petals', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 1);
		CA_AddTableIngredient(ingredients, 'Ergot seeds', 1);
		CA_AddTableIngredient(ingredients, 'Hellebore petals', 1);
	}
}

// Pheromone Potion Drowner 1
function CA_TableRecipe_Drowner_Pheromone_Potion_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 1);
		CA_AddTableIngredient(ingredients, 'Pigskin puffball', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Drowner brain', 1);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 1);
		CA_AddTableIngredient(ingredients, 'Pigskin puffball', 1);
	}
}

// Pheromone Potion Nekker 1
function CA_TableRecipe_Nekker_Pheromone_Potion_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Green mold', 1);
		CA_AddTableIngredient(ingredients, 'Moleyarrow', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Green mold', 1);
		CA_AddTableIngredient(ingredients, 'Drowner brain', 1);
		CA_AddTableIngredient(ingredients, 'Moleyarrow', 1);
	}
}

// Pops Antidote
function CA_TableRecipe_Pops_Antidote(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'White myrtle', 2);
		CA_AddTableIngredient(ingredients, 'Celandine', 1);
		CA_AddTableIngredient(ingredients, 'Hellebore petals', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'White myrtle', 4);
		CA_AddTableIngredient(ingredients, 'Celandine', 1);
		CA_AddTableIngredient(ingredients, 'Hellebore petals', 1);
	}
}

// Swallow 1
function CA_TableRecipe_Swallow_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Celandine', 3);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Celandine', 5);
		CA_AddTableIngredient(ingredients, 'Drowner brain', 1);
	}
}

// Swallow 2
function CA_TableRecipe_Swallow_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Celandine', 3);
		CA_AddTableIngredient(ingredients, 'White myrtle', 2);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Swallow 1', 1);
		CA_AddTableIngredient(ingredients, 'Celandine', 6);
		CA_AddTableIngredient(ingredients, 'White myrtle', 4);
		CA_AddTableIngredient(ingredients, 'Drowner brain', 5);
	}
}

// Swallow 3
function CA_TableRecipe_Swallow_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 3);
		CA_AddTableIngredient(ingredients, 'White myrtle', 3);
		CA_AddTableIngredient(ingredients, 'Celandine', 2);
		CA_AddTableIngredient(ingredients, 'Crows eye', 2);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'White Gull 1', 1);
		CA_AddTableIngredient(ingredients, 'Swallow 2', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 6);
		CA_AddTableIngredient(ingredients, 'White myrtle', 6);
		CA_AddTableIngredient(ingredients, 'Celandine', 4);
		CA_AddTableIngredient(ingredients, 'Crows eye', 4);
		CA_AddTableIngredient(ingredients, 'Vitriol', 2);
	}
}

// Tawny Owl 1
function CA_TableRecipe_Tawny_Owl_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Verbena', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Verbena', 2);
		CA_AddTableIngredient(ingredients, 'Arachas venom', 1);
	}
}

// Tawny Owl 2
function CA_TableRecipe_Tawny_Owl_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Verbena', 2);
		CA_AddTableIngredient(ingredients, 'Wolfsbane', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Tawny Owl 1', 1);
		CA_AddTableIngredient(ingredients, 'Verbena', 4);
		CA_AddTableIngredient(ingredients, 'Wolfsbane', 2);
		CA_AddTableIngredient(ingredients, 'Arachas venom', 1);
	}
}

// Tawny Owl 3
function CA_TableRecipe_Tawny_Owl_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Verbena', 2);
		CA_AddTableIngredient(ingredients, 'Wolfsbane', 2);
		CA_AddTableIngredient(ingredients, 'Fools parsley leaves', 1);
		CA_AddTableIngredient(ingredients, 'Mandrake root', 1);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'White Gull 1', 1);
		CA_AddTableIngredient(ingredients, 'Tawny Owl 2', 1);
		CA_AddTableIngredient(ingredients, 'Verbena', 4);
		CA_AddTableIngredient(ingredients, 'Wolfsbane', 4);
		CA_AddTableIngredient(ingredients, 'Fools parsley leaves', 1);
		CA_AddTableIngredient(ingredients, 'Mandrake root', 1);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 1);
	}
}

// Thunderbolt 1
function CA_TableRecipe_Thunderbolt_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Cortinarius', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Cortinarius', 2);
		CA_AddTableIngredient(ingredients, 'Endriag embryo', 1);
	}
}

// Thunderbolt 2
function CA_TableRecipe_Thunderbolt_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Cortinarius', 1);
		CA_AddTableIngredient(ingredients, 'Fools parsley leaves', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Thunderbolt 1', 1);
		CA_AddTableIngredient(ingredients, 'Cortinarius', 2);
		CA_AddTableIngredient(ingredients, 'Fools parsley leaves', 1);
		CA_AddTableIngredient(ingredients, 'Endriag embryo', 2);
	}
}

// Thunderbolt 3
function CA_TableRecipe_Thunderbolt_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Cortinarius', 2);
		CA_AddTableIngredient(ingredients, 'Fools parsley leaves', 2);
		CA_AddTableIngredient(ingredients, 'Verbena', 1);
		CA_AddTableIngredient(ingredients, 'Bryonia', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'White Gull 1', 1);
		CA_AddTableIngredient(ingredients, 'Thunderbolt 2', 1);
		CA_AddTableIngredient(ingredients, 'Cortinarius', 4);
		CA_AddTableIngredient(ingredients, 'Fools parsley leaves', 4);
		CA_AddTableIngredient(ingredients, 'Verbena', 1);
		CA_AddTableIngredient(ingredients, 'Bryonia', 1);
		CA_AddTableIngredient(ingredients, 'Quebrith', 1);
	}
}

// White Honey 1
function CA_TableRecipe_White_Honey_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Honeysuckle', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Honeysuckle', 1);
	}
}

// White Honey 2
function CA_TableRecipe_White_Honey_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Honeysuckle', 1);
		CA_AddTableIngredient(ingredients, 'White myrtle', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'White Honey 1', 1);
		CA_AddTableIngredient(ingredients, 'Honeysuckle', 2);
		CA_AddTableIngredient(ingredients, 'White myrtle', 1);
	}
}

// White Honey 3
function CA_TableRecipe_White_Honey_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Honeysuckle', 2);
		CA_AddTableIngredient(ingredients, 'White myrtle', 2);
		CA_AddTableIngredient(ingredients, 'Balisse fruit', 1);
		CA_AddTableIngredient(ingredients, 'Hellebore petals', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'White Gull 1', 1);
		CA_AddTableIngredient(ingredients, 'White Honey 2', 1);
		CA_AddTableIngredient(ingredients, 'Honeysuckle', 4);
		CA_AddTableIngredient(ingredients, 'White myrtle', 4);
		CA_AddTableIngredient(ingredients, 'Balisse fruit', 1);
		CA_AddTableIngredient(ingredients, 'Hellebore petals', 1);
		CA_AddTableIngredient(ingredients, 'Vitriol', 1);
	}
}

// White Raffards Decoction 1
function CA_TableRecipe_White_Raffards_Decoction_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Ribleaf', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Ribleaf', 2);
		CA_AddTableIngredient(ingredients, 'Nekker heart', 4);
	}
}

// White Raffards Decoction 2
function CA_TableRecipe_White_Raffards_Decoction_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Ribleaf', 2);
		CA_AddTableIngredient(ingredients, 'Bryonia', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'White Raffards Decoction 1', 1);
		CA_AddTableIngredient(ingredients, 'Ribleaf', 4);
		CA_AddTableIngredient(ingredients, 'Bryonia', 1);
		CA_AddTableIngredient(ingredients, 'Nekker heart', 5);
	}
}

// White Raffards Decoction 3
function CA_TableRecipe_White_Raffards_Decoction_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alcohest', 1);
		CA_AddTableIngredient(ingredients, 'Ribleaf', 2);
		CA_AddTableIngredient(ingredients, 'Bryonia', 2);
		CA_AddTableIngredient(ingredients, 'Pringrape', 1);
		CA_AddTableIngredient(ingredients, 'Bison Grass', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'White Gull 1', 1);
		CA_AddTableIngredient(ingredients, 'White Raffards Decoction 2', 1);
		CA_AddTableIngredient(ingredients, 'Ribleaf', 4);
		CA_AddTableIngredient(ingredients, 'Bryonia', 4);
		CA_AddTableIngredient(ingredients, 'Pringrape', 1);
		CA_AddTableIngredient(ingredients, 'Bison Grass', 1);
		CA_AddTableIngredient(ingredients, 'Vermilion', 1);
	}
}

// Dancing Star 1
function CA_TableRecipe_Dancing_Star_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Saltpetre', 1);
		CA_AddTableIngredient(ingredients, 'Sulfur', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Saltpetre', 1);
		CA_AddTableIngredient(ingredients, 'Sulfur', 2);
	}
}

// Dancing Star 2
function CA_TableRecipe_Dancing_Star_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Stammelfords dust', 1);
		CA_AddTableIngredient(ingredients, 'Phosphorus', 1);
		CA_AddTableIngredient(ingredients, 'Sulfur', 1);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 1);
		CA_AddTableIngredient(ingredients, 'Hellebore petals', 1);
		CA_AddTableIngredient(ingredients, 'Nostrix', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Stammelfords dust', 1);
		CA_AddTableIngredient(ingredients, 'Dancing Star 1', 1);
		CA_AddTableIngredient(ingredients, 'Phosphorus', 1);
		CA_AddTableIngredient(ingredients, 'Sulfur', 1);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 1);
		CA_AddTableIngredient(ingredients, 'Hellebore petals', 1);
		CA_AddTableIngredient(ingredients, 'Nostrix', 1);
	}
}

// Dancing Star 3
function CA_TableRecipe_Dancing_Star_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alchemists powder', 1);
		CA_AddTableIngredient(ingredients, 'Phosphorus', 1);
		CA_AddTableIngredient(ingredients, 'Sulfur', 1);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 1);
		CA_AddTableIngredient(ingredients, 'Nostrix', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Alchemists powder', 1);
		CA_AddTableIngredient(ingredients, 'Dancing Star 2', 1);
		CA_AddTableIngredient(ingredients, 'Phosphorus', 2);
		CA_AddTableIngredient(ingredients, 'Sulfur', 2);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 2);
		CA_AddTableIngredient(ingredients, 'Nostrix', 2);
		CA_AddTableIngredient(ingredients, 'Nigredo', 1);
	}
}

// Devils Puffball 1
function CA_TableRecipe_Devils_Puffball_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Saltpetre', 1);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Saltpetre', 1);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 2);
	}
}

// Devils Puffball 2
function CA_TableRecipe_Devils_Puffball_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Stammelfords dust', 1);
		CA_AddTableIngredient(ingredients, 'Calcium equum', 1);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 1);
		CA_AddTableIngredient(ingredients, 'Ginatia petals', 1);
		CA_AddTableIngredient(ingredients, 'Green mold', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Stammelfords dust', 1);
		CA_AddTableIngredient(ingredients, 'Devils Puffball 1', 1);
		CA_AddTableIngredient(ingredients, 'Calcium equum', 1);
		CA_AddTableIngredient(ingredients, 'Endriag heart', 1);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 1);
		CA_AddTableIngredient(ingredients, 'Ginatia petals', 1);
		CA_AddTableIngredient(ingredients, 'Green mold', 1);
	}
}

// Devils Puffball 3
function CA_TableRecipe_Devils_Puffball_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alchemists powder', 1);
		CA_AddTableIngredient(ingredients, 'Calcium equum', 1);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 1);
		CA_AddTableIngredient(ingredients, 'Ginatia petals', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Alchemists powder', 1);
		CA_AddTableIngredient(ingredients, 'Devils Puffball 2', 1);
		CA_AddTableIngredient(ingredients, 'Calcium equum', 2);
		CA_AddTableIngredient(ingredients, 'Endriag heart', 2);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 2);
		CA_AddTableIngredient(ingredients, 'Ginatia petals', 2);
		CA_AddTableIngredient(ingredients, 'Rebis', 1);
	}
}

// Dragons Dream 1
function CA_TableRecipe_Dragons_Dream_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Saltpetre', 1);
		CA_AddTableIngredient(ingredients, 'Phosphorus', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Saltpetre', 1);
		CA_AddTableIngredient(ingredients, 'Phosphorus', 2);
	}
}

// Dragons Dream 2
function CA_TableRecipe_Dragons_Dream_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Stammelfords dust', 1);
		CA_AddTableIngredient(ingredients, 'Phosphorus', 1);
		CA_AddTableIngredient(ingredients, 'Mistletoe', 1);
		CA_AddTableIngredient(ingredients, 'Allspice root', 1);
		CA_AddTableIngredient(ingredients, 'Bryonia', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Stammelfords dust', 1);
		CA_AddTableIngredient(ingredients, 'Dragons Dream 1', 1);
		CA_AddTableIngredient(ingredients, 'Phosphorus', 1);
		CA_AddTableIngredient(ingredients, 'Optima mater', 1);
		CA_AddTableIngredient(ingredients, 'Mistletoe', 1);
		CA_AddTableIngredient(ingredients, 'Allspice root', 1);
		CA_AddTableIngredient(ingredients, 'Bryonia', 1);
	}
}

// Dragons Dream 3
function CA_TableRecipe_Dragons_Dream_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alchemists powder', 1);
		CA_AddTableIngredient(ingredients, 'Phosphorus', 1);
		CA_AddTableIngredient(ingredients, 'Allspice root', 1);
		CA_AddTableIngredient(ingredients, 'Bryonia', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Alchemists powder', 1);
		CA_AddTableIngredient(ingredients, 'Dragons Dream 2', 1);
		CA_AddTableIngredient(ingredients, 'Phosphorus', 2);
		CA_AddTableIngredient(ingredients, 'Optima mater', 2);
		CA_AddTableIngredient(ingredients, 'Allspice root', 2);
		CA_AddTableIngredient(ingredients, 'Bryonia', 2);
		CA_AddTableIngredient(ingredients, 'Aether', 1);
	}
}

// Dwimeritium Bomb 1
function CA_TableRecipe_Dwimeritium_Bomb_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Saltpetre', 3);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Saltpetre', 5);
		CA_AddTableIngredient(ingredients, 'Optima mater', 2);
	}
}

// Dwimeritium Bomb 2
function CA_TableRecipe_Dwimeritium_Bomb_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Stammelfords dust', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 1);
		CA_AddTableIngredient(ingredients, 'Ginatia petals', 1);
		CA_AddTableIngredient(ingredients, 'Bloodmoss', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Stammelfords dust', 1);
		CA_AddTableIngredient(ingredients, 'Dwimeritium Bomb 1', 1);
		CA_AddTableIngredient(ingredients, 'Optima mater', 1);
		CA_AddTableIngredient(ingredients, 'Powdered pearl', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 1);
		CA_AddTableIngredient(ingredients, 'Ginatia petals', 1);
		CA_AddTableIngredient(ingredients, 'Bloodmoss', 1);
	}
}

// Dwimeritium Bomb 3
function CA_TableRecipe_Dwimeritium_Bomb_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alchemists powder', 1);
		CA_AddTableIngredient(ingredients, 'Pigskin puffball', 1);
		CA_AddTableIngredient(ingredients, 'Bloodmoss', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Alchemists powder', 1);
		CA_AddTableIngredient(ingredients, 'Dwimeritium Bomb 2', 1);
		CA_AddTableIngredient(ingredients, 'Optima mater', 2);
		CA_AddTableIngredient(ingredients, 'Powdered pearl', 2);
		CA_AddTableIngredient(ingredients, 'Pigskin puffball', 2);
		CA_AddTableIngredient(ingredients, 'Bloodmoss', 2);
		CA_AddTableIngredient(ingredients, 'Nigredo', 1);
	}
}

// Grapeshot 1
function CA_TableRecipe_Grapeshot_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Saltpetre', 1);
		CA_AddTableIngredient(ingredients, 'Calcium equum', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Saltpetre', 2);
		CA_AddTableIngredient(ingredients, 'Calcium equum', 2);
	}
}

// Grapeshot 2
function CA_TableRecipe_Grapeshot_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Stammelfords dust', 1);
		CA_AddTableIngredient(ingredients, 'Calcium equum', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 1);
		CA_AddTableIngredient(ingredients, 'Crows eye', 1);
		CA_AddTableIngredient(ingredients, 'Longrube', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Stammelfords dust', 1);
		CA_AddTableIngredient(ingredients, 'Grapeshot 1', 1);
		CA_AddTableIngredient(ingredients, 'Calcium equum', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 1);
		CA_AddTableIngredient(ingredients, 'Crows eye', 1);
		CA_AddTableIngredient(ingredients, 'Longrube', 1);
	}
}

// Grapeshot 3
function CA_TableRecipe_Grapeshot_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alchemists powder', 1);
		CA_AddTableIngredient(ingredients, 'Calcium equum', 1);
		CA_AddTableIngredient(ingredients, 'Sulfur', 1);
		CA_AddTableIngredient(ingredients, 'Longrube', 1);
		CA_AddTableIngredient(ingredients, 'Hop umbels', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Alchemists powder', 1);
		CA_AddTableIngredient(ingredients, 'Grapeshot 2', 1);
		CA_AddTableIngredient(ingredients, 'Calcium equum', 2);
		CA_AddTableIngredient(ingredients, 'Sulfur', 2);
		CA_AddTableIngredient(ingredients, 'Longrube', 2);
		CA_AddTableIngredient(ingredients, 'Hop umbels', 2);
		CA_AddTableIngredient(ingredients, 'Nigredo', 1);
	}
}

// Samum 1
function CA_TableRecipe_Samum_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Saltpetre', 1);
		CA_AddTableIngredient(ingredients, 'Celandine', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Saltpetre', 1);
		CA_AddTableIngredient(ingredients, 'Celandine', 2);
	}
}

// Samum 2
function CA_TableRecipe_Samum_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Stammelfords dust', 1);
		CA_AddTableIngredient(ingredients, 'Phosphorus', 1);
		CA_AddTableIngredient(ingredients, 'Celandine', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Stammelfords dust', 1);
		CA_AddTableIngredient(ingredients, 'Samum 1', 1);
		CA_AddTableIngredient(ingredients, 'Phosphorus', 1);
		CA_AddTableIngredient(ingredients, 'Fogling teeth', 1);
		CA_AddTableIngredient(ingredients, 'Celandine', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 1);
	}
}

// Samum 3
function CA_TableRecipe_Samum_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alchemists powder', 1);
		CA_AddTableIngredient(ingredients, 'Phosphorus', 1);
		CA_AddTableIngredient(ingredients, 'Celandine', 1);
		CA_AddTableIngredient(ingredients, 'Hellebore petals', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Alchemists powder', 1);
		CA_AddTableIngredient(ingredients, 'Samum 2', 1);
		CA_AddTableIngredient(ingredients, 'Phosphorus', 2);
		CA_AddTableIngredient(ingredients, 'Fogling teeth', 2);
		CA_AddTableIngredient(ingredients, 'Celandine', 2);
		CA_AddTableIngredient(ingredients, 'Hellebore petals', 2);
		CA_AddTableIngredient(ingredients, 'Aether', 1);
	}
}

// Silver Dust Bomb 1
function CA_TableRecipe_Silver_Dust_Bomb_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Saltpetre', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Saltpetre', 1);
		CA_AddTableIngredient(ingredients, 'Quicksilver solution', 2);
	}
}

// Silver Dust Bomb 2
function CA_TableRecipe_Silver_Dust_Bomb_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Stammelfords dust', 1);
		CA_AddTableIngredient(ingredients, 'Sulfur', 1);
		CA_AddTableIngredient(ingredients, 'Hop umbels', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 1);
		CA_AddTableIngredient(ingredients, 'Honeysuckle', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Stammelfords dust', 1);
		CA_AddTableIngredient(ingredients, 'Silver Dust Bomb 1', 1);
		CA_AddTableIngredient(ingredients, 'Quicksilver solution', 1);
		CA_AddTableIngredient(ingredients, 'Sulfur', 1);
		CA_AddTableIngredient(ingredients, 'Hop umbels', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 1);
		CA_AddTableIngredient(ingredients, 'Honeysuckle', 1);
	}
}

// Silver Dust Bomb 3
function CA_TableRecipe_Silver_Dust_Bomb_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Alchemists powder', 1);
		CA_AddTableIngredient(ingredients, 'Sulfur', 1);
		CA_AddTableIngredient(ingredients, 'Hop umbels', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Alchemists powder', 1);
		CA_AddTableIngredient(ingredients, 'Silver Dust Bomb 2', 1);
		CA_AddTableIngredient(ingredients, 'Quicksilver solution', 2);
		CA_AddTableIngredient(ingredients, 'Sulfur', 2);
		CA_AddTableIngredient(ingredients, 'Hop umbels', 2);
		CA_AddTableIngredient(ingredients, 'Blowbill', 2);
		CA_AddTableIngredient(ingredients, 'Nigredo', 1);
	}
}

// White Frost 1
function CA_TableRecipe_White_Frost_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Saltpetre', 1);
		CA_AddTableIngredient(ingredients, 'Ducal water', 1);
		CA_AddTableIngredient(ingredients, 'Allspice root', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Saltpetre', 1);
		CA_AddTableIngredient(ingredients, 'Ducal water', 1);
		CA_AddTableIngredient(ingredients, 'Powdered pearl', 1);
		CA_AddTableIngredient(ingredients, 'Allspice root', 2);
	}
}

// White Frost 2
function CA_TableRecipe_White_Frost_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Stammelfords dust', 1);
		CA_AddTableIngredient(ingredients, 'Ducal water', 1);
		CA_AddTableIngredient(ingredients, 'Fools parsley leaves', 1);
		CA_AddTableIngredient(ingredients, 'Verbena', 1);
		CA_AddTableIngredient(ingredients, 'Allspice root', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Stammelfords dust', 1);
		CA_AddTableIngredient(ingredients, 'White Frost 1', 1);
		CA_AddTableIngredient(ingredients, 'Ducal water', 2);
		CA_AddTableIngredient(ingredients, 'Powdered pearl', 1);
		CA_AddTableIngredient(ingredients, 'Fools parsley leaves', 1);
		CA_AddTableIngredient(ingredients, 'Verbena', 1);
		CA_AddTableIngredient(ingredients, 'Allspice root', 2);
	}
}

// White Frost 3
function CA_TableRecipe_White_Frost_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Saltpetre', 1);
		CA_AddTableIngredient(ingredients, 'Ducal water', 2);
		CA_AddTableIngredient(ingredients, 'Verbena', 1);
		CA_AddTableIngredient(ingredients, 'Allspice root', 2);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Saltpetre', 1);
		CA_AddTableIngredient(ingredients, 'White Frost 2', 1);
		CA_AddTableIngredient(ingredients, 'Ducal water', 3);
		CA_AddTableIngredient(ingredients, 'Powdered pearl', 2);
		CA_AddTableIngredient(ingredients, 'Verbena', 2);
		CA_AddTableIngredient(ingredients, 'Allspice root', 3);
		CA_AddTableIngredient(ingredients, 'Quebrith', 1);
	}
}

// Mutagen 1
function CA_TableRecipe_Mutagen_1(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Verbena', 1);
		CA_AddTableIngredient(ingredients, 'Arenaria', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Katakan mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Verbena', 1);
		CA_AddTableIngredient(ingredients, 'Arenaria', 1);
	}
}

// Mutagen 2
function CA_TableRecipe_Mutagen_2(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'White myrtle', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Arachas mutagen', 1);
		CA_AddTableIngredient(ingredients, 'White myrtle', 1);
	}
}

// Mutagen 3
function CA_TableRecipe_Mutagen_3(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Crows eye', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Cockatrice mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Crows eye', 1);
	}
}

// Mutagen 4
function CA_TableRecipe_Mutagen_4(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Ribleaf', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Volcanic Gryphon mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Ribleaf', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 1);
	}
}

// Mutagen 5
function CA_TableRecipe_Mutagen_5(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Water Hag mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 1);
	}
}

// Mutagen 6
function CA_TableRecipe_Mutagen_6(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Mistletoe', 1);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Nightwraith mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Mistletoe', 1);
		CA_AddTableIngredient(ingredients, 'Sewant mushrooms', 1);
	}
}

// Mutagen 7
function CA_TableRecipe_Mutagen_7(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'White myrtle', 1);
		CA_AddTableIngredient(ingredients, 'Mandrake root', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Ekimma mutagen', 1);
		CA_AddTableIngredient(ingredients, 'White myrtle', 1);
		CA_AddTableIngredient(ingredients, 'Mandrake root', 1);
	}
}

// Mutagen 8
function CA_TableRecipe_Mutagen_8(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Pigskin puffball', 1);
		CA_AddTableIngredient(ingredients, 'Cortinarius', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Czart mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Pigskin puffball', 1);
		CA_AddTableIngredient(ingredients, 'Cortinarius', 1);
	}
}

// Mutagen 9
function CA_TableRecipe_Mutagen_9(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Fools parsley leaves', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Fogling 1 mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Fools parsley leaves', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 1);
	}
}

// Mutagen 10
function CA_TableRecipe_Mutagen_10(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Moleyarrow', 1);
		CA_AddTableIngredient(ingredients, 'Celandine', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Wyvern mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Moleyarrow', 1);
		CA_AddTableIngredient(ingredients, 'Celandine', 1);
	}
}

// Mutagen 11
function CA_TableRecipe_Mutagen_11(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Han', 1);
		CA_AddTableIngredient(ingredients, 'Longrube', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Doppler mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Han', 1);
		CA_AddTableIngredient(ingredients, 'Longrube', 1);
	}
}

// Mutagen 12
function CA_TableRecipe_Mutagen_12(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Crows eye', 1);
		CA_AddTableIngredient(ingredients, 'Honeysuckle', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Troll mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Crows eye', 1);
		CA_AddTableIngredient(ingredients, 'Honeysuckle', 1);
	}
}

// Mutagen 13
function CA_TableRecipe_Mutagen_13(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Ginatia petals', 1);
		CA_AddTableIngredient(ingredients, 'Ergot seeds', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Noonwraith mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Ginatia petals', 1);
		CA_AddTableIngredient(ingredients, 'Ergot seeds', 1);
	}
}

// Mutagen 14
function CA_TableRecipe_Mutagen_14(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Green mold', 1);
		CA_AddTableIngredient(ingredients, 'Allspice root', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Succubus mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Green mold', 1);
		CA_AddTableIngredient(ingredients, 'Allspice root', 1);
	}
}

// Mutagen 15
function CA_TableRecipe_Mutagen_15(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Buckthorn', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Lesser mutagen red', 5);
		CA_AddTableIngredient(ingredients, 'Alghoul bone marrow', 1);
		CA_AddTableIngredient(ingredients, 'Buckthorn', 1);
	}
}

// Mutagen 16
function CA_TableRecipe_Mutagen_16(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Hellebore petals', 1);
		CA_AddTableIngredient(ingredients, 'Fools parsley leaves', 1);
		CA_AddTableIngredient(ingredients, 'Arenaria', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Fiend mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Hellebore petals', 1);
		CA_AddTableIngredient(ingredients, 'Fools parsley leaves', 1);
		CA_AddTableIngredient(ingredients, 'Arenaria', 1);
	}
}

// Mutagen 17
function CA_TableRecipe_Mutagen_17(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Moleyarrow', 1);
		CA_AddTableIngredient(ingredients, 'Bryonia', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Forktail mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Moleyarrow', 1);
		CA_AddTableIngredient(ingredients, 'Bryonia', 1);
	}
}

// Mutagen 18
function CA_TableRecipe_Mutagen_18(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Longrube', 1);
		CA_AddTableIngredient(ingredients, 'Cortinarius', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Grave Hag mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Longrube', 1);
		CA_AddTableIngredient(ingredients, 'Cortinarius', 1);
	}
}

// Mutagen 19
function CA_TableRecipe_Mutagen_19(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 1);
		CA_AddTableIngredient(ingredients, 'Nostrix', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Wraith mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 1);
		CA_AddTableIngredient(ingredients, 'Nostrix', 1);
	}
}

// Mutagen 20
function CA_TableRecipe_Mutagen_20(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Balisse fruit', 1);
		CA_AddTableIngredient(ingredients, 'Pringrape', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Dao mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Balisse fruit', 1);
		CA_AddTableIngredient(ingredients, 'Pringrape', 1);
	}
}

// Mutagen 21
function CA_TableRecipe_Mutagen_21(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Ribleaf', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Lamia mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Ribleaf', 1);
		CA_AddTableIngredient(ingredients, 'Berbercane fruit', 1);
	}
}

// Mutagen 22
function CA_TableRecipe_Mutagen_22(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Mandrake root', 1);
		CA_AddTableIngredient(ingredients, 'Ginatia petals', 1);
		CA_AddTableIngredient(ingredients, 'Honeysuckle', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Ancient Leshy mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Mandrake root', 1);
		CA_AddTableIngredient(ingredients, 'Ginatia petals', 1);
		CA_AddTableIngredient(ingredients, 'Honeysuckle', 1);
	}
}

// Mutagen 23
function CA_TableRecipe_Mutagen_23(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 1);
		CA_AddTableIngredient(ingredients, 'Fools parsley leaves', 1);
		CA_AddTableIngredient(ingredients, 'Beggartick blossoms', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Basilisk mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Blowbill', 1);
		CA_AddTableIngredient(ingredients, 'Fools parsley leaves', 1);
		CA_AddTableIngredient(ingredients, 'Beggartick blossoms', 1);
	}
}

// Mutagen 24
function CA_TableRecipe_Mutagen_24(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Beggartick blossoms', 1);
		CA_AddTableIngredient(ingredients, 'Hop umbels', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Werewolf mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Beggartick blossoms', 1);
		CA_AddTableIngredient(ingredients, 'Hop umbels', 1);
	}
}

// Mutagen 25
function CA_TableRecipe_Mutagen_25(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Fools parsley leaves', 1);
		CA_AddTableIngredient(ingredients, 'Ranogrin', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Nekker Warrior mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Fools parsley leaves', 1);
		CA_AddTableIngredient(ingredients, 'Ranogrin', 1);
	}
}

// Mutagen 26
function CA_TableRecipe_Mutagen_26(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Moleyarrow', 1);
		CA_AddTableIngredient(ingredients, 'Pringrape', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Leshy mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Moleyarrow', 1);
		CA_AddTableIngredient(ingredients, 'Pringrape', 1);
	}
}

// Mutagen 27
function CA_TableRecipe_Mutagen_27(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Oil', 1);
		CA_AddTableIngredient(ingredients, 'Bryonia', 1);
		CA_AddTableIngredient(ingredients, 'Wolf liver', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
		CA_AddTableIngredient(ingredients, 'Gryphon mutagen', 1);
		CA_AddTableIngredient(ingredients, 'Oil', 1);
		CA_AddTableIngredient(ingredients, 'Bryonia', 1);
		CA_AddTableIngredient(ingredients, 'Wolf liver', 1);
	}
}

// Mutagen 28
function CA_TableRecipe_Mutagen_28(isCopy : bool, out ingredients : array<SItemParts>)
{
	if(isCopy)
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 1);
	}
	else
	{
		CA_AddTableIngredient(ingredients, 'Dwarven spirit', 5);
		CA_AddTableIngredient(ingredients, 'Lesser mutagen red', 4);
		CA_AddTableIngredient(ingredients, 'Lesser mutagen green', 4);
		CA_AddTableIngredient(ingredients, 'Lesser mutagen blue', 4);
		CA_AddTableIngredient(ingredients, 'Wraith essence', 1);
	}
}
