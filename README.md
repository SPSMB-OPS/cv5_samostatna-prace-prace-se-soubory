# Ověření znalostí
*Následující materiál vznikl pro podporu výuky OPS (Operační systémy) na Střední Průmyslové Škole Mladá Boleslav [spsmb.cz](https://spsmb.cz)*
### Tags:
  `cmd.exe`, `Příkazový řádek`, `Windows`, `Práce se soubory`, `Samostatná práce`
## Školní den v příkazovém řádku

Tahle hodina už není výprava. Je to ověření dříve nabytých znalostí v CMD. Každá úloha je jeden krok: přejít, vypsat, otevřít, smazat, přesunout. Příkaz si napište sami.

Pracujte v programu Příkazový řádek, tedy `cmd.exe`. Okno PowerShellu poznáte podle `PS` na začátku řádku. To je jiný program. Zavřete ho a otevřete Příkazový řádek: klávesa Windows, napište `cmd`, Enter.

Příkazy se píší anglicky i na českých Windows.

## Než začnete

Stáhněte soubor `vytvor-skolu.bat` a spusťte ho dvojklikem, nebo z Příkazového řádku ze složky, kam jste ho uložili:

```bat
vytvor-skolu.bat
```

Skript založí složku `skola` ve vašem profilu a přepne prompt právě tam. Když složka už existuje, skript se zeptá, jestli ji smí smazat a postavit znovu. Odpověď `A` vrátí svět na začátek, odpověď `N` ho nechá být.

Mažte jen to, co úloha výslovně říká. Soubor smazaný příkazem `del` nejde vytáhnout z Koše.

Cesty pište do uvozovek, jak jste zvyklí z hodiny:

```bat
cd /d "%USERPROFILE%\skola"
```

Když se ztratíte, stejný příkaz vás vrátí do výchozí složky téhle úlohy.

Výchozí strom (než něco změníte):

```text
skola
  sesit.txt
  rozvrh.txt
  nastenka.txt
  sborovna
    vzkaz-od-tridniho.txt
  trida
    lavice
      ukol-z-matiky.txt
      tahak.txt
      penal
    kabinet
      znamky.txt
    batoh
      zmuchlany-papir.txt
      stara-zuska.txt
  jidelna
    jidelnicek.txt
    obed.txt
  satna
    mikina.txt
  chodba
    ztracena-taska
      omluvenka.txt
```

Složka `penal` je penál. Názvy jsou bez háčků a čárek, ať se dobře píšou.

## Sešit

Část příkazů po sobě na disku nezanechá stopu. Ty zapište do souboru `sesit.txt`. Skript ho založí ve složce `skola`. Na řádek napište číslo úlohy, mezeru a příkaz, který jste spustili:

```text
99 dir
```

Po tabulátoru opište už doplněný příkaz. Číslo nechte na začátku řádku. Týká se úloh 1, 2, 3, 4, 5, 6, 7, 8, 9, 13, 14, 16, 17, 18, 19, 20, 21, 22, 25, 27, 29, 31, 32, 33, 34 a 35.

Na stejný řádek připíšte i poznámku, kterou úloha chce: u 9 výsledek Honzy, u 20 první řádek tajného testu, u 33 adresu IPv4 a výchozí bránu. U 34 a 35 stačí příkaz.

## 1. Kde stojím

1. Vypište cestu ke svému profilu.
2. Vypište obsah aktuální složky, ve které právě stojíte.
3. Přejděte do složky `skola`, pokud v ní ještě nejste. Po spuštění skriptu v ní prompt už stojí.

## 2. Co leží ve škole

4. Vypište obsah souboru `rozvrh.txt`.
5. Přejděte do složky `trida`.
6. Vypište její obsah.

## 3. Lavice

7. Přejděte do složky `lavice`. Název nedopisujte celý: napište `cd la` a stiskněte Tab. Další Tab skočí na další shodu, Shift+Tab couvá. Když Tab nic nedoplní, dopište název ručně.
8. Vypište obsah složky `lavice`.
9. Vypište obsah souboru `ukol-z-matiky.txt`. Do `sesit.txt` zapište příkaz a to, co špatně spočítal Honza.

## 4. Úklid

10. Smažte soubor `tahak.txt`.
11. Vypište obsah lavice znovu a přesvědčte se, že tahák už v ní není.
12. Smažte prázdnou složku `penal`. Je prázdná, obsah mazat nemusíte.
13. Přejděte o jednu úroveň výš, zpátky do složky `trida`.
14. Vypište, ve které složce teď stojíte.
15. Smažte složku `batoh` i se soubory, které v ní jsou. Nechte příkaz, ať se zeptá, a odpovězte `A`. Výpis pak zkontrolujte příkazem `dir`. Batoh musí být pryč.

## 5. Cizí složka a skrytý test

16. Aniž byste do jídelny vstoupili, vypište její obsah. Použijte k tomu celou cestu přes svůj profil.
17. Přejděte do složky `sborovna` absolutní cestou (přes `%USERPROFILE%`, s přepínačem, který umí přejít i na jiný disk).
18. Vypište obsah sborovny obyčejným výpisem.
19. Vypište obsah sborovny znovu tak, aby se ukázaly i skryté soubory.
20. Vypište obsah skrytého souboru `tajny-test.txt`. Do `sesit.txt` zapište příkaz a jeho první řádek.

## 6. Přesuny

21. Přejděte do složky `jidelna`.
22. Vypište obsah souboru `jidelnicek.txt`.
23. Přesuňte soubor `obed.txt` do složky `skola`.
24. Ověřte přesun dvakrát: v jídelně soubor už není a ve složce `skola` ano.
25. Přejděte do složky `satna`.
26. Přesuňte soubor `mikina.txt` do složky `trida\lavice`.
27. Přejděte do složky `chodba\ztracena-taska`.
28. Přesuňte soubor `omluvenka.txt` do složky `sborovna`.
29. Z tohoto místa se vraťte jedním příkazem přímo do složky `skola`.
30. Vypište obsah složky `skola`. Musí v ní ležet i přesunutý `obed.txt`.

## 7. Nápověda a síť

31. Vypište nápovědu k příkazu `dir`. Výpis je dlouhý, stačí ho projet posuvníkem.
32. Vypište nápovědu k příkazu `ping` a najděte v ní přepínač, kterým se určuje počet dotazů.
33. Vypište síťovou konfiguraci příkazem `ipconfig`. Do `sesit.txt` zapište příkaz, adresu IPv4 a výchozí bránu.
34. Ověřte dostupnost vlastního počítače. Cíl je `127.0.0.1`, právě čtyři dotazy, ať příkaz sám skončí.
35. Ověřte dostupnost výchozí brány z úlohy 33, také právě čtyřmi dotazy. Když brána ve výpisu není, ověřte stejně `www.seznam.cz`.

## Až budete hotovi

Odevzdejte `sesit.txt` spolu s vypracovanou složkou `skola`. V sešitě mají být příkazy z úloh, které na disku nejsou vidět.

Okno, které otevřel dvojklik na skript, zavřete příkazem `exit`.

Rozbitý svět vrátí nové spuštění `vytvor-skolu.bat` a odpověď `A`.
