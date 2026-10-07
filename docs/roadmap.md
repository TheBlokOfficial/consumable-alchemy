# Roadmapa — Consumable Alchemy

Stan i kolejność pracy, otwarte kwestie, pomysły. Decyzje: [decisions.md](decisions.md).

## Historia wersji

| Wersja | Sesja | Zakres |
|---|---|---|
| v0.1 | 1–2 | blokada odnawiania, ponowne warzenie (1 dawka), limit stałe 3; loot: nowa 1 dawka, posiadana +1 |
| v0.2 | 2 | limit „baza 3 + bonusy vanilli”; potwierdzone „wszystko działa” (2026-10-06) |
| v0.3 | 4 | receptura powielania (v2 + połowa ilości), wywary w systemie (limit 1), wyłączenie przedmiotów questowych, naprawa ponownego warzenia poz. 2/3 |
| v0.4 | 6 (plan), 7 (kod) | warzenie = pełna kieszeń, limity vanilli, pozyskanie poza warzeniem = vanilla; commit lokalny `b2be4c2` (niewypchnięty); kompiluje się i wczytuje |

(Sesja 3: dane receptur i narzędzia; sesja 5: repo publiczne, „chyba działa” dla v0.3; sesja 6: projekt v0.4 + audyt receptur.)

## Kolejność pracy

