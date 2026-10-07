# Architektura — Consumable Alchemy

Stan: **v0.4** (kod sesja 7). Numery linii dotyczą skryptów vanilla w obecnej instalacji (gra 5.0.0.1044392, `<gra>\content\content0\scripts\game\...`). Decyzje i ich uzasadnienia: [decisions.md](decisions.md). Receptury i ich dane: [recipes.md](recipes.md).

## Zasada działania

Mod używa adnotacji kompilatora skryptów (`@wrapMethod`, `@replaceMethod`, `@addMethod`; dostępne od 4.0, potwierdzone działanie w 5.0) w **nowych** plikach w `content\scripts\local\` — nie nadpisuje plików vanilla, nie trzeba Script Mergera. Potwierdzone w grze (v0.1): adnotacje działają także na metodach `private`/`final`, `@addMethod` działa na `CInventoryComponent`.

| Plik (`src/modConsumableAlchemy/content/scripts/local/`) | Zawartość |
|---|---|
| `consumableAlchemy_common.ws` | klasyfikacja przedmiotów (`CA_IsConsumableItemName`, `CA_IsConsumableItem`) |
| `consumableAlchemy_inventory.ws` | blokada odnawiania, alkohol/powiadomienia, tutorial, stół w Corvo Bianco |
| `consumableAlchemy_alchemy.ws` | menedżer i menu alchemii (`CanCookRecipe`, `CookItem`, odświeżanie menu) |
| `consumableAlchemy_recipes.ws` | receptura powielania (wspólna funkcja dla wszystkich źródeł receptur) |

## Klasyfikacja „consumable” — `CA_IsConsumableItemName` (common.ws)

Singleton **i** (bomba (`category == petard`) **lub** tag `Potion` — także wywary z tagiem `Mutagen`), z wyłączeniem: `Snow Ball`, `Tutorial Bomb`, `Village drink`, tag `Quest`, tag `NoAdditionalAmmo` (bomby z farbą `q703_paint_bomb_*` z Toussaint), `TAG_INFINITE_AMMO`. `CA_IsConsumableItem(id)` dodatkowo wymaga, by inwentarz należał do gracza.

Limit: od v0.4 **vanilla** — `SingletonItemGetMaxAmmo` bez zmian (atrybut `ammo` + bonusy vanilli; wywary 1, bonusy ich nie dotyczą). Mod nie ma własnej stałej limitu. Historia: v0.1 stałe 3; v0.2–v0.3 `@replaceMethod SingletonItemGetMaxAmmo` z bazą `CA_GetMaxAmmo()` = 3 + bonusy (w v0.2 usunięto też wcześniejszy wrapper `SingletonItemGetAmmo`); usunięte w sesji 7.

## Punkty zaczepienia

| Mechanika | Vanilla | Mod (v0.4) | Wcześniej |
|---|---|---|---|
| Każde odnawianie (medytacja `playerWitcher.ws:10249 MeditationRestoring`, łóżko, stół, `RecoverGeralt`, NG+ `:1191`, tutorial) przechodzi przez `SingletonItemRefillAmmo` (`inventoryComponent.ws:3575`) | ustawia max | `@wrapMethod`: zainicjalizowane consumables (`is_initialized != 0`) → no-op; wszystko inne (nie-consumables, inicjalizacja nowego przedmiotu) → `wrappedMethod` (vanilla) | do v0.3: przy inicjalizacji ustawiało 1 dawkę |
| Inicjalizacja nowego przedmiotu: `OnItemAdded` (`inventoryComponent.ws:4817`) woła refill, potem ustawia `is_initialized = 1` | pełne ładunki | vanilla → max (w Corvo Bianco po użyciu łóżka/stołu vanilla daje max + 1) | do v0.3: 1 dawka |
| Limit: `SingletonItemGetMaxAmmo` (`:3779`) | atrybut `ammo` + bonusy | bez zmian | do v0.3: `@replaceMethod` z bazą 3 |
| Nadmiar ponad limit (stare zapisy, wygaśnięty bonus) | przycina tylko przy zmianie skilla/zestawu (`SkillReduceBombAmmoBonus`, `r4Player.ws:11743`) | bez zmian — nadmiar schodzi przy użyciu. **Nie przycinać przy odczycie**: limit zależy od skilli/buffów, które przy wczytywaniu zapisu mogą być jeszcze nieprzywrócone → trwała utrata dawek | — |
| Alkohol + powiadomienia: `SingletonItemsRefillAmmo` (`:3641`) / `NoAlco` sterowane przez prywatne `HasNotFilledSingletonItem` (`:3712`) | | `@replaceMethod HasNotFilledSingletonItem`: pomija consumables | — |
| Tutorial „uzupełnij alkoholem”: `SingletonItemRemoveAmmo` (`:3749`) dodaje fakt `tut_alch_refill` | | `@replaceMethod`: nie dla consumables | — |
| Stół alchemiczny Corvo Bianco: `ManageSingletonItemsBonus` (`:3832`), wołane z `quest_function.ws:7921 ApplyAlchemyTableBuff` | +1 ponad max | `@replaceMethod`: tylko dźwięk odmowy | — |
| Loot/zakup: `GiveItemTo` (`:745`) | posiadany singleton → odmowa „already cooked” | bez zmian (posiadany → odmowa, nowy → max przez inicjalizację) | do v0.3: `@wrapMethod` — posiadany → +1 dawka i usunięcie z kontenera (przy limicie odmowa), nowy → 1 dawka |
| Warzenie dozwolone?: `W3AlchemyManager.CanCookRecipe` (`alchemyManager.ws:141`) | `EAE_CannotCookMore` dla posiadanych | `@replaceMethod`: consumable posiadany → blokada tylko przy `ammo >= max` | — |
| Warzenie: `CookItem` (`alchemyManager.ws:208`) | nowy przedmiot dostaje max, posiadany bez zmian | `@wrapMethod`: po vanilli każdy egzemplarz uwarzonego consumable z `ammo < max` → `SingletonItemSetAmmo(max)` (pełna kieszeń; nadmiar ponad max nietknięty) | do v0.3: `stare + 1` lub `1` (funkcja `CA_SetConsumableAmmo`, usunięta w sesji 7) |
| UI menu: `alchemyMenu.ws` pokazuje `cantCookReason` z `AlchemyExceptionToString` | | bez zmian (reużycie stringu `panel_alchemy_exception_already_cooked`) | — |

Sesja 7 usunęła: `@replaceMethod SingletonItemGetMaxAmmo`, `CA_GetMaxAmmo`, `@wrapMethod GiveItemTo`, `CA_SetConsumableAmmo`.

## Receptura powielania — `consumableAlchemy_recipes.ws`

`CA_GetRecipeIngredients(recipe)`: jeśli gracz posiada uwarzony przedmiot (`CA_IsCopyRecipe` — consumable i `GetItemQuantityByName > 0`, także 0 dawek) → `CA_GetCopyIngredients`, inaczej pełna receptura. Reguła (v2 + dzielnik, od v0.3): wypada przedmiot niższego poziomu (`category potion/petard`); alkohol (`StrongAlcohol`) zostaje zawsze ×1, `White Gull 1` → `Alcohest`; zostają proszki bazowe bomb (`CA_IsBombBase`) i składniki bez tagu `MutagenIngredient` z `GetItemPrice ≤ CA_GetCopyPriceThreshold()` (16), ilość / `CA_GetCopyQuantityDivisor()` (2) w górę; reszta wypada. `tools\recipes\rule.py [próg] [dzielnik]` liczy dokładnie to samo. Planowane zastąpienie gotową tabelą — [recipes.md](recipes.md).

**Wszystkie źródła receptur muszą dawać tę samą listę** (wspólna funkcja `CA_`), inaczej rozbieżność zdradzi moda:
- `W3AlchemyManager.GetRecipe` (`@replaceMethod`) — `CanCookRecipe`, `CookItem`, `GetRequiredIngredients`. (Receptury z XML ładuje prywatne `LoadRecipesCustomXMLData`, `alchemyManager.ws:46`; menu bierze składniki z `m_recipeList[id].requiredIngredients`, `alchemyMenu.ws:605`.)
- `W3AlchemyManager.GetRecipes` (`@wrapMethod`) — lista w menu.
- globalna `getAlchemyRecipeFromName` (`alchemyManager.ws:534`, `@wrapMethod` **bez klasy** — pierwsze użycie tej składni; v0.3 kompiluje się (sesja 5), działanie tooltipu niepotwierdzone) — tooltip receptury w ekwipunku (`guiBaseInventoryComponent.ws:776`), przypięta receptura (`inventoryMenu.ws:4464`, `guiTooltipComponent.ws:714`).
- `CR4AlchemyMenu.CreateItem` (`@wrapMethod`) — po każdym warzeniu przeładowuje `m_recipeList` i panel składników (vanilla odświeża tylko dla `level > 1`, `alchemyMenu.ws:351`, a po pierwszym warzeniu lista musi się przeliczyć także dla poz. 1).
- `guiTooltipComponent.GetRecipeDataFromXML` (własny loader, `guiTooltipComponent.ws:~2020`) pominięty: w vanilli szuka `'alchemy_recipies'` (literówka) → zawsze pusty.

Dostępne API do danych przedmiotów: `dm.GetItemPrice(name)`, `dm.ItemHasTag`, `dm.GetItemCategory` (`definitionsManager.ws:29-37`). Silnik ma uśpione API kategorii składników (`GetIngredientCategoryElements` / `IsIngredientCategorySpecified`, `commonGame.ws:32-35`) — nieużywane przez skrypty, brak danych w XML; W3 nie ma zamienników składników (`CanCookRecipe` sprawdza po nazwie).

Historyczny błąd v0.2 (naprawiony w v0.3): pełna receptura poz. 2/3 wymaga przedmiotu niższego poziomu, który znika przy pierwszym warzeniu, a niższego nie wolno warzyć (`CanCookRecipe`) → ponowne warzenie poz. 2/3 było niemożliwe (`EAE_NotEnoughIngredients`; wniosek z kodu, niepotwierdzony w grze). Dlatego receptura powielania zawsze usuwa przedmiot niższego poziomu.

## Mechanika vanilli istotna dla moda

- **Widoczność receptur:** vanilla 5.0 `GetRecipes` wymusza `forceAll = true` (`alchemyManager.ws:398`) → menu pokazuje wszystkie poznane receptury, także niższego poziomu po uwarzeniu wyższego (`CanCookRecipe` je blokuje). Kod filtrujący (`ShouldRemoveRecipe`, ukrywanie posiadanych wywarów/poz. 3) jest martwy — pozostałość po starszych wersjach. Mod widoczności nie zmienia. „Znikanie” posiadanych receptur to **filtr menu** (Flash): `PopulateData` przekazuje `canCookStatusForFilter` (`alchemyMenu.ws:459/514`); `EAE_CannotCookMore` (niższy poziom, pełna kieszeń) → ukryte. Potwierdzone w grze (sesja 6): filtry „Posiadasz składniki / Brak składników / Już wykonane” (tylko skrót klawiszowy „Filtry”), „Już wykonane” domyślnie wyłączone. Mod zachowuje statusy → przy limicie mikstura chowa się jak w vanilli, poniżej limitu jest widoczna.
- **Poznanie receptury wyższego poziomu niczego nie wymusza:** `AddAlchemyRecipe` (`playerWitcher.ws:4851`) nie usuwa niższej receptury; przedmiot poz. 1 zostaje do świadomego warzenia poz. 2. Receptury znane od startu nowej gry (`playerWitcher.ws:260`): Jaskółka 1, Kot 1, Biały Miód 1, Samum 1, Kartacz 1, oleje na upiory/trupojady, Alcohest.
- **Walka:** warzenie zablokowane w walce (`EAE_InCombat`, `alchemyManager.ws:156`, `thePlayer.IsInCombat()`); medytacja surowiej (`CanMeditate` / `CanMeditateHere` → `IsThreatened()`, `playerWitcher.ws:10093/10157`). Warzyć można przy wrogach w pobliżu, zanim zacznie się walka (decyzja: zostawić).
- **Alkohol w medytacji vanilli:** 1 sztuka najtańszego `StrongAlcohol` na całą medytację (`GetAlcoholForAlchemicalItemsRefill`, `playerWitcher.ws:5621`).
- **Oleje (zostają vanilla):** w 5.0 przedmiot oleju nie zużywa się przy nakładaniu; powłoka ma ładunki na ciosy (`W3Effect_Oil.ReduceAmmo`, `r4Player.ws:1009`; nieskończona ze skillem `S_Alchemy_s06` poz. 3, `hudModuleBuffs.ws:314`). Medytacja ich nie dotyczy.
- **Wywar Wodnej Baby** (`EET_Mutagen03`, `mutagen03.ws`): przy nałożeniu +1 dawka każdej miksturze/bombie, przy wygaśnięciu −1 — patrz [testing.md](testing.md#znane-skutki-uboczne).
- Mikstur/bomb nie da się sprzedać ani wyrzucić (potwierdzone w grze) → „odblokowania” (posiadania) nie da się stracić.

## Ścieżki dające pełne dawki z pominięciem wrappera odnawiania

- `quest_function.ws:2016/2053/2135/5958/6004` (`AddItemQuest`, `AddItemQuestExt` itd.) — po `AddAnItem` wołają wprost `SingletonItemSetAmmo(max)`.
- `r4Player.ws:15482` (startowe przedmioty nowej gry) i `:15547` (debug) — to samo.
- `StandaloneEp1_1` (`playerWitcher.ws:11428`) / `StandaloneEp2_1` (`:11930`) — starty samodzielne HoS / B&W, patrz [testing.md](testing.md#pułapki-testowe) i [roadmap.md](roadmap.md#samodzielne-starty-dodatków-hos--bw--odłożone-decyzja-użytkownika-sesja-7).

Do v0.3 dawało to niespójność (nagroda = pełne 3 dawki, loot = 1). **Od v0.4 zamierzone:** pozyskanie poza warzeniem = vanilla.

## Degradacja (sprawdzone w kodzie, sesja 6)

Mod nie zapisuje w save'ie nic własnego (brak klas ze stanem, `saved`, faktów, tagów) — tylko vanillowe `ammo_current` / `is_initialized`.
- Usunięcie moda: vanilla uzupełnia przy medytacji tylko gdy `ammo < max` (`inventoryComponent.ws:3599`); nadmiar zostaje i schodzi przy użyciu.
- Dodanie moda: posiadane mikstury od razu mają tanią recepturę.
- Od v0.4 (limity vanilli) nie zostaje widoczny ślad (znika „5/3”).
- Do potwierdzenia w grze: wczytanie zapisu po usunięciu moda (mikstura 0/x, bomba ponad max).
- Mod nie pojawia się na liście modów w menu gry — założenie z sesji 2: normalne dla moda z samych skryptów (brak manifestu/metadanych); w sesji 7 temat w researchu ([roadmap.md](roadmap.md)).
