# CLAUDE.md — Consumable Alchemy (Witcher 3 Remastered mod, gra v5.0)

Kontekst projektu dla kolejnych sesji. Opis dla gracza: [README.md](README.md).

## Cel i decyzje użytkownika (ustalone 2026-10-06)

Zamiana alchemii z singletonów odnawianych medytacją na system zużywalny.

1. Medytacja (i inne odnawianie) **nie** uzupełnia mikstur i bomb.
2. Uwarzone mikstury/bomby można warzyć ponownie. **1 warzenie = 1 sztuka.**
3. **Limit = baza 3** dla każdej mikstury/bomby (zamiast atrybutu `ammo` zależnego od poziomu) **+ bonusy z vanilli** (skill Optymalizacja `S_Alchemy_s08`, buff `EET_Mutagen03`, zestaw `EISB_RedWolf_2`, perk `S_Perk_20`). Zmienione 2026-10-06 (sesja 2): przy stałym 3 opisy skilli w grze były nieprawdziwe.
4. Poziomy jak w vanilli: wyższy poziom usuwa niższy, niższego nie można warzyć mając wyższy.
5. Zakres: mikstury + bomby + **wywary (od sesji 4, limit vanillowy 1)**. Oleje, przedmioty questowe — vanilla.
6. Alkohol jest wyłącznie składnikiem (od sesji 4 nie odnawia już niczego).
7. Języki PL + EN — obecnie **zero nowych stringów** (reużywamy `panel_alchemy_exception_already_cooked`).
8. Brak kompatybilności z innymi modami jako wymóg (użytkownik nie gra z innymi).
9. **Balans składników** — od sesji 2 to bieżący etap; patrz sekcja „Następny etap: balans kosztu warzenia”.

**Twardy wymóg:** pełna „vanillowość” — żadnych nowych napisów, zmian UI, mod-smellu. Jeśli trzeba pokazać komunikat, najpierw szukaj istniejącego klucza lokalizacji.

## Środowisko

- Gra: `D:\gry\steam\steamapps\common\the witcher 3` (Steam, wersja Remastered — `witcher3.exe` raportuje **5.0.0.1044392**, exe w `bin\x64_dx12`). Uwaga: to nowsze niż aktualizacja next-gen 4.0 z 2022 r.; nie zakładaj, że wiedza o 4.x jest aktualna — weryfikuj w skryptach vanilla z tej instalacji.
- Skrypty vanilla (referencja, tylko do odczytu): `<gra>\content\content0\scripts\game\...`
- Depot RedKit: **usunięty przez użytkownika (sesja 2), niepotrzebny** — XML-e gry wyciągamy z bundli narzędziami z `tools\recipes\` (sesja 3):
  - `python tools\recipes\bundle.py list|extract <bundle> <wzorzec> [katalog]` — czytnik `POTATO70` (wpis TOC 0x130 B: nazwa 0x100, hash 16, offset/0/size/zsize/crc/kompresja; 0 = brak, 1 = zlib). Pliki trafiają do `tools\recipes\x\`.
  - Gdzie co jest: `xml.bundle` → `gameplay\items\*.xml` (baza + wersje `items_plus` dla NG+); `ep1.bundle` / `bob.bundle` → `dlc\ep1|bob\data\gameplay\items\*.xml`. Jest tylko `content\content0` (dodatki w nim, brak katalogu `dlc`).
  - `recipes.py` → `data.json` (przedmioty + receptury), `table.py` → tabela receptur mikstur/bomb, `rule.py [próg]` → symulacja reguły receptury powielania.
- Instalacja moda: `deploy.bat` (dwuklik; nakładka na `deploy.ps1`, opcjonalny argument: ścieżka gry) → `<gra>\mods\modConsumableAlchemy`.
- Kompilacja: gra kompiluje skrypty przy starcie; błędy pokazuje w oknie przy uruchomieniu.
- Repozytorium: git (gałąź `main`), **publiczne** repo GitHub https://github.com/TheBlokOfficial/consumable-alchemy (od sesji 5; wszystko, co commitujesz, jest jawne). Autor commitów: `TheBlokOfficial <tomasznosal.mail@proton.me>` (lokalny config repo). **Nie commitować danych gry** — `tools/recipes/x/` (wypakowane XML-e CDPR) i `data.json` są w `.gitignore`; odtworzyć przez `bundle.py extract` + `recipes.py`.
- `README.md` = strona moda dla gracza (PL, bez technikaliów, styl strony na Nexusie). Szczegóły techniczne tylko tutaj.

```
src/modConsumableAlchemy/content/scripts/local/
  consumableAlchemy_common.ws     – limit, klasyfikacja przedmiotów, helpery
  consumableAlchemy_inventory.ws  – blokada odnawiania, limit, loot
  consumableAlchemy_alchemy.ws    – menedżer i menu alchemii (warzenie)
  consumableAlchemy_recipes.ws    – receptura powielania
