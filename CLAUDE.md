# CLAUDE.md — Consumable Alchemy (Witcher 3 Remastered mod, gra v5.0)

Mod zamienia alchemię z singletonów odnawianych medytacją na system zużywalny: medytacja nie uzupełnia mikstur, bomb ani wywarów; dawki uzupełnia się wyłącznie warzeniem (pełna kieszeń za składniki). Pierwsze warzenie = pełna receptura („odblokowanie”), kolejne = krótsza, tańsza („powielenie”). Opis dla gracza: [README.md](README.md). Szczegóły w `docs/` (indeks na końcu).

## Współpraca (model pracy ustalony przez użytkownika, sesja 7)

- **Użytkownik** — właściciel decyzji projektowych; testuje w grze; daje zielone światło na implementację.
- **Claude — architekt:**
  - nie pisze kodu ręcznie — zleca zadania subagentom (asynchronicznie, w tle), czyta ich raporty i diffy;
  - podejmuje decyzje techniczne (projektowe zostawia użytkownikowi);
  - oszczędza własny kontekst: nie czyta długich plików (XML-e gry, pełne skrypty vanilli) — używa subagentów albo poleceń z krótkim wynikiem;
  - przed implementacją opisuje plan i czeka na zielone światło.
- **Commit** lokalnie po potwierdzeniu użytkownika (np. że się kompiluje / działa). **Push tylko na wyraźne polecenie** (repo publiczne).
- **Wdrożenie:** Claude uruchamia `deploy.ps1`; test w grze robi użytkownik wg [docs/testing.md](docs/testing.md).
- **Po sesji:** aktualizacja `docs/` (decyzje z numerem sesji, wyniki researchu, checklisty) i sekcji „Status” poniżej.

## Twarde wymogi (szczegóły i uzasadnienia: [docs/decisions.md](docs/decisions.md))

- **Pełna „vanillowość”** — żadnych nowych napisów, zmian UI, mod-smellu. Jeśli trzeba pokazać komunikat, najpierw szukaj istniejącego klucza lokalizacji (obecnie reużywamy `panel_alchemy_exception_already_cooked`; PL + EN, zero nowych stringów).
- **Kompatybilność z innymi modami nie jest wymogiem** (użytkownik nie gra z innymi).
- **Zakres:** mikstury + bomby + wywary. Oleje i przedmioty questowe — vanilla. Alkohol wyłącznie składnikiem.
- Limity dawek i pozyskanie poza warzeniem (loot, zakup, questy) — jak w vanilli (od v0.4).
- `README.md` = strona dla gracza (PL, bez technikaliów, styl Nexusa). Szczegóły techniczne tylko w CLAUDE.md / `docs/`.

## Środowisko

