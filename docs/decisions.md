# Rejestr decyzji — Consumable Alchemy

Decyzje użytkownika (właściciela projektu) z sesją i uzasadnieniem. Sesje 1–4: 2026-10-06, sesje 6–7: 2026-10-07; „sesja 1” = ustalenia startowe projektu. Odrzucone warianty są tu po to, żeby do nich nie wracać bez nowego argumentu. Szczegóły techniczne: [architecture.md](architecture.md), receptury: [recipes.md](recipes.md).

## Cel

Zamiana alchemii z singletonów odnawianych medytacją na system zużywalny. Wzorzec użytkownika: Wiedźmin 1 (każda butelka to składniki; tanie, powszechne składniki). Kryterium (sesja 3): rzucenie petardy / wypicie mikstury **nie może boleć ani irytować przy powielaniu** (nie żal rzucić, nawet przy pudle), a całość ma być bardziej immersyjna niż vanilla (medytacja = wszystko odnowione). Użytkownik pytał wtedy, czy mod ma w ogóle sens — odpowiedzią jest model odblokowanie/powielenie (D11).

## Twarde wymogi

- **D1. Pełna „vanillowość”** (sesja 1) — żadnych nowych napisów, zmian UI, mod-smellu. Jeśli trzeba pokazać komunikat, najpierw szukaj istniejącego klucza lokalizacji.
- **D2. Języki PL + EN, zero nowych stringów** (sesja 1) — reużywamy `panel_alchemy_exception_already_cooked`.
- **D3. Kompatybilność z innymi modami nie jest wymogiem** (sesja 1) — użytkownik nie gra z innymi.
- **D4. README = strona dla gracza** (PL, bez technikaliów, styl Nexusa); szczegóły techniczne tylko w CLAUDE.md / `docs/`.

## Mechanika

- **D5. Medytacja (i każde inne odnawianie) nie uzupełnia** mikstur, bomb ani (od sesji 4) wywarów (sesja 1).
- **D6. Uwarzone przedmioty można warzyć ponownie; warzenie napełnia do max** (sesja 6, kod sesja 7). Historia: sesja 1 — 1 warzenie = 1 dawka; sesja 2 — potwierdzone (uzysk >1 rodziłby nadwyżkę ponad limit). Zmienione w sesji 6, bo: dolewka przy 2/3 kosztuje tyle co przy 0/3 — tak samo jak medytacja w vanilli, to nie wada; skille limitu zyskują sens (większa pojemność = tańsza dawka); rozwiązuje problem przenoszenia dawek przy ulepszaniu (nowy poziom dostaje max).
- **D7. Limit = vanilla** (atrybut `ammo` wg poziomu + bonusy vanilli: skill Optymalizacja `S_Alchemy_s08`, buff `EET_Mutagen03`, zestaw `EISB_RedWolf_2`, perk `S_Perk_20`); wywary 1, bonusy ich nie dotyczą (sesja 6, kod sesja 7). Historia: sesja 1 — stałe 3 (psuło opisy skilli); sesja 2 — baza 3 + bonusy vanilli; sesja 6 — limit vanilli (spójność z D6).
- **D8. Poziomy jak w vanilli** (sesja 1): wyższy poziom usuwa niższy, niższego nie można warzyć mając wyższy.
- **D9. Zakres** (sesja 1, rozszerzony w sesji 4): mikstury + bomby + **wywary** (od sesji 4, limit vanillowy 1 — spójność: medytacja nie odnawia niczego alchemicznego). Oleje — vanilla (przedmiot oleju i tak się nie zużywa, medytacja ich nie dotyczy → nie łamią spójności). Przedmioty questowe (tag `Quest`) wyłączone z systemu (sesja 4).
- **D10. Alkohol jest wyłącznie składnikiem** (sesja 4; wcześniej odnawiał wywary). W recepturze stały, ×1 (sesja 6) — znany problem szybszego zużycia: [roadmap.md](roadmap.md).
- **D11. Odblokowanie i powielenie** (sesja 3): pierwsze warzenie = pełna receptura vanilla („odblokowanie”), kolejne = krótsza, tańsza („powielenie”).
  1. Sygnałem jest sama lista składników w prawym panelu menu — po odblokowaniu się skraca (precedens vanilli: poziomy 1/2/3 mają różne listy bez wyjaśnień).
  2. Odblokowanie = **posiadanie przedmiotu w ekwipunku (także 0 dawek)**. Bez nowych danych w zapisie; mikstur/bomb nie da się sprzedać ani wyrzucić, więc odblokowania nie da się stracić (poza wymianą na wyższy poziom, który ma własne pierwsze warzenie). Pozyskanie innymi drogami też odblokowuje.
  3. Znacznik `isNew` na liście — odpada (menu alchemii go nie rysuje).