tools/recipes/                    – narzędzia do danych receptur (Python)
deploy.bat / deploy.ps1           – instalacja do folderu gry
```

## Architektura

Mod używa adnotacji kompilatora skryptów (`@wrapMethod`, `@replaceMethod`, `@addMethod`; dostępne od 4.0, potwierdzone działanie w 5.0) w **nowych** plikach w `content\scripts\local\` — nie nadpisuje plików vanilla. Dzięki temu nie trzeba Script Mergera.

**Ograniczenie kompilatora (potwierdzone):** w funkcji z `@wrapMethod` słowo `wrappedMethod` może wystąpić **tylko raz** — każde kolejne daje błąd „Could not find function 'wrappedMethod'”. Najpierw ustal, co robić, potem jedno wywołanie.

Ostrzeżenia `[content0] ... not marked as abstract` / `has no autostate` przy kompilacji pochodzą z vanilli — ignorować.

Konwencja: wszystko własne ma prefiks `CA_`. Kod naśladuje styl vanilli (taby, `if(...)`, deklaracje zmiennych na początku funkcji — wymóg WitcherScript).

### Klasyfikacja „consumable” — `CA_IsConsumableItemName` (common.ws)
Singleton **i** (bomba (`category == petard`) **lub** tag `Potion` — także wywary z tagiem `Mutagen`), z wyłączeniem: `Snow Ball`, `Tutorial Bomb`, `Village drink`, tag `Quest`, tag `NoAdditionalAmmo` (bomby z farbą `q703_paint_bomb_*` z Toussaint), `TAG_INFINITE_AMMO`. `CA_IsConsumableItem(id)` dodatkowo wymaga, by inwentarz należał do gracza. Limit: mikstury/bomby `CA_GetMaxAmmo()` (3) + bonusy; wywary (`IsItemMutagenPotion`) zachowują atrybut `ammo` (1), bonusy vanilli ich nie dotyczą.

### Receptura powielania — `consumableAlchemy_recipes.ws`
`CA_GetRecipeIngredients(recipe)`: jeśli gracz posiada uwarzony przedmiot (`CA_IsCopyRecipe` — consumable i `GetItemQuantityByName > 0`, także 0 dawek) → `CA_GetCopyIngredients`, inaczej pełna receptura. Reguła: wypada przedmiot niższego poziomu (`category potion/petard`); alkohol (`StrongAlcohol`) zostaje zawsze ×1, `White Gull 1` → `Alcohest`; zostają proszki bazowe bomb (`CA_IsBombBase`) i składniki bez tagu `MutagenIngredient` z `GetItemPrice ≤ CA_GetCopyPriceThreshold()` (16), ilość / `CA_GetCopyQuantityDivisor()` (2) w górę; reszta wypada. Narzędzie `tools\recipes\rule.py [próg] [dzielnik]` liczy dokładnie to samo (tabela wyników). Wszystkie trzy źródła receptur dają tę samą listę:
- `W3AlchemyManager.GetRecipe` (`@replaceMethod`) — `CanCookRecipe`, `CookItem`, `GetRequiredIngredients`;
- `W3AlchemyManager.GetRecipes` (`@wrapMethod`) — lista w menu;
- globalna `getAlchemyRecipeFromName` (`@wrapMethod` **bez klasy** — pierwsze użycie tej składni, niepotwierdzone) — tooltip receptury w ekwipunku, przypięta receptura;
- `CR4AlchemyMenu.CreateItem` (`@wrapMethod`) — po każdym warzeniu przeładowuje `m_recipeList` i panel składników (vanilla tylko dla poz. > 1).
- `guiTooltipComponent.GetRecipeDataFromXML` pominięty: w vanilli szuka `'alchemy_recipies'` (literówka) → zawsze pusty.

### Punkty zaczepienia (numery linii — vanilla w obecnej instalacji)

| Mechanika | Vanilla | Zmiana w modzie |
|---|---|---|
| Każde odnawianie (medytacja `playerWitcher.ws:10249 MeditationRestoring`, łóżko, stół, `RecoverGeralt`, NG+ `:1191`, tutorial) przechodzi przez `SingletonItemRefillAmmo` (`inventoryComponent.ws:3575`) | ustawia max | `@wrapMethod`: dla consumables tylko inicjalizacja (gdy `is_initialized == 0` → 1 dawka), poza tym no-op |
| Inicjalizacja nowego przedmiotu: `OnItemAdded` (`inventoryComponent.ws:4817`) woła refill, potem ustawia `is_initialized = 1` | pełne ładunki | dzięki powyższemu → 1 dawka |
| Limit: `SingletonItemGetMaxAmmo` (`:3779`) | atrybut `ammo` + bonusy | `@replaceMethod`: kopia vanilli, dla consumables baza = `CA_GetMaxAmmo()` (3) zamiast atrybutu; bonusy bez zmian |
| Nadmiar ponad limit (stare zapisy, wygaśnięty bonus) | vanilla przycina tylko przy zmianie skilla/zestawu (`SkillReduceBombAmmoBonus`, `r4Player.ws:11743`) | bez zmian — nadmiar schodzi przy użyciu. **Nie** przycinać przy odczycie: limit zależy od skilli/buffów, które przy wczytywaniu zapisu mogą być jeszcze nieprzywrócone → trwała utrata dawek |
| Alkohol + powiadomienia: `SingletonItemsRefillAmmo` (`:3641`) / `NoAlco` sterowane przez prywatne `HasNotFilledSingletonItem` (`:3712`) | | `@replaceMethod HasNotFilledSingletonItem`: pomija consumables |
| Tutorial „uzupełnij alkoholem”: `SingletonItemRemoveAmmo` (`:3749`) dodaje fakt `tut_alch_refill` | | `@replaceMethod`: nie dla consumables |
| Stół alchemiczny Corvo Bianco: `ManageSingletonItemsBonus` (`:3832`), wołane z `quest_function.ws:7921 ApplyAlchemyTableBuff` | +1 ponad max | `@replaceMethod`: tylko dźwięk odmowy |
| Loot/zakup: `GiveItemTo` (`:745`) odrzuca posiadany singleton z komunikatem „already cooked” | | `@wrapMethod`: posiadany → +1 dawka i usunięcie z kontenera; przy limicie vanilla odmowa; nowy → 1 dawka |
| Warzenie dozwolone?: `W3AlchemyManager.CanCookRecipe` (`alchemyManager.ws:141`) zwraca `EAE_CannotCookMore` dla posiadanych | | `@replaceMethod`: consumable posiadany → blokada tylko przy `ammo >= max` |
| Warzenie: `CookItem` (`alchemyManager.ws:208`) — nowy przedmiot dostaje max, posiadany bez zmian | | `@wrapMethod`: po vanilla ustawia `stare + 1` lub `1` |
| UI menu: `alchemyMenu.ws` pokazuje `cantCookReason` z `AlchemyExceptionToString` | | bez zmian (reużycie stringu) |

## Status (2026-10-06, sesja 4) — v0.3, wgrane; sesja 5: użytkownik „chyba działa” (kompiluje się, wstępnie OK — szczegółowa lista niżej nieodhaczona)

Zaimplementowany wariant A: receptura powielania (v2 + połowa ilości), wywary w systemie (limit 1), wyłączenie przedmiotów questowych z systemu. Naprawia błąd v0.2 (ponowne warzenie poz. 2/3 — receptura powielania nie wymaga już niższego poziomu).

### Do sprawdzenia w grze (sesja 4)
- [ ] Kompilacja — szczególnie `@wrapMethod` bez nawiasów na globalnej `getAlchemyRecipeFromName` (recipes.ws). Jeśli błąd składni: spróbować `@wrapMethod()`, w ostateczności usunąć wrapper (tooltip receptury w ekwipunku pokaże wtedy pełną listę).
- [ ] Pierwsze warzenie = pełna receptura; zaraz potem prawy panel menu pokazuje krótszą listę (bez zamykania menu).
- [ ] Mikstura z 0 dawek → krótka receptura; warzenie jej zabiera właściwe składniki.
- [ ] Ponowne warzenie poz. 2 i 3 (np. Jaskółka 2: `Alcohest` + 3× Glistnik + 2× Mirt) — bez przedmiotu poz. 1.
- [ ] Poz. 3: `Alcohest` zamiast `White Gull 1`.
- [ ] Wywar: medytacja go nie odnawia, nie zużywa alkoholu; po wypiciu można uwarzyć ponownie (krótka receptura: alkohol + zioła, bez mutagenu); przy 1/1 komunikat „już uwarzono”.
- [ ] Tooltip receptury w ekwipunku i przypięta receptura pokazują tę samą listę co menu.
- [ ] `GetItemPrice` zwraca cenę bazową z XML (jeśli nie — w liście zostaną/wypadną inne składniki niż w `rule.py`).

### Znane skutki uboczne / do decyzji
- Wywar Wodnej Baby (`EET_Mutagen03`, `mutagen03.ws`): przy nałożeniu vanilla daje **+1 dawkę** każdej miksturze/bombie (także z 0 dawek — darmowa dawka), przy wygaśnięciu zabiera 1 (także dawkę opłaconą składnikami, uwarzoną ponad limit w trakcie działania). Bez zmian w kodzie — do decyzji.

## Status (2026-10-06, sesja 2)

- v0.1 kompiluje się i działa: na zwykłym zapisie z recepturami da się warzyć posiadane mikstury ponownie.
- Potem zmiana limitu na „baza 3 + bonusy” (`@replaceMethod SingletonItemGetMaxAmmo`, usunięty wrapper `SingletonItemGetAmmo`). **Użytkownik potwierdził (2026-10-06): wszystko działa.** Mechanika moda (v0.2) zamknięta; kolejny etap to balans kosztu warzenia.
- Mod **nie** pojawia się w bibliotece modów w menu gry — to normalne dla moda złożonego z samych skryptów (brak manifestu/metadanych).

### Start „Serca z Kamienia” (nowa gra z dodatku) nie nadaje się do testów alchemii
`StandaloneEp1_1` (`playerWitcher.ws:11428`) czyści receptury i daje tylko poziom 1 (`Recipe for Swallow 1`, `Cat 1`, `Tawny Owl 1`…), a przedmioty poziomu 2 (`Swallow 2`, `Thunderbolt 2`, `Tawny Owl 2`, `Cat 2`…). Na Grom nie daje receptury wcale; nie daje też ziół. Skutek (tak samo w vanilli): poziomu 1 nie można warzyć, bo posiadany jest wyższy, a poziomu 2 nie ma w recepturach. Do testów używać zwykłego zapisu.

### Ścieżki z pełnymi dawkami, które omijają nasz wrapper odnawiania
- `quest_function.ws:2016/2053/2135/5958/6004` (`AddItemQuest`, `AddItemQuestExt` itd.) — po `AddAnItem` wołają wprost `SingletonItemSetAmmo(max)` → nagroda questowa = 3 dawki (nasz limit).
- `r4Player.ws:15482` (startowe przedmioty nowej gry) i `:15547` (debug) — to samo.
- Na starcie HoS `Swallow 2` miał 3/3 zamiast 1 — przyczyna niepotwierdzona (możliwe, że start idzie inną ścieżką niż sam `StandaloneEp1_1`). Do decyzji: czy przedmioty startowe/questowe mają dawać 1 dawkę, czy pełne (obecnie pełne).

## Do zweryfikowania w grze (pierwsze uruchomienie)

- [x] Skrypty się kompilują (adnotacje na metodach `private`/`final`, `@addMethod` na `CInventoryComponent`).
- [x] Posiadaną miksturę można uwarzyć ponownie (zwykły zapis).
- [x] Medytacja nie odnawia mikstur/bomb; brak komunikatu o odnowieniu (zamierzone — komunikat tylko gdy jakiś wywar wymaga odnowienia). Mikstura z 0 dawek zostaje w ekwipunku (jak w vanilli) — użytkownik akceptuje jako znacznik „już uwarzone”.
- [x] Warzenie mikstur i petard: 1 warzenie = 1 dawka, limit 3. Użytkownik potwierdził, że 1 dawka na warzenie zostaje (uzysk >1 rodziłby problem nadwyżki ponad limit).
- [x] Uwarzenie Wzmocnionej wersji usuwa podstawową, nowa ma 1 dawkę.
- [x] Loot: nowa mikstura = 1 dawka, posiadana = +1, przy 3 odmowa; lista w oknie lootu się odświeża.
- [x] Skill Optymalizacja 1/3 → limit petard 4 (tooltip `x/4`); po zdjęciu skilla nadmiar przycięty przez vanillę.
- [x] Stary zapis z 4+ dawkami → pokazuje np. `5/3`, nie odnawia się, schodzi przy użyciu; warzenie zablokowane do spadku poniżej limitu.
- [x] Wywary dalej odnawiają się medytacją za alkohol. (Stan v0.2 — od v0.3 wywary są w systemie i nie odnawiają się.)

(Pozycje wyżej: zbiorcze potwierdzenie użytkownika „wszystko działa”, 2026-10-06.)
- [ ] Sprawdzić w XML depotu (`items` / `def_item_*.xml`), czy jakieś zwykłe mikstury/bomby nie mają tagu `Quest`, a specjalne przedmioty (np. feromony, `Killer Whale 1`, `Trial Potion Kit`) zachowują się sensownie.

## Następny etap: balans kosztu warzenia (sesja 2 → kontynuacja w sesji 3)

**Problem:** w vanilli 1 warzenie = praktycznie nieskończony zapas (odnawiany alkoholem). U nas każda dawka kosztuje pełną recepturę → mikstura kilkukrotnie droższa, szczególnie przez mutageny i rzadkie części potworów. Wzorzec użytkownika: Wiedźmin 1 (1 mikstura na warzenie, ale tanie i powszechne składniki). Uzysk >1 na warzenie odrzucony (nadwyżka ponad limit).

**Decyzja (sesja 3, 2026-10-06):** pierwsze warzenie = pełna receptura vanilla („odblokowanie”), kolejne = krótsza, tańsza receptura („powielenie”).
1. Sygnałem jest sama lista składników w prawym panelu menu alchemii — po odblokowaniu po prostu się skraca. Precedens vanilli: poziomy 1/2/3 mają różne listy bez wyjaśnień. Zero nowych stringów.
2. Reguła odblokowania: **posiadanie mikstury w ekwipunku (także 0 dawek) = tania receptura**. Bez nowych danych w zapisie. Potwierdzone w grze: mikstur/bomb nie da się sprzedać ani wyrzucić → odblokowania nie da się stracić (poza wymianą na wyższy poziom, który wymaga własnego pierwszego warzenia). Loot też odblokowuje.
3. `isNew` na liście menu — **sprawdzone: menu alchemii tego nie rysuje**, odpada.
- Dodatkowo do rozważenia później: tańsze zioła u kupców; więcej ziół w lootcie wymagałoby XML.

### Dane receptur (wyciągnięte z bundli, sesja 3)
- Receptury: `def_item_alchemy_recipes_potions.xml` / `_petards.xml` (+ `dlc\ep1|bob\...potions.xml`: Killer Whale, feromony), węzeł `<custom><alchemy_recipes>`.
- **Mikstury/bomby w ogóle nie używają mutagenów** (to wywary). Drogie są: części potworów (30–60), `Optima mater` 50, `Powdered pearl` 50 (składnik rzemieślniczy), na poz. 3 rzadkie minerały (`Rebis`, `Vitriol`, `Quebrith`, `Aether`, `Nigredo`, `Rubedo`, `Vermilion`, `Alchemists powder`: 18–35) i `White Gull 1` (cena 100, ale da się go uwarzyć).
- Poz. 1 mikstury: `Dwarven spirit`; poz. 2: `Alcohest` + **przedmiot poz. 1 jako składnik**; poz. 3: `White Gull 1` + **przedmiot poz. 2**. Bomby analogicznie (bez alkoholu).
- Tagi: alkohole `StrongAlcohol`; zioła `HerbGameplay` (nie wszystkie — `Buckthorn` bez tagu); części potworów i minerały **nie mają rozróżniającego tagu** (oba `AlchemyIngredient, mod_alchemy`). Skrypt ma dostęp do `dm.GetItemPrice(name)`, `dm.ItemHasTag`, `dm.GetItemCategory` (`definitionsManager.ws:29-37`).

### BŁĄD v0.2 wynikający z danych (naprawiony w v0.3 — receptura powielania pomija niższy poziom)
Ponowne warzenie poz. 2/3 jest dziś **niemożliwe**: receptura wymaga przedmiotu poz. niższego, który zniknął przy pierwszym warzeniu, a warzyć niższego nie wolno (`CanCookRecipe`) → `EAE_NotEnoughIngredients`. (Wniosek z kodu i danych, niepotwierdzony w grze — użytkownik testował tylko pierwsze warzenie Wzmocnionej.) Receptura powielania musi więc zawsze usuwać składnik-przedmiot niższego poziomu.

### DECYZJA (koniec sesji 3): wariant A — ZAIMPLEMENTOWANE w sesji 4 (v0.3)
Reguła v2 (baza + składniki ≤ 16, wypada poprzedni poziom, `White Gull 1` → `Alcohest`) **+ połowa ilości przy powielaniu (zaokrąglenie w górę, alkohol zawsze 1)**; warzenie tylko z menu; wywary w systemie (limit 1); oleje vanilla. Strojenie później dwiema liczbami: próg ceny i dzielnik ilości. **Wariant B (medytacja warzy z zapasów) odrzucony** — ciche zabieranie składników jest niejawne i myli.

Skille limitu (np. Optymalizacja `S_Alchemy_s08`) — mod ich nie psuje: warzenie jest zablokowane w walce (`EAE_InCombat`, `alchemyManager.ws:156`, `thePlayer.IsInCombat()`), tak jak medytacja (`CanMeditate` / `CanMeditateHere` → `IsThreatened()`, `playerWitcher.ws:10093/10157`). Skill dalej decyduje o liczbie bomb na jedną walkę; poza walką w vanilli też można było uzupełnić (medytacją). Różnica: dodatkowe sloty trzeba opłacić składnikami. Drobna różnica: alchemia sprawdza `IsInCombat`, medytacja surowsze `IsThreatened` — warzyć można przy wrogach w pobliżu, zanim zacznie się walka. **Decyzja użytkownika: zostawić tak jak jest — nie zrównywać z medytacją.**

### Nowe kryterium użytkownika (sesja 3) — zastępuje „powszechność”
Rzucenie petardy / wypicie mikstury **nie może boleć ani irytować przy powielaniu** (nie żal rzucić, nawet przy pudle), a całość ma być bardziej immersyjna niż vanilla (medytacja = wszystko odnowione). Użytkownik pyta, czy mod ma w ogóle sens. Uwaga: ceny w XML są bazowe — w sklepie są wielokrotnie wyższe (np. `Optima mater` 50 w XML, 124 u zielarza w grze); do porównań względnych to nie przeszkadza. Otwarte: v2 + połowa ilości vs wariant „medytacja warzy z zapasów składników” (patrz odpowiedź sesji 3).

### Weryfikacja progu 16 koron względem dostępności (sesja 3) — reguła powszechności WYCOFANA
Cel reguły wg użytkownika: w powieleniu zostają tylko składniki **powszechne** (kupiec, zielarz, zbieranie w świecie). `python tools\recipes\availability.py` (bez argumentu: tabela źródeł; `copies`: koszty powielenia wg dostępności). Wynik:
- Próg 16 **nie zostawia niczego rzadkiego**: wszystko ≤ 16 to zioła (14–17 sklepów + krzaki w świecie) i minerały (16–31 sklepów). `Buckthorn` nie jest w sklepach, ale rośnie w świecie. Rzadkie minerały poz. 3 (`Quebrith` 18, `Aether`, `Vitriol`, `Rebis`, `Rubedo`, `Vermilion`, `Nigredo`) sprzedaje tylko 1 sklep (`_EP2_store__Alchemist`) → słusznie wypadają.
- Próg **ucina 5 powszechnych**: `Optima mater` (32 sklepy), `Powdered pearl` (29), `Quicksilver solution` (18), `Water essence` (11 — zielarze) oraz pół-powszechny `Specter dust` (5 sklepów, głównie z potworów).
- Części potworów i mutageny: 0 sklepów, tylko z potworów/gniazd → słusznie wypadają.
- Kryterium „powszechny” = alkohol lub roślina zbierana w świecie lub ≥ 7 sklepów. Wtedy powielanie **nie tanieje** dla receptur złożonych wyłącznie z powszechnych składników: Kot 1/2 (152/210), Dimeritium 1/2 (150/123), Biały Szron 1/2, Srebrny Pył 1/2, Smoczy Sen 2.
- Implementacja v3: stała lista rzadkich składników w skrypcie (wygenerowana narzędziem; gra nie daje skryptom dostępu do asortymentu sklepów).

### Rekomendacja v2 — ZAAKCEPTOWANA (sesja 3): wywary w systemie z limitem 1, oleje vanilla, reguła v2
Porównanie z alternatywą „wyrzuć najdroższy składnik”: `python tools\recipes\compare.py` — odrzucona, bo zostawia rzadkie składniki (perła, Nigredo, Rebis, mniejsze mutageny, szpik alghula) i daje nierówne oszczędności (Dimeritium 3: 272 → 172, wywar 28: 385 → 305).
- **Wywary dołączają do systemu** (spójność: medytacja przestaje odnawiać cokolwiek alchemicznego, alkohol staje się wyłącznie składnikiem — zmienia decyzję 5 i 6). Dane: wywar = `Dwarven spirit` + 1 mutagen potwora + 1–2 zioła (`def_item_alchemy_recipes_mutagens.xml`); vanilla limit **1** (`CommonMutagenAbility`, `ammo 1`), bonusy limitu wywarów nie dotyczą. Rekomendacja: limit zostaje 1 (vanillowy tooltip 1/1).
- **Oleje zostają vanilla**: w 5.0 przedmiot oleju nie zużywa się przy nakładaniu (nieskończone nakładanie), a nałożona powłoka ma ładunki na ciosy (`W3Effect_Oil.ReduceAmmo`, `r4Player.ws:1009`; nieskończona ze skillem `S_Alchemy_s06` poz. 3, `hudModuleBuffs.ws:314`). Medytacja ich nie dotyczy → nie łamią spójności. Ewentualnie później: nałożenie zużywa dawkę (jak w W1).
- **Poznanie receptury wyższego poziomu niczego nie wymusza**: `AddAlchemyRecipe` (`playerWitcher.ws:4851`) nie usuwa niższej receptury, `GetRecipes` ma `forceAll = true` (`alchemyManager.ws:398`) → wszystkie widoczne; przedmiot poz. 1 zostaje. Przejście na poz. 2 następuje dopiero przy świadomym warzeniu poz. 2. Mikstury poz. 2/3 nie występują w tabelach lootu ani u kupców (tylko startowe przedmioty samodzielnych startów DLC).
- **Reguła v2:** zostaje baza (alkohol `StrongAlcohol`; dla bomb proszek bazowy — `Saltpetre` / `Stammelfords dust` / `Alchemists powder`) + składniki ≤ 16; wypada poprzedni poziom, części potworów, mutageny, rzadkie minerały, perła. **`White Gull 1` w powieleniu → `Alcohest`** (Mewa kosztuje ~110 w składnikach — inaczej poz. 3 byłby pułapką kosztową). Szacunek powielenia: poz. 1 ≈ 30, poz. 2 ≈ 30, poz. 3 ≈ 35–65; wywary ≈ 25.

### Propozycja reguły powielania v1 (sesja 3, zastąpiona przez v2)
Reguła liczona w skrypcie z danych vanilli (jedna funkcja `CA_`, bez ręcznej tabeli, obejmuje też DLC): z pełnej receptury **zostaje** alkohol (`StrongAlcohol`) i każdy składnik o cenie bazowej ≤ 16; **wypada** przedmiot niższego poziomu (kategoria `potion`/`petard`) i wszystko droższe. Ilości bez zmian. Wynik: `python tools\recipes\rule.py 16`. Mikstury poz. 1–2 → alkohol + zioła (np. Jaskółka 1: 60 → 30, Jaskółka 2: 180 → 30); poz. 3 → wypada tylko rzadki minerał (White Gull zostaje). Słabe punkty: część bomb poz. 3 tańsza od poz. 1 (Dimeritium 3: 12 vs Dimeritium 1: 50); bez zmian ceny są m.in. Tańcząca Gwiazda 1, Smoczy Sen 1, Kartacz 1/2, Biały Miód 1/2.

**Implementacja (bez RedKitu):** receptury z XML trafiają do struktur skryptowych w trzech miejscach — wszystkie muszą dawać tę samą listę (wspólna funkcja `CA_`), inaczej rozbieżność zdradzi moda:
- `W3AlchemyManager.LoadRecipesCustomXMLData` (`alchemyManager.ws:46`, private) — menu alchemii, `CanCookRecipe`, `CookItem`; menu bierze składniki z `m_recipeList[id].requiredIngredients` (`alchemyMenu.ws:605`). Uwaga: menu odświeża `m_recipeList` po warzeniu tylko dla `level > 1` (`alchemyMenu.ws:351`) — po pierwszym warzeniu lista musi się przeliczyć także dla poziomu 1.
- globalna `getAlchemyRecipeFromName` (`alchemyManager.ws:534`) — tooltip receptury w ekwipunku (`guiBaseInventoryComponent.ws:776`), przypięta receptura (`inventoryMenu.ws:4464`, `guiTooltipComponent.ws:714`).
- własny loader w `guiTooltipComponent.ws:~2020`.

**Kolejne kroki:** ~~(1) reguła odblokowania~~ ✔; ~~(2) tabela receptur + ceny~~ ✔; ~~(3) akceptacja reguły powielania~~ ✔; ~~(4) kod — także naprawa powielania poz. 2/3~~ ✔ (sesja 4); (5) test w grze, potem strojenie progu/dzielnika.

## Pomysły / TODO na później

- Stół alchemiczny w Corvo Bianco — nadać mu sensowną rolę (np. +1 do limitu).
- Ewentualne przenoszenie dawek przy ulepszaniu poziomu.
- Powiadomienie HUD przy dobraniu dawki z lootu.