1. ~~Kod v0.4 (pełna kieszeń + limity vanilli)~~ ✔ sesja 7 — czeka na test w grze ([testing.md](testing.md)).
2. Narzędzia receptur: szkic → walidator (m.in. poziom „wysiłku”, kolizje) → generator `.ws` z tabelą ([recipes.md](recipes.md#kierunek-ręcznie-dopracowana-tabela-sesja-6)).
3. Szlifowanie receptur rodzina po rodzinie (pełna + powielenie).

(Wcześniejszy plan sesji 3 — reguła odblokowania, tabela receptur, akceptacja reguły, kod v0.3 — wykonany; jego krok „strojenie progu/dzielnika” zastąpiony ręczną tabelą, D19.)

## Odłożone na kiedyś (sesja 7, decyzja użytkownika — research przerwany, brak wyników)

- **Widoczność moda na liście modów w menu gry 5.0** — sygnatura, że mod się wczytał. Założenie z sesji 2: brak manifestu/metadanych w modzie z samych skryptów. Do ustalenia: na jakiej podstawie gra buduje listę (manifest, `metadata.store`, bundle?), czy da się to zrobić bez RedKitu, skutki uboczne (osiągnięcia, ostrzeżenia).
- **Oleje jako zużywalne** — luźny pomysł użytkownika: przedmiot oleju ma dawki = liczba nałożeń na miecz, każde nałożenie zużywa 1, warzenie uzupełnia do max, medytacja nie odnawia; ładunki powłoki na ciosy bez zmian (`W3Effect_Oil.ReduceAmmo`, `r4Player.ws:~1009`; `S_Alchemy_s06`). Do ustalenia: czy olej jest singletonem z `ammo`, funkcja nakładania, UI (tooltip x/y, blokada przy 0 bez nowych stringów), limit dawek, oleje questowe/auto-nakładanie, koszt.

## Research w toku

- Części potworów w powieleniu — research W1 + analiza dropu w W3; decyzja otwarta (D22, [recipes.md](recipes.md#części-potworów--research-sesja-6)).

## Samodzielne starty dodatków (HoS / B&W) — odłożone (decyzja użytkownika, sesja 7)

**Problem:** w modzie medytacja nie odnawia, a starty samodzielne dają przedmioty bez znanej receptury → ok. 20 pozycji startowych to jednorazówki (w vanilli medytacja je odnawiała). Por. [testing.md](testing.md#pułapki-testowe).

**Dane (research sesja 7, `playerWitcher.ws`):**
- HoS `StandaloneEp1_1` (`:11428`, woła `_2`; fakt `StandAloneEP1`; `RemoveAllAlchemyRecipes` `:11595`; przedmioty `:11662-11709`; fakt końcowy `standalone_ep1` `:11916`): receptury poz. 1 mikstur Cat, Maribor, Petri, Swallow, Tawny Owl, White Honey, Raffard; bomb Dancing Star, Dimeritium, Grapeshot, Samum, White Frost; alkohole, oleje 1–2.
- B&W `StandaloneEp2_1` (`:11930`, przedmioty `:12090-12207`, fakt `standalone_ep2` `:12488`): receptury mikstur tylko Petri 2, Swallow 1, Tawny Owl 1; bomby/oleje jak HoS; dodatkowo przedmioty Golden Oriole 1, Killer Whale 1, Petri 2.
- Przedmiot bez receptury na ten sam poziom:
  - poz. 2 z recepturą tylko poz. 1 — Swallow 2, Tawny Owl 2, Grapeshot 2, Samum 2, White Frost 2, Dancing Star 2 (+ Cat 2, White Honey 2 w HoS);
  - poz. 2 bez żadnej receptury — Thunderbolt 2, Devils Puffball 2 (+ Cat 2, White Honey 2 w B&W);
  - poz. 1 bez receptury — Black Blood 1, Blizzard 1, Full Moon 1, Dragons Dream 1, Silver Dust Bomb 1 (+ w B&W Maribor 1, Raffard 1, Golden Oriole 1, Killer Whale 1);
  - wywary `Mutagen 17/19/26/27`.
  - OK (receptura jest): Dimeritium 1; HoS Maribor 1, Petri 1, Raffard 1; B&W Petri 2.
- Gdzie później receptury: B&W — `_EP2_store__Alchemist` (Toussaint) ma poz. 2 i 3 wszystkich; HoS — sklepy EP1 tylko poz. 3; podstawka `Oxenfurt_Herbalist` / `Druid_Herbalist` mają m.in. Swallow 2, Tawny Owl 2, White Honey 2, Grapeshot 2, Samum 2, Blizzard 2, Full Moon 2; Thunderbolt 2, Cat 2, White Frost 2, Devils Puffball 2 głównie Skellige / `_store__Poor_Dist_Herbs_Trader`; skrzynie od poz. gracza ~10.
- API: `AddAlchemyRecipe(nam, optional isSilent, optional skipTutorialUpdate) : bool` (`playerWitcher.ws:4851`), znane receptury w `private saved var alchemyRecipes` (`:44`); idempotentne (znana → `false`). `isSilent = true` pomija HUD (`AddAlchemyHudNotification` `:4046`). Skutki nawet w trybie cichym: statystyki `ES_KnownPotionRecipes` / `ES_KnownBombRecipes` → osiągnięcia `EA_BreakingBad` / `EA_Bombardier` (`gamerProfile.ws:62`); skill `S_Alchemy_s18` (Nabyta Tolerancja) — ability na każdą recepturę (+toksyczność); zdarzenie `SEC_AlchemyRecipe` (warunki questów `playerKnowsRecipe.ws`). Brak funkcji przedmiot → receptura: iteracja `dm.GetCustomDefinition('alchemy_recipes')` po `cookedItem_name` (jak `alchemyManager.ws:69`).

**Rekomendacja (wariant a):** `@wrapMethod(W3PlayerWitcher)` na `StandaloneEp1_1` i `StandaloneEp2_1` (public final) → po oryginale dla każdego posiadanego consumable bez znanej receptury `AddAlchemyRecipe(r, true, true)`. Cały zestaw startowy (także poz. 1 i wywary) staje się odnawialny jak w vanilli, tylko za składniki (pierwsze warzenie od razu tanie, bo przedmiot jest posiadany). Istniejące zapisy: dodatkowo wrapper na `ApplyPatchFixes` (`private final`, `playerWitcher.ws:738`, wołane przy każdym wczytaniu `:365`) z warunkiem `FactsQuerySum('standalone_ep1' / 'standalone_ep2') > 0` — odczyt vanillowych faktów, mod dalej nic nie zapisuje, idempotentne. Koszt ~40 linii. Zwykła gra i NG+ bez zmian. Skutki uboczne: osiągnięcia za znane receptury, Nabyta Tolerancja (zgodne z vanillą — tak działa każda poznana receptura). Niesprawdzone: czy quest wywołujący `StandaloneEp*_1` trafia w owiniętą metodę (powinien).

**Odrzucone:**
- (b) „posiadany consumable poz. ≥ 2 bez receptury → poznaj” w gałęzi inicjalizacji `SingletonItemRefillAmmo` — nie pokrywa poz. 1 i wywarów.
- (c) warzenie kopii bez znajomości receptury (wirtualna receptura w `GetRecipes`) — zmiana projektu (loot też by odblokowywał), ryzyko niespójności menu/tooltipów, mod-smell.

**Otwarte pytanie do użytkownika przy realizacji:** objąć cały zestaw (także poz. 1 i wywary) czy tylko poz. 2.

## Otwarte kwestie

- **Wywar Wodnej Baby** — darmowa dawka przy nałożeniu / utrata opłaconej przy wygaśnięciu ([testing.md](testing.md#znane-skutki-uboczne)). Do decyzji.
- **Alkohol** — szybsze zużycie niż w vanilli; pomysł: w powieleniu podstawiać najtańszy posiadany alkohol ([recipes.md](recipes.md#alkohol)).

## Pomysły / TODO

- Stół alchemiczny w Corvo Bianco — sensowna rola, np. warzenie przy stole → max + `QUANTITY_INCREASED_BY_ALCHEMY_TABLE` (vanillowa stała, +1). Obecnie `ManageSingletonItemsBonus` tylko odmawia.
- Tańsze zioła u kupców; więcej ziół w lootcie (wymagałoby XML).
- Oleje: nałożenie zużywa dawkę (jak w W1) — ewentualnie później (odłożone, wyżej).
- ~~Przenoszenie dawek przy ulepszaniu poziomu~~ — rozwiązane w v0.4 (nowy poziom dostaje max).
- ~~Powiadomienie HUD przy dobraniu dawki z lootu~~ — nieaktualne od v0.4 (loot = vanilla, nie ma dobierania dawek).