- **D12. Mikstura z 0 dawek zostaje w ekwipunku** (jak w vanilli) — akceptowane jako znacznik „już uwarzone” (sesja 2).
- **D13. Wariant A** (koniec sesji 3, kod sesja 4 = v0.3): reguła v2 + połowa ilości przy powielaniu (w górę, alkohol zawsze 1); warzenie tylko z menu; wywary w systemie; oleje vanilla. Szczegóły reguły: [recipes.md](recipes.md).
- **D14. Pozyskanie poza warzeniem = vanilla** (sesja 7): loot/zakup/questy/start — nowy przedmiot dostaje max, posiadany jest odrzucany komunikatem „already cooked”. Uzasadnienie użytkownika: w świecie i tak nie ma gotowych mikstur do podniesienia (niezweryfikowane w danych; poz. 2/3 na pewno nie ma w lootcie ani u kupców). Historia: v0.3 — loot nowej = 1 dawka, posiadanej +1; sesja 6 — rekomendacja „loot 1 dawka” (niepotwierdzona), zastąpiona.
- **D15. Walka: zostawić `IsInCombat`** (sesja 3) — alchemia blokuje się tylko w walce, medytacja surowiej (`IsThreatened`); nie zrównywać. Skille limitu nie są przez moda psute: decydują o liczbie bomb na jedną walkę, a dodatkowe sloty trzeba opłacić składnikami.
- **D16. Nadmiar ponad limit nie jest przycinany przy odczycie** (techniczna, v0.2) — przy wczytywaniu zapisu bonusy mogą być jeszcze nieprzywrócone → trwała utrata dawek. Nadmiar schodzi przy użyciu; warzenie zablokowane do spadku poniżej limitu.
- **D17. Stół alchemiczny w Corvo Bianco: bez premii** (sesja 6, potwierdzone w sesji 7) — `ManageSingletonItemsBonus` tylko odmawia; warzenie przy stole też bez premii; sensowna rola stołu w TODO.
- **D18. Dwa poziomy naraz na liście menu zostają** (sesja 6): posiadany niepełny poz. 1 + znana receptura poz. 2 widoczne obok siebie. Odrzucone: ukrywanie niższego poziomu przy znanej wyższej recepturze albo gdy wyższy da się uwarzyć.

