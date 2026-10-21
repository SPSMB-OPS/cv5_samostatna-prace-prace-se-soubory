@echo off
setlocal EnableExtensions DisableDelayedExpansion

rem Pripravi skolni svet pro overeni prikazu.
rem Slozka lezi v profilu prihlaseneho uzivatele:
rem %USERPROFILE%\skola
rem Hlaseni i texty souboru jsou bez diakritiky. Cmd cte bat
rem v kodove strance Windows, ne jako UTF-8.

if not defined USERPROFILE (
  echo Promenna USERPROFILE neni nastavena. Spustte skript v bezne relaci Windows.
  pause
  exit /b 1
)

set "ROOT=%USERPROFILE%\skola"

rem Kdyby byl cmd otevreny uvnitr skola, smazani slozky by selhalo.
cd /d "%USERPROFILE%"

set "RECREATE=1"
if exist "%ROOT%" (
  echo.
  echo Slozka skoly uz existuje a tento krok ji celou smaze:
  echo   %ROOT%
  echo.
  choice /c AN /m "Smazat ji a postavit skolu znovu"
  if errorlevel 2 set "RECREATE=0"
)

if "%RECREATE%"=="0" (
  echo.
  echo Zruseno. Skola zustava, jak je.
  pause
  exit /b 0
)

if exist "%ROOT%" rmdir /s /q "%ROOT%"
if exist "%ROOT%" (
  echo.
  echo Slozku se nepodarilo smazat. Zavrete Pruzkumnik, pokud ji ma otevrenou,
  echo a spustte skript znovu.
  echo   %ROOT%
  pause
  exit /b 1
)

mkdir "%ROOT%" || goto :fail
mkdir "%ROOT%\sborovna" || goto :fail
mkdir "%ROOT%\trida" || goto :fail
mkdir "%ROOT%\trida\lavice" || goto :fail
mkdir "%ROOT%\trida\lavice\penal" || goto :fail
mkdir "%ROOT%\trida\kabinet" || goto :fail
mkdir "%ROOT%\trida\batoh" || goto :fail
mkdir "%ROOT%\jidelna" || goto :fail
mkdir "%ROOT%\satna" || goto :fail
mkdir "%ROOT%\chodba" || goto :fail
mkdir "%ROOT%\chodba\ztracena-taska" || goto :fail

> "%ROOT%\rozvrh.txt" echo ROZVRH 8.B
>> "%ROOT%\rozvrh.txt" echo 1. Matematika - rovnice, ktere se tvari jako hadanky
>> "%ROOT%\rozvrh.txt" echo 2. Cestina - diktat, pri kterem tape i ucitel
>> "%ROOT%\rozvrh.txt" echo 3. Telocvik - vybijena, kapitan je tridni krecek
>> "%ROOT%\rozvrh.txt" echo 4. Obed - rizek, dokud ho nekdo nepresune jinam

> "%ROOT%\nastenka.txt" echo NASTENKA 8.B
>> "%ROOT%\nastenka.txt" echo Dnesni sluzba: uklid lavice, zachrana rizku a omluvenka do sborovny.
>> "%ROOT%\nastenka.txt" echo Skryte veci jsou skryte naschval.

> "%ROOT%\sborovna\vzkaz-od-tridniho.txt" echo SBOROVNA
>> "%ROOT%\sborovna\vzkaz-od-tridniho.txt" echo Kdo najde omluvenku na chodbe, at ji presune sem.
>> "%ROOT%\sborovna\vzkaz-od-tridniho.txt" echo Tahaky v lavicich mazeme. Prazdny penal taky.
>> "%ROOT%\sborovna\vzkaz-od-tridniho.txt" echo Batoh se zbytky svaciny zlikvidovat cely.

> "%ROOT%\sborovna\tajny-test.txt" echo TAJNY TEST
>> "%ROOT%\sborovna\tajny-test.txt" echo Zitra pisemka z prikazu cd, dir, type, move, del a rmdir.
>> "%ROOT%\sborovna\tajny-test.txt" echo Kdo tohle cte, uz umi dir /a.
attrib +h "%ROOT%\sborovna\tajny-test.txt"

> "%ROOT%\trida\lavice\ukol-z-matiky.txt" echo DOMACI UKOL
>> "%ROOT%\trida\lavice\ukol-z-matiky.txt" echo Kolik je 7 x 8?
>> "%ROOT%\trida\lavice\ukol-z-matiky.txt" echo Napoveda: neni to 54. To napsal Honza.
>> "%ROOT%\trida\lavice\ukol-z-matiky.txt" echo Odpoved odevzdej do lavice, ne do batohu.

> "%ROOT%\trida\lavice\tahak.txt" echo TAHAK - TENHLE SOUBOR SMAZ
>> "%ROOT%\trida\lavice\tahak.txt" echo 2+2=5
>> "%ROOT%\trida\lavice\tahak.txt" echo tajna odpoved: krecek

> "%ROOT%\trida\kabinet\znamky.txt" echo ZNAMKY TENTO TYDEN
>> "%ROOT%\trida\kabinet\znamky.txt" echo Matematika: zatim nezname, pisemka je schovana
>> "%ROOT%\trida\kabinet\znamky.txt" echo Chovani: 1, pokud smazes tahak
>> "%ROOT%\trida\kabinet\znamky.txt" echo Informatika: 1 za cd, dir a type

