# Testy w grze — Consumable Alchemy

Testy robi użytkownik w grze po wdrożeniu (`deploy.ps1`). Używać **zwykłego zapisu** z poznanymi recepturami (nie startów samodzielnych DLC — patrz [Pułapki testowe](#pułapki-testowe)). Gra kompiluje skrypty przy starcie; ostrzeżenia `[content0] ... not marked as abstract` / `has no autostate` pochodzą z vanilli.

## v0.4 (sesja 7) — bieżąca

Stan: v0.4 skommitowane lokalnie (`b2be4c2`), niewypchnięte. Wynik wstępny (sesja 7, potwierdzenie użytkownika): kompiluje się, mod się wczytuje — na starcie HoS medytacja nie odnawia Wzmocnionej Jaskółki. Reszta checklisty niezaliczona.

- [x] Kompilacja (po usunięciu `@replaceMethod SingletonItemGetMaxAmmo` / `GiveItemTo` i `CA_SetConsumableAmmo`).
- [ ] Warzenie przy 0/x i przy częściowej kieszeni (np. 1/3) daje max.
- [ ] Limity vanilli: np. Jaskółka 1 x/3, bomby poz. 1 x/2, wywar 1/1 (przy okazji potwierdza wartości `ammo` z [recipes.md](recipes.md#dane-receptur-z-bundli-sesja-3)).
- [ ] Optymalizacja (`S_Alchemy_s08`) podnosi limit bomb; warzenie napełnia do nowego limitu.
- [ ] Ulepszenie (np. Jaskółka 2) ma od razu max.
- [ ] Medytacja nadal nie odnawia mikstur/bomb/wywarów i nie zużywa alkoholu.
- [ ] Stary zapis z nadmiarem (np. 5/3 z v0.3) pokazuje limit vanilli; nadmiar schodzi przy użyciu, warzenie zablokowane do spadku poniżej limitu.
- [ ] Zakup/loot posiadanej mikstury → vanillowa odmowa („już uwarzono”).
- [ ] Nowy przedmiot z lootu/sklepu → pełny max.

## v0.3 (sesja 4) — receptura powielania, wywary

Sesja 5: użytkownik „chyba działa” (kompiluje się, wstępnie OK); pozycje nieodhaczone. Receptury powielania w v0.4 są bez zmian, więc pozycje nadal aktualne (dawki: od v0.4 warzenie daje max).

- [x] Kompilacja — w tym `@wrapMethod` bez nawiasów na globalnej `getAlchemyRecipeFromName` (recipes.ws). (Gdyby błąd składni: `@wrapMethod()`, w ostateczności usunąć wrapper — tooltip pokaże pełną listę.)
- [ ] Pierwsze warzenie = pełna receptura; zaraz potem prawy panel menu pokazuje krótszą listę (bez zamykania menu).
- [ ] Mikstura z 0 dawek → krótka receptura; warzenie zabiera właściwe składniki.
- [ ] Ponowne warzenie poz. 2 i 3 (np. Jaskółka 2: `Alcohest` + 3× Glistnik + 2× Mirt) — bez przedmiotu poz. 1.
- [ ] Poz. 3: `Alcohest` zamiast `White Gull 1`.
- [ ] Wywar: medytacja go nie odnawia, nie zużywa alkoholu; po wypiciu można uwarzyć ponownie (krótka receptura: alkohol + zioła, bez mutagenu); przy 1/1 komunikat „już uwarzono”.
- [ ] Tooltip receptury w ekwipunku i przypięta receptura pokazują tę samą listę co menu.
- [ ] `GetItemPrice` zwraca cenę bazową z XML (jeśli nie — w liście zostaną/wypadną inne składniki niż w `rule.py`).

## v0.1–v0.2 (sesje 1–2) — zaliczone

Zbiorcze potwierdzenie użytkownika „wszystko działa” (2026-10-06). Pozycje oznaczone † opisują zachowanie zmienione w późniejszych wersjach.
- [x] Skrypty się kompilują (adnotacje na metodach `private`/`final`, `@addMethod` na `CInventoryComponent`).
- [x] Posiadaną miksturę można uwarzyć ponownie (zwykły zapis).
- [x] Medytacja nie odnawia mikstur/bomb; brak komunikatu o odnowieniu (zamierzone — w v0.2 komunikat tylko, gdy jakiś wywar wymaga odnowienia). Mikstura z 0 dawek zostaje w ekwipunku.
- [x] † Warzenie: 1 warzenie = 1 dawka, limit 3 (od v0.4: max, limit vanilli).
- [x] † Uwarzenie Wzmocnionej usuwa podstawową, nowa ma 1 dawkę (od v0.4: max).
- [x] † Loot: nowa mikstura = 1 dawka, posiadana = +1, przy limicie odmowa; lista w oknie lootu się odświeża (od v0.4: vanilla).
- [x] Skill Optymalizacja 1/3 → limit petard 4 przy bazie 3 (tooltip `x/4`); po zdjęciu skilla nadmiar przycięty przez vanillę.
- [x] Stary zapis z 4+ dawkami → pokazuje np. `5/3`, nie odnawia się, schodzi przy użyciu; warzenie zablokowane do spadku poniżej limitu.
- [x] † Wywary odnawiają się medytacją za alkohol (stan v0.2; od v0.3 wywary w systemie).

## Otwarte do sprawdzenia (bez wersji)

- [ ] W XML (`def_item_*.xml`, wyciągane `bundle.py`): czy jakieś zwykłe mikstury/bomby nie mają tagu `Quest`; czy specjalne przedmioty (feromony, `Killer Whale 1`, `Trial Potion Kit`) zachowują się sensownie.
- [ ] Degradacja: wczytanie zapisu po usunięciu moda (mikstura 0/x, bomba ponad max) — oczekiwane zachowanie w [architecture.md](architecture.md#degradacja-sprawdzone-w-kodzie-sesja-6).

## Pułapki testowe

- **Start „Serca z Kamienia” (nowa gra z dodatku) nie nadaje się do testów alchemii.** `StandaloneEp1_1` (`playerWitcher.ws:11428`) czyści receptury i daje tylko poziom 1 (`Recipe for Swallow 1`, `Cat 1`, `Tawny Owl 1`…), a przedmioty poziomu 2 (`Swallow 2`, `Thunderbolt 2`, `Tawny Owl 2`, `Cat 2`…). Na Grom nie daje receptury wcale; nie daje też ziół. Skutek (tak samo w vanilli): poziomu 1 nie można warzyć, bo posiadany jest wyższy, a poziomu 2 nie ma w recepturach.
- Na starcie HoS (v0.2/v0.3) `Swallow 2` miał 3/3 zamiast 1 — przyczyna niepotwierdzona (możliwe, że start idzie inną ścieżką niż sam `StandaloneEp1_1`). Od v0.4 pełna kieszeń przy pozyskaniu jest zamierzona.
- W modzie starty samodzielne HoS/B&W dają ok. 20 jednorazówek (przedmioty bez znanej receptury, medytacja ich nie odnawia) — research i rekomendacja (sesja 7, odłożone): [roadmap.md](roadmap.md#samodzielne-starty-dodatków-hos--bw--odłożone-decyzja-użytkownika-sesja-7).
- Mod nie pojawia się na liście modów w menu gry (to nie znaczy, że się nie wczytał) — [roadmap.md](roadmap.md).

## Znane skutki uboczne

- **Wywar Wodnej Baby** (`EET_Mutagen03`, `mutagen03.ws`): przy nałożeniu vanilla daje **+1 dawkę** każdej miksturze/bombie (także z 0 dawek — darmowa dawka), przy wygaśnięciu zabiera 1 (także dawkę opłaconą składnikami, uwarzoną ponad limit w trakcie działania). Bez zmian w kodzie; README opisuje to jako zachowanie gry. Do decyzji.
- Alkohol zużywa się szybciej niż w vanilli (1 na warzenie) — [recipes.md](recipes.md#alkohol).
- Warzyć można przy wrogach w pobliżu, zanim zacznie się walka (alchemia: `IsInCombat`, medytacja: `IsThreatened`) — zostawione celowo (D15).