- **Gra:** `D:\gry\steam\steamapps\common\the witcher 3` (Steam, Remastered; `witcher3.exe` w `bin\x64_dx12` raportuje **5.0.0.1044392**). To nowsze niż next-gen 4.0 (2022) — nie zakładaj, że wiedza o 4.x jest aktualna; weryfikuj w skryptach vanilla z tej instalacji.
- **Skrypty vanilla** (referencja, tylko do odczytu): `<gra>\content\content0\scripts\game\...` (numery linii w `docs/` dotyczą tej instalacji).
- **Dane gry (XML):** depot RedKit usunięty przez użytkownika (sesja 2), niepotrzebny — XML-e wyciągamy z bundli narzędziem `tools\recipes\bundle.py` (opis narzędzi: [docs/recipes.md](docs/recipes.md#narzędzia-toolsrecipes-python)). Jest tylko `content\content0` (dodatki w nim, brak katalogu `dlc`).
- **Kompilacja:** gra kompiluje skrypty przy starcie; błędy pokazuje w oknie przy uruchomieniu.
- **Instalacja moda:** `deploy.bat` (dwuklik; nakładka na `deploy.ps1`, opcjonalny argument: ścieżka gry) → `<gra>\mods\modConsumableAlchemy`.
- Mod nie pojawia się na liście modów w menu gry — założenie: normalne dla moda z samych skryptów (zbadanie odłożone, [docs/roadmap.md](docs/roadmap.md)).

## Repozytorium

- git, gałąź `main`; **publiczne** repo GitHub https://github.com/TheBlokOfficial/consumable-alchemy (od sesji 5 — wszystko, co commitujesz, jest jawne).
- Autor commitów: `TheBlokOfficial <tomasznosal.mail@proton.me>` (lokalny config repo).
- **Nie commitować danych gry:** `tools/recipes/x/` (wypakowane XML-e CDPR) i `data.json` są w `.gitignore`; odtwarzać przez `bundle.py extract` + `recipes.py`.

```
src/modConsumableAlchemy/content/scripts/local/
  consumableAlchemy_common.ws     – klasyfikacja przedmiotów
  consumableAlchemy_inventory.ws  – blokada odnawiania, alkohol/powiadomienia, Corvo Bianco
  consumableAlchemy_alchemy.ws    – menedżer i menu alchemii (warzenie)
  consumableAlchemy_recipes.ws    – receptura powielania
tools/recipes/                    – narzędzia do danych receptur (Python)
docs/                             – dokumentacja techniczna (indeks niżej)
deploy.bat / deploy.ps1           – instalacja do folderu gry
README.md                         – strona moda dla gracza
```

## Konwencje kodu i ograniczenia kompilatora

- Adnotacje kompilatora (`@wrapMethod`, `@replaceMethod`, `@addMethod`; od 4.0, działają w 5.0, także na metodach `private`/`final`) w **nowych** plikach w `content\scripts\local\` — nie nadpisujemy plików vanilla, nie trzeba Script Mergera.
- **W funkcji z `@wrapMethod` słowo `wrappedMethod` może wystąpić tylko raz** — każde kolejne daje błąd „Could not find function 'wrappedMethod'”. Najpierw ustal, co robić, potem jedno wywołanie.
- Ostrzeżenia `[content0] ... not marked as abstract` / `has no autostate` przy kompilacji pochodzą z vanilli — ignorować.
- Wszystko własne ma prefiks `CA_`.
- Styl vanilli: taby, `if(...)`, **deklaracje zmiennych na początku funkcji** (wymóg WitcherScript).
- Mod nie zapisuje w save'ie nic własnego (tylko vanillowe `ammo_current` / `is_initialized`) — utrzymać; patrz [docs/architecture.md](docs/architecture.md#degradacja-sprawdzone-w-kodzie-sesja-6).

## Status (2026-10-07, sesja 7)

- **v0.4** (sesja 7, wypchnięte): warzenie napełnia do max, limity vanilli, pozyskanie poza warzeniem = vanilla. Kompiluje się i wczytuje; reszta checklisty: [docs/testing.md](docs/testing.md).
- **Tabela receptur** (sesja 7): mod czyta receptury z generowanego `consumableAlchemy_recipes_table.ws` (źródło: `tools/recipes/recipes_table.json`, = reguła v0.3 1:1). Wgrane, **nieprzetestowane w grze**.
- Następny etap wg [docs/roadmap.md](docs/roadmap.md) („Kolejność pracy”): katalog składników z dropem potworów (przerwany, do wznowienia) → walidator → szlifowanie receptur. Otwarte decyzje: D22 (części potworów), D26 (komunikat „Już masz ten przedmiot”), D27 (`Pops Antidote`); odłożone: D23 (starty dodatków), lista modów, oleje. Odłożone na kiedyś: widoczność na liście modów, oleje jako zużywalne.

## Dokumentacja (`docs/`)

| Plik | Zawartość |
|---|---|
| [architecture.md](docs/architecture.md) | Architektura moda: klasyfikacja przedmiotów, punkty zaczepienia w vanilli (v0.4 i wcześniej), receptura powielania, mechanika vanilli, degradacja, ścieżki z pełnymi dawkami. |
| [decisions.md](docs/decisions.md) | Rejestr decyzji użytkownika (D1–D24, z sesją i uzasadnieniem) oraz odrzucone warianty z powodem. |
| [recipes.md](docs/recipes.md) | Balans kosztu warzenia: dane receptur z bundli, narzędzia `tools/recipes/`, historia reguł powielania, audyt, research części potworów, alkohol. |
| [testing.md](docs/testing.md) | Checklisty testów w grze (v0.4 na górze), pułapki testowe, znane skutki uboczne. |
| [roadmap.md](docs/roadmap.md) | Historia wersji, kolejność pracy, research w toku, samodzielne starty dodatków, otwarte kwestie, TODO. |