> "%ROOT%\trida\batoh\zmuchlany-papir.txt" echo Svacina z utery. Uz to neni jidlo, je to dukaz.
> "%ROOT%\trida\batoh\stara-zuska.txt" echo Zuska z telocviku. Smrdi az do kabinetu.

> "%ROOT%\jidelna\jidelnicek.txt" echo DNESNI MENU
>> "%ROOT%\jidelna\jidelnicek.txt" echo Polevka: vyvar z neodevzdanych ukolu
>> "%ROOT%\jidelna\jidelnicek.txt" echo Hlavni chod: smazeny rizek
>> "%ROOT%\jidelna\jidelnicek.txt" echo Moucnik: kolac, ktery zmizel z kabinetu

> "%ROOT%\jidelna\obed.txt" echo Rizek. Jeste teply. Patri do slozky skola, ne navzdy do jidelny.

> "%ROOT%\satna\mikina.txt" echo Mikina 8.B. Jmenovka: Kaja.
>> "%ROOT%\satna\mikina.txt" echo Patri zpatky do lavice, ne do satny.

> "%ROOT%\chodba\ztracena-taska\omluvenka.txt" echo OMLUVENKA
>> "%ROOT%\chodba\ztracena-taska\omluvenka.txt" echo Zak nestihl pisemku, protoze hledal prikaz cd.
>> "%ROOT%\chodba\ztracena-taska\omluvenka.txt" echo Prosim omluvit.
>> "%ROOT%\chodba\ztracena-taska\omluvenka.txt" echo Podpis: tridni krecek

> "%ROOT%\sesit.txt" echo SESIT
>> "%ROOT%\sesit.txt" echo Sem piste prikazy, ktere po sobe na disku nezanechaji stopu.
>> "%ROOT%\sesit.txt" echo Na zacatek radku patri cislo ukolu, mezera a prikaz.
>> "%ROOT%\sesit.txt" echo Priklad tvaru, ktery se nepocita: 99 dir
>> "%ROOT%\sesit.txt" echo Po tabulatoru opisujte uz doplneny prikaz.
>> "%ROOT%\sesit.txt" echo Na radek 9 pripiste, co spocital Honza.
>> "%ROOT%\sesit.txt" echo Na radek 20 pripiste prvni radek tajneho testu.
>> "%ROOT%\sesit.txt" echo Na radek 33 pripiste adresu IPv4 a vychozi branu.
>> "%ROOT%\sesit.txt" echo.
>> "%ROOT%\sesit.txt" echo 1 
>> "%ROOT%\sesit.txt" echo 2 
>> "%ROOT%\sesit.txt" echo 3 
>> "%ROOT%\sesit.txt" echo 4 
>> "%ROOT%\sesit.txt" echo 5 
>> "%ROOT%\sesit.txt" echo 6 
>> "%ROOT%\sesit.txt" echo 7 
>> "%ROOT%\sesit.txt" echo 8 
>> "%ROOT%\sesit.txt" echo 9 
>> "%ROOT%\sesit.txt" echo 13 
>> "%ROOT%\sesit.txt" echo 14 
>> "%ROOT%\sesit.txt" echo 16 
>> "%ROOT%\sesit.txt" echo 17 
>> "%ROOT%\sesit.txt" echo 18 
>> "%ROOT%\sesit.txt" echo 19 
>> "%ROOT%\sesit.txt" echo 20 
>> "%ROOT%\sesit.txt" echo 21 
>> "%ROOT%\sesit.txt" echo 22 
>> "%ROOT%\sesit.txt" echo 25 
>> "%ROOT%\sesit.txt" echo 27 
>> "%ROOT%\sesit.txt" echo 29 
>> "%ROOT%\sesit.txt" echo 31 
>> "%ROOT%\sesit.txt" echo 32 
>> "%ROOT%\sesit.txt" echo 33 
>> "%ROOT%\sesit.txt" echo 34 
>> "%ROOT%\sesit.txt" echo 35 

echo.
echo Skola je pripravena.
echo Slozka:
echo   %ROOT%
echo Sesit:
echo   %ROOT%\sesit.txt
echo.
echo Otevrite zadani a jdete ukol po ukolu.
echo Prvni prikaz: dir

rem endlocal by po skonceni skriptu vratil puvodni slozku.
rem Procenta se rozvinou jeste pred endlocal, takze cesta prezije.
endlocal & cd /d "%ROOT%"
title Skola

rem Dvojklik spousti cmd s prepinacem /c a po skonceni skriptu by okno zavrel.
rem V tom pripade nechame otevreny vlastni prompt. Z uz otevreneho cmd
rem skript bezi v tom samem okne a slozka uz je aktualni.
echo %cmdcmdline% | findstr /i /c:" /c " >nul
if not errorlevel 1 (
  echo Az budete chtit okno zavrit, napiste: exit
  echo.
  cmd /k
)
exit /b 0

:fail
echo.
echo Nepodarilo se vytvorit slozky v:
echo   %ROOT%
pause
exit /b 1
