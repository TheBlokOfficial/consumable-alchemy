# Receptury i balans kosztu warzenia — Consumable Alchemy

Bieżący etap projektu (od sesji 2). Decyzje: [decisions.md](decisions.md) (D11, D13, D19–D22). Implementacja w grze: [architecture.md](architecture.md#receptura-powielania--consumablealchemy_recipesws).

## Problem

W vanilli 1 warzenie = praktycznie nieskończony zapas (odnawiany alkoholem). W modzie każde warzenie kosztuje składniki → bez zmian w recepturach mikstura byłaby kilkukrotnie droższa (części potworów, rzadkie minerały, mutageny). Rozwiązanie: odblokowanie (pełna receptura) + powielenie (krótsza) — D11. Do rozważenia później: tańsze zioła u kupców; więcej ziół w lootcie (wymagałoby XML).

## Narzędzia (`tools/recipes/`, Python)

Depot RedKit niepotrzebny (usunięty przez użytkownika w sesji 2) — XML-e wyciągamy z bundli gry (sesja 3).
- `bundle.py list|extract <bundle> <wzorzec> [katalog]` — czytnik `POTATO70` (wpis TOC 0x130 B: nazwa 0x100, hash 16, offset/0/size/zsize/crc/kompresja; 0 = brak, 1 = zlib). Pliki trafiają do `tools\recipes\x\`.
  - `xml.bundle` → `gameplay\items\*.xml` (baza + wersje `items_plus` dla NG+); `ep1.bundle` / `bob.bundle` → `dlc\ep1|bob\data\gameplay\items\*.xml`. Jest tylko `content\content0` (dodatki w nim, brak katalogu `dlc`).
- `recipes.py` → `data.json` (przedmioty + receptury).
- `table.py` → tabela receptur mikstur/bomb (z cenami).
- `rule.py [próg] [dzielnik]` → symulacja reguły powielania (liczy dokładnie to co `CA_GetCopyIngredients`).
- `availability.py` (bez argumentu: tabela źródeł składników — sklepy/świat; `copies`: koszty powielenia wg dostępności).
- `compare.py` → porównanie reguły v2 z „wyrzuć najdroższy składnik”.
- `x/` i `data.json` są w `.gitignore` (dane CDPR) — odtwarzać przez `bundle.py extract` + `recipes.py`.

## Dane receptur (z bundli, sesja 3)

- Receptury: `def_item_alchemy_recipes_potions.xml` / `_petards.xml` / `_mutagens.xml` (+ `dlc\ep1|bob\...potions.xml`: Killer Whale, feromony), węzeł `<custom><alchemy_recipes>`.
- **Mikstury/bomby nie używają mutagenów** (to wywary). Wywar = `Dwarven spirit` + 1 mutagen potwora + 1–2 zioła.
- Drogie: części potworów (30–60), `Optima mater` 50, `Powdered pearl` 50 (składnik rzemieślniczy), na poz. 3 rzadkie minerały (`Rebis`, `Vitriol`, `Quebrith`, `Aether`, `Nigredo`, `Rubedo`, `Vermilion`, `Alchemists powder`: 18–35) i `White Gull 1` (cena 100, da się go uwarzyć; ~110 w składnikach).
- Poz. 1 mikstury: `Dwarven spirit`; poz. 2: `Alcohest` + **przedmiot poz. 1 jako składnik**; poz. 3: `White Gull 1` + **przedmiot poz. 2**. Bomby analogicznie (bez alkoholu).
- Tagi: alkohole `StrongAlcohol`; zioła `HerbGameplay` (nie wszystkie — `Buckthorn` bez tagu); części potworów i minerały **bez rozróżniającego tagu** (oba `AlchemyIngredient, mod_alchemy`); mutageny `MutagenIngredient`.
- Ceny w XML są bazowe — w sklepie wielokrotnie wyższe (np. `Optima mater` 50 w XML, 124 u zielarza); do porównań względnych wystarczy.
- Limity `ammo` (`def_item_alchemy_potion.xml` / `_petards.xml` / `_mutagens.xml`; NG+ `items_plus` bez `ammo`) — do potwierdzenia jednym tooltipem w vanilli, bo abilities poz. 2/3 zagnieżdżają się cyklicznie:
  - mikstury 3/4/5; wyjątki: Zamieć (Blizzard) 2/3/4, Biały Miód 1/2/5, Odwar Raffarda 2/2/3; Orka 3; feromony 2;
  - bomby 2/3/4; wywary 1 (`CommonMutagenAbility`, `ammo 1`).
- Mikstury poz. 2/3 nie występują w tabelach lootu ani u kupców (tylko startowe przedmioty samodzielnych startów DLC).

## Historia reguł powielania

### v1 (sesja 3, zastąpiona)
Liczona w skrypcie z danych vanilli: zostaje alkohol i każdy składnik o cenie bazowej ≤ 16; wypada przedmiot niższego poziomu i wszystko droższe; ilości bez zmian. Wynik `rule.py 16`: mikstury poz. 1–2 → alkohol + zioła (Jaskółka 1: 60 → 30, Jaskółka 2: 180 → 30); poz. 3 → wypada tylko rzadki minerał (White Gull zostaje). Słabe punkty: część bomb poz. 3 tańsza od poz. 1 (Dimeritium 3: 12 vs Dimeritium 1: 50); bez zmian ceny m.in. Tańcząca Gwiazda 1, Smoczy Sen 1, Kartacz 1/2, Biały Miód 1/2.

### v2 + dzielnik (sesja 3, zaimplementowana w v0.3 — obecnie w grze)
Zostaje baza (alkohol `StrongAlcohol`; dla bomb proszek bazowy `Saltpetre` / `Stammelfords dust` / `Alchemists powder`) + składniki ≤ 16; wypada poprzedni poziom, części potworów, mutageny, rzadkie minerały, perła. **`White Gull 1` → `Alcohest`** (inaczej poz. 3 byłby pułapką kosztową). Ilości / 2 w górę, alkohol zawsze 1. Szacunek kosztu powielenia: poz. 1 ≈ 30, poz. 2 ≈ 30, poz. 3 ≈ 35–65; wywary ≈ 25. Strojenie miało iść dwiema liczbami (próg, dzielnik) — zastąpione ręczną tabelą (D19).

### v3: reguła powszechności (sesja 3) — wycofana
Cel: w powieleniu zostają tylko składniki **powszechne** (kupiec, zielarz, zbieranie w świecie). Weryfikacja progu 16 (`availability.py`):
- Próg 16 nie zostawia niczego rzadkiego: wszystko ≤ 16 to zioła (14–17 sklepów + krzaki w świecie) i minerały (16–31 sklepów). `Buckthorn` nie jest w sklepach, ale rośnie w świecie. Rzadkie minerały poz. 3 (`Quebrith` 18, `Aether`, `Vitriol`, `Rebis`, `Rubedo`, `Vermilion`, `Nigredo`) sprzedaje tylko 1 sklep (`_EP2_store__Alchemist`) → słusznie wypadają.
- Próg **ucina 5 powszechnych**: `Optima mater` (32 sklepy), `Powdered pearl` (29), `Quicksilver solution` (18), `Water essence` (11 — zielarze) oraz pół-powszechny `Specter dust` (5 sklepów, głównie z potworów).
- Części potworów i mutageny: 0 sklepów, tylko z potworów/gniazd → słusznie wypadają.
- Kryterium „powszechny” = alkohol lub roślina zbierana w świecie lub ≥ 7 sklepów. Wtedy powielanie **nie tanieje** dla receptur złożonych wyłącznie z powszechnych składników: Kot 1/2 (152/210), Dimeritium 1/2 (150/123), Biały Szron 1/2, Srebrny Pył 1/2, Smoczy Sen 2. Dlatego wycofana.
- Implementacja byłaby stałą listą rzadkich składników w skrypcie (gra nie daje skryptom dostępu do asortymentu sklepów).
- Pozostałość: reguła wg dostępności zamiast ceny (zachowuje `Quicksilver solution`, `Optima mater`, `Water essence`) może posłużyć jako generator szkicu; dzielnik do ustalenia symulacją.

### Alternatywa „wyrzuć najdroższy składnik” — odrzucona
`compare.py`: zostawia rzadkie składniki (perła, Nigredo, Rebis, mniejsze mutageny, szpik alghula), nierówne oszczędności (Dimeritium 3: 272 → 172, wywar 28: 385 → 305).

## Audyt reguły v0.3 (sesja 6; próg 16, dzielnik 2)

- **Kolizje** (ten sam zbiór składników): Kot 1 = Maribor 1 = wywar Mutagen 5; Zamieć 1 = wywar Mutagen 2; Zamieć 2 = Jaskółka 2 (zbiór); Dimeritium 1 = Księżycowy Pył (Silver Dust) 1 (sam `Saltpetre`); ~40 par różni się 1 składnikiem (poz. 1 = alkohol/proszek + 1 zioło).
- **Utrata symboliki:** mikstury poz. 1–2 tracą jedyny unikalny składnik (część potwora: Czarna Krew – `Ghoul blood`, Zamieć – `Golem heart`, Puszczyk – `Arachas venom`, Grom – `Endriag embryo` …); Księżycowy Pył traci `Quicksilver solution` (18 sklepów!), Dimeritium 1 – `Optima mater` (32 sklepy). Wywary tracą mutagen. Jaskółka i Biały Miód OK.
- **Puste/dziwne:** Mutagen 28 = sam alkohol; Biały Miód 1 i Feromon Niedźwiedzia: powielenie = pełna receptura. Poz. 2 tańszy od poz. 1 w 11 rodzinach (`Alcohest` 10 < `Dwarven spirit` 20) — nieszkodliwe.
- Dzielnik 1 psuje bomby poz. 1 (powielenie = pełna receptura; Dimeritium 1 = 5× `Saltpetre`, droższe od poz. 2/3).

## Kierunek: ręcznie dopracowana tabela (sesja 6)

- Python generuje szkic → walidator → generator `.ws` z tabelą (pełna + powielenie dla każdego przedmiotu); szlifowanie rodzina po rodzinie (D19–D21).
- **Problem odwrócenia trudności:** mikstury z pospolitą częścią (Jaskółka – mózg utopca) byłyby trudniejsze w powieleniu niż zaawansowane, którym rzadka część wypada i zostają same zioła. Kierunek: każda receptura powielania ma składnik „wysiłku” dobrany do rangi mikstury — rzadka część potwora podmieniona na osiągalny, tematycznie zbliżony zamiennik (np. esencje upiorów → `Specter dust`; drogie minerały ze sklepów `Optima mater` / `Quicksilver solution` / `Powdered pearl`; części średnio pospolitych potworów). Walidator ma pokazywać poziom wysiłku, by mikstury podstawowe nie były droższe od zaawansowanych.
- W3 nie ma zamienników składników (receptura = konkretne nazwy); dynamiczna podmiana odrzucona (mod-smell).

## Części potworów — research (sesja 6)

- **W3:** pospolite — `Ghoul blood` (ghul, gwarant 1), `Drowner brain` (~0,5/zabicie), `Drowned dead tongue` (topielec ~0,5, gniazdo gwarant), `Nekker heart` (nekker ~0,3, duże/gniazda gwarant); średnie — `Endriag heart` / `embryo`; rzadkie (bez sensu w powieleniu) — esencje południcy/nocnicy, `Golem heart`, `Fogling teeth`, `Arachas venom`, `Specter dust`. Brak tagu rozróżniającego → lista nazw. Wędrowne grupy potworów odradzają się po ok. 2–4 dniach gry (źródła: poradniki, niezweryfikowane w kodzie); nazwane/questowe nie.
- **W1:** receptury na substancje (dowolny składnik z daną substancją, z ziół lub potworów), 1 alkohol = 1 mikstura (jakość alkoholu = liczba slotów), warzenie tylko w medytacji, brak limitu poza stosami po 10; części potworów wymagały wpisu w bestiariuszu; potwory (utopce, ghule, barghesty) odradzały się → składniki tanie i zalegające, barierą była logistyka, nie koszt. Punkt odniesienia użytkownika: zdobycie części ≈ zebranie zioła.
- W toku: dalszy research W1 + analiza dropu części potworów w W3. Decyzja otwarta (D22).

## Alkohol

Stały z receptury, ×1 (sesja 6). Zużywa się szybciej niż w vanilli: vanilla — 1 sztuka najtańszego `StrongAlcohol` na całą medytację (w praktyce `Mahakam Spirit` 8 / `Alcohest` 10); mod — 1 na każde warzenie (np. 4 mikstury + 1 wywar = 5×). Podaż dobra (`Dwarven spirit` 20 sklepów, `Alcohest` 21). Pomysł odłożony: w powieleniu podstawiać najtańszy posiadany alkohol (jak medytacja).