- **D23. Samodzielne starty dodatków (HoS / B&W) — odłożone** (sesja 7). Rekomendacja (owinięcie `StandaloneEp*_1` + nadanie receptur posiadanym przedmiotom) i odrzucone warianty: [roadmap.md](roadmap.md#samodzielne-starty-dodatków-hos--bw--odłożone-decyzja-użytkownika-sesja-7).
- **D24. Model współpracy** (sesja 7): użytkownik decyduje i testuje w grze; Claude jako architekt zleca kod subagentom — szczegóły w `CLAUDE.md` („Współpraca”).
- **D25. Dwa poziomy na liście receptur zostają** (potwierdzone w sesji 7, por. D18): posiadana niepełna Jaskółka 1 (dolewka) + Jaskółka 2 (ulepszenie) widoczne naraz; w ekwipunku nigdy obie (ulepszenie zużywa poz. 1, poz. 1 zablokowany przy posiadanym poz. 2).
- **D26. OTWARTE (sesja 7): dwuznaczny komunikat „Już masz ten przedmiot”** (`EAE_CannotCookMore` → `panel_alchemy_exception_already_cooked`). Vanilla: „uwarzone na zawsze”; w modzie także „pełna kieszeń — uwarzysz po zużyciu” (zgłosił użytkownik). Kierunek: znaleźć **istniejący** klucz lokalizacji pasujący do pełnej kieszeni i pokazywać go tylko przy `ammo >= max` (niższy poziom przy posiadanym wyższym — vanilla); uwaga: status steruje też filtrem menu „Już wykonane” (`canCookStatusForFilter`, `alchemyMenu.ws:459/514`) — zmienić tylko tekst, nie filtr. Research przerwany (budżet), do wznowienia: enum `EAlchemyExceptions`, `AlchemyExceptionToString`, kandydaci kluczy (crafting/ekwipunek/medytacja) z brzmieniem PL/EN z `*.w3strings`. Jeśli nic nie pasuje — zostaje jak jest.
- **D27. OTWARTE (sesja 7): `Pops Antidote`** (q303) nie ma tagu `Quest`, więc mod traktuje go jak consumable (jest w tabeli receptur). Rekomendacja architekta: wyłączyć z systemu (vanilla) — czeka na decyzję użytkownika.

## Receptury powielania

- **D19. Receptury powielania ręcznie dopracowane** (sesja 6), nie liczone regułą w grze. Skrypt Python tworzy szkic; każdą recepturę poprawiamy pod kątem spójności (między poziomami rodziny), unikatowości (brak kolizji) i oryginalności (sygnaturowy składnik). Do moda trafia gotowa tabela (generowany `.ws`). Powód: audyt reguły v0.3 (kolizje, utrata symboliki) — [recipes.md](recipes.md#audyt-reguły-v03-sesja-6).
- **D20. Podmiany składników dozwolone, a nawet zalecane** (sesja 6), jeśli zachowują unikatowość; receptura powielania nie musi być podzbiorem pełnej.
- **D21. Pełna receptura też może być zmieniana** (sugestia użytkownika, sesja 6): obie receptury projektujemy razem, by powielenie było spójnym okrojeniem pełnej. Tabela = pełna + powielenie dla każdego przedmiotu.
- **D22. Części potworów w powieleniu — NIEROZSTRZYGNIĘTE** (sesja 6). Zależy od łatwości zdobycia (respawn, drop); punkt odniesienia: W1. Research: [recipes.md](recipes.md#części-potworów--research-sesja-6).

## Odrzucone

| Wariant | Sesja | Powód |
|---|---|---|
| Uzysk >1 sztuki na warzenie | 2–3 | nadwyżka ponad limit (później zbędne — D6 daje max) |
| Wariant B: medytacja warzy z zapasów składników | 3 | ciche zabieranie składników jest niejawne i myli |
| Reguła „wyrzuć najdroższy składnik” (`compare.py`) | 3 | zostawia rzadkie składniki (perła, Nigredo, Rebis, mniejsze mutageny, szpik alghula), nierówne oszczędności (Dimeritium 3: 272 → 172, wywar 28: 385 → 305) |
| Reguła powszechności v3 (lista rzadkich składników) | 3 | nie obniża kosztu receptur złożonych z samych powszechnych składników — [recipes.md](recipes.md#v3-reguła-powszechności-sesja-3--wycofana) |
| Reguła v1 (bez dzielnika, White Gull zostaje) | 3 | zastąpiona v2 — poz. 3 był pułapką kosztową, bomby poz. 3 tańsze od poz. 1 |
| Dzielnik ilości 1 | 6 | psuje bomby poz. 1 (powielenie = pełna receptura) |
| Dynamiczna podmiana składników (alternatywa wg ekwipunku) | 6 | mod-smell |
| Ukrywanie niższego poziomu na liście | 6 | D18 |
| Zrównanie blokady warzenia z medytacją (`IsThreatened`) | 3 | D15 |
| Znacznik `isNew` jako sygnał odblokowania | 3 | menu go nie rysuje |
| Przycinanie nadmiaru przy odczycie | v0.2 | D16 |
