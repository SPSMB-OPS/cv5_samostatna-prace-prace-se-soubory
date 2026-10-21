@echo off
setlocal EnableExtensions DisableDelayedExpansion

rem Kontrola zadani po vypracovani.
rem Slozku skola jen cte. Prikazy bez stopy na disku hleda v sesit.txt.
rem Sesit: nejdriv v aktualni slozce, jinak vedle tohoto skriptu.

if not defined USERPROFILE (
  echo Promenna USERPROFILE neni nastavena. Spustte skript v bezne relaci Windows.
  pause
  exit /b 1
)

set "ROOT=%USERPROFILE%\skola"
set "SESIT=%ROOT%\sesit.txt"
if not exist "%SESIT%" set "SESIT=%CD%\sesit.txt"
if not exist "%SESIT%" set "SESIT=%~dp0sesit.txt"
set "LINEF=%TEMP%\sesit-uloha.txt"
set "PASS=0"
set "FAIL=0"
set "EXTRA=0"

echo.
echo Overeni zadani: Skolni den v prikazovem radku
echo Slozka: %ROOT%
echo Sesit:  %SESIT%
echo.

if not exist "%ROOT%\" (
  echo [CHYBA] Slozka skola neexistuje.
  echo         Nejdriv spustte vytvor-skolu.bat a zadani vypracujte.
  echo.
  pause
  exit /b 1
)

if not exist "%SESIT%" (
  echo [CHYBA] Soubor sesit.txt nenalezen.
  echo         Ma lezet ve slozce skola. Zalozi ho vytvor-skolu.bat.
  echo.
)

echo Jednotlive ukoly
echo ----------------

call :check 1
call :has echo
call :any2 userprofile Users "na radku 1 chybi cesta k profilu"
call :result "1   echo USERPROFILE"

call :check 2
call :has dir
call :lacks "/a"
call :lacks_help
call :result "2   dir"

call :check 3
call :has cd
call :has skola
call :result "3   cd do slozky skola"

call :check 4
call :has type
call :has rozvrh
call :result "4   type rozvrh.txt"

call :check 5
call :has cd
call :has trida
call :lacks lavice
call :result "5   cd trida"

call :check 6
call :has dir
call :lacks "/a"
call :lacks_help
call :result "6   dir"

call :check 7
call :has cd
call :has lavice
call :result "7   cd lavice"

call :check 8
call :has dir
call :lacks "/a"
call :lacks_help
call :result "8   dir"

call :check 9
call :has type
call :has ukol
call :has 54
call :result "9   type ukol-z-matiky.txt a vysledek Honzy"

call :eval_tahak
if not defined WHY10 (
  call :pass "10  tahak.txt je smazany a ukol-z-matiky.txt zustal"
  call :pass "11  v lavici uz tahak neni"
) else (
  call :fail "10  %WHY10%"
  call :fail "11  %WHY10%"
)

call :eval_penal
if not defined WHY12 (
  call :pass "12  prazdna slozka penal je smazana"
) else (
  call :fail "12  %WHY12%"
)

call :check 13
call :has cd
call :has ".."
call :result "13  cd .."

call :check 14
call :eval14
call :result "14  cd nebo echo CD"

call :eval_batoh
if not defined WHY15 (
  call :pass "15  slozka batoh je smazana, trida a kabinet zustaly"
) else (
  call :fail "15  %WHY15%"
)

call :check 16
call :has dir
call :has jidelna
call :any2 skola userprofile "na radku 16 chybi cesta pres profil nebo slozku skola"
call :result "16  dir jidelny pres cestu"

call :check 17
call :has cd
call :has "/d"
call :has sborovna
call :result "17  cd /d do sborovny"

call :check 18
call :has dir
call :lacks "/a"
call :lacks_help
call :result "18  dir"

call :check 19
call :has dir
call :has "/a"
call :result "19  dir /a"

call :check 20
call :has type
call :has tajn
call :result "20  type tajny-test.txt a jeho prvni radek"

call :check 21
call :has cd
call :has jidelna
call :result "21  cd jidelna"

call :check 22
call :has type
call :has jidelnicek
call :result "22  type jidelnicek.txt"

call :eval_obed
if not defined WHY23 (
  call :pass "23  obed.txt je ve slozce skola a v jidelne uz neni"
) else (
  call :fail "23  %WHY23%"
)
if not defined WHY24 (
  call :pass "24  v jidelne obed neni, jidelnicek zustal a ve skola obed je"
) else (
  call :fail "24  %WHY24%"
)

call :check 25
call :has cd
call :has satna
call :result "25  cd satna"

call :eval_mikina
if not defined WHY26 (
  call :pass "26  mikina.txt je v trida\lavice a v satne uz neni"
) else (
  call :fail "26  %WHY26%"
)

call :check 27
call :has cd
call :has ztracena
call :result "27  cd do ztracena-taska"

call :eval_omluvenka
if not defined WHY28 (
  call :pass "28  omluvenka.txt je ve sborovne a ve ztracene tasce uz neni"
) else (
  call :fail "28  %WHY28%"
)

call :check 29
call :has cd
call :has "/d"
call :has skola
call :result "29  cd /d do slozky skola"

if not defined WHY30 (
  call :pass "30  presunuty obed.txt lezi ve slozce skola"
) else (
  call :fail "30  %WHY30%"
)

call :check 31
call :has dir
call :has_help
call :result "31  dir /?"

call :check 32
call :has ping
call :has_help
call :result "32  ping /?"

call :check 33
call :has ipconfig
call :result "33  ipconfig"

call :check 34
call :has ping
call :has "-n"
call :has 4
call :has 127.0.0.1
call :result "34  ping -n 4 127.0.0.1"

call :check 35
call :has ping
call :has "-n"
call :has 4
call :reject_localhost
call :result "35  ping -n 4 na branu nebo www.seznam.cz"

echo.
echo Co melo zustat
echo --------------
set "EXTRA=0"
call :need "%ROOT%\rozvrh.txt" "rozvrh.txt"
call :need "%ROOT%\nastenka.txt" "nastenka.txt"
call :need "%ROOT%\sborovna\vzkaz-od-tridniho.txt" "sborovna\vzkaz-od-tridniho.txt"
call :need "%ROOT%\sborovna\tajny-test.txt" "sborovna\tajny-test.txt"
call :need "%ROOT%\trida\lavice\ukol-z-matiky.txt" "trida\lavice\ukol-z-matiky.txt"
call :need "%ROOT%\trida\kabinet\znamky.txt" "trida\kabinet\znamky.txt"
call :need "%ROOT%\jidelna\jidelnicek.txt" "jidelna\jidelnicek.txt"
call :needdir "%ROOT%\sborovna" "sborovna"
call :needdir "%ROOT%\trida" "trida"
call :needdir "%ROOT%\trida\lavice" "trida\lavice"
call :needdir "%ROOT%\trida\kabinet" "trida\kabinet"
call :needdir "%ROOT%\jidelna" "jidelna"
call :needdir "%ROOT%\satna" "satna"
call :needdir "%ROOT%\chodba" "chodba"
call :needdir "%ROOT%\chodba\ztracena-taska" "chodba\ztracena-taska"
if "%EXTRA%"=="0" echo [OK]    nic jineho nechybi

call :note_hidden

echo.
echo Souhrn
echo ------
echo Splneno: %PASS%
echo Chyby:   %FAIL%
if not "%EXTRA%"=="0" echo Navic chybi: %EXTRA%
echo.
echo Z disku jsou ukoly 10, 11, 12, 15, 23, 24, 26, 28 a 30.
echo Ostatni prikazy se ctou ze sesit.txt, radek musi zacinat cislem ukolu.
echo.

if exist "%LINEF%" del /q "%LINEF%" >nul 2>&1
pause
if not "%FAIL%"=="0" exit /b 1
if not "%EXTRA%"=="0" exit /b 1
exit /b 0


:check
set "TASK=%~1"
set "CHECK=1"
set "WHY=v sesit.txt chybi radek %~1"
if not exist "%SESIT%" (
  set "CHECK=0"
  set "WHY=chybi sesit.txt"
  exit /b 0
)
findstr /i /r /c:"^ *%~1[^0-9]" "%SESIT%" > "%LINEF%" 2>nul
if errorlevel 1 set "CHECK=0"
exit /b 0

:has
if "%CHECK%"=="0" exit /b 0
findstr /i /c:"%~1" "%LINEF%" >nul
if errorlevel 1 (
  set "CHECK=0"
  set "WHY=na radku %TASK% chybi %~1"
)
exit /b 0

:any2
if "%CHECK%"=="0" exit /b 0
set "ANY=0"
findstr /i /c:"%~1" "%LINEF%" >nul
if not errorlevel 1 set "ANY=1"
findstr /i /c:"%~2" "%LINEF%" >nul
if not errorlevel 1 set "ANY=1"
if "%ANY%"=="1" exit /b 0
set "CHECK=0"
set "WHY=%~3"
exit /b 0

:lacks
if "%CHECK%"=="0" exit /b 0
findstr /i /c:"%~1" "%LINEF%" >nul
if not errorlevel 1 (
  set "CHECK=0"
  set "WHY=na radku %TASK% nema byt %~1"
)
exit /b 0

:lacks_help
if "%CHECK%"=="0" exit /b 0
findstr /r /c:"/[?]" "%LINEF%" >nul
if not errorlevel 1 (
  set "CHECK=0"
  set "WHY=na radku %TASK% nema byt napoveda"
)
exit /b 0

:has_help
if "%CHECK%"=="0" exit /b 0
findstr /r /c:"/[?]" "%LINEF%" >nul
if errorlevel 1 (
  set "CHECK=0"
  set "WHY=na radku %TASK% chybi prepinac napovedy"
)
exit /b 0

:eval14
if "%CHECK%"=="0" exit /b 0
findstr /i /c:".." "%LINEF%" >nul
if not errorlevel 1 goto :eval14_fail
findstr /i /c:"echo" "%LINEF%" >nul
if errorlevel 1 goto :eval14_bare
findstr /i /c:"cd" "%LINEF%" >nul
if errorlevel 1 goto :eval14_bare
exit /b 0
:eval14_bare
findstr /i /c:"chdir" "%LINEF%" >nul
if not errorlevel 1 exit /b 0
findstr /i /c:"cd" "%LINEF%" >nul
if errorlevel 1 goto :eval14_fail
findstr /i /r \\ "%LINEF%" >nul
if not errorlevel 1 goto :eval14_fail
findstr /i /c:"/d" "%LINEF%" >nul
if not errorlevel 1 goto :eval14_fail
exit /b 0
:eval14_fail
set "CHECK=0"
set "WHY=na radku 14 ma byt samotne cd nebo echo CD"
exit /b 0

:reject_localhost
if "%CHECK%"=="0" exit /b 0
findstr /i /c:"127.0.0.1" "%LINEF%" >nul
if errorlevel 1 exit /b 0
findstr /i /c:"seznam" "%LINEF%" >nul
if not errorlevel 1 exit /b 0
set "CHECK=0"
set "WHY=ukol 35 nema pingat 127.0.0.1, ale branu nebo www.seznam.cz"
exit /b 0

:result
if "%CHECK%"=="1" (
  call :pass "%~1"
) else (
  call :fail "%TASK%  %WHY%"
)
exit /b 0

:eval_tahak
set "WHY10="
if not exist "%ROOT%\trida\lavice\" set "WHY10=chybi slozka trida\lavice"
if exist "%ROOT%\trida\lavice\" if not exist "%ROOT%\trida\lavice\ukol-z-matiky.txt" set "WHY10=chybi ukol-z-matiky.txt, tahak mohl zmizet s celou lavici"
if exist "%ROOT%\trida\lavice\tahak.txt" set "WHY10=tahak.txt v lavici porad je"
if not exist "%ROOT%\trida\lavice\tahak.txt" if exist "%ROOT%\trida\lavice\ukol-z-matiky.txt" set "WHY10="
exit /b 0

:eval_penal
set "WHY12="
if not exist "%ROOT%\trida\lavice\" set "WHY12=chybi slozka trida\lavice, penal nelze uznat jako smazany"
if exist "%ROOT%\trida\lavice\penal\" set "WHY12=slozka penal jeste existuje"
if exist "%ROOT%\trida\lavice\" if not exist "%ROOT%\trida\lavice\penal\" set "WHY12="
exit /b 0

:eval_batoh
set "WHY15="
if not exist "%ROOT%\trida\" set "WHY15=chybi slozka trida, batoh nelze uznat jako smazany"
if not exist "%ROOT%\trida\lavice\" set "WHY15=chybi lavice, batoh nelze uznat jako smazany"
if not exist "%ROOT%\trida\kabinet\znamky.txt" set "WHY15=chybi kabinet\znamky.txt, smazani batohu nelze uznat"
if exist "%ROOT%\trida\batoh\" set "WHY15=slozka batoh jeste existuje"
if exist "%ROOT%\trida\lavice\" if exist "%ROOT%\trida\kabinet\znamky.txt" if not exist "%ROOT%\trida\batoh\" set "WHY15="
exit /b 0

:eval_obed
set "WHY23="
set "WHY24="
set "WHY30="
set "OBED_HERE=0"
set "OBED_THERE=0"
set "OBED_TEXT=0"
if exist "%ROOT%\obed.txt" set "OBED_HERE=1"
if exist "%ROOT%\jidelna\obed.txt" set "OBED_THERE=1"
if "%OBED_HERE%"=="1" (
  findstr /i /c:"Rizek" "%ROOT%\obed.txt" >nul
  if not errorlevel 1 set "OBED_TEXT=1"
)
if "%OBED_HERE%"=="0" if "%OBED_THERE%"=="1" set "WHY23=obed.txt je porad v jidelne a ve skola neni"
if "%OBED_HERE%"=="0" if "%OBED_THERE%"=="0" set "WHY23=obed.txt chybi ve skola i v jidelne"
if "%OBED_HERE%"=="1" if "%OBED_THERE%"=="1" set "WHY23=obed.txt je ve skola, ale v jidelne zustal taky"
if "%OBED_HERE%"=="1" if "%OBED_THERE%"=="0" if "%OBED_TEXT%"=="0" set "WHY23=ve skola lezi obed.txt, ale neni to puvodni rizek"
if "%OBED_HERE%"=="1" if "%OBED_THERE%"=="0" if "%OBED_TEXT%"=="1" set "WHY23="

if defined WHY23 (
  set "WHY24=%WHY23%"
) else if not exist "%ROOT%\jidelna\jidelnicek.txt" (
  set "WHY24=presun sedi, ale v jidelne chybi jidelnicek.txt"
) else if not exist "%ROOT%\jidelna\" (
  set "WHY24=chybi slozka jidelna, vypis obou mist nejde uznat"
) else (
  set "WHY24="
)

set "WHY30=ve slozce skola neni puvodni obed.txt"
if "%OBED_HERE%"=="1" if "%OBED_TEXT%"=="1" set "WHY30="
exit /b 0

:eval_mikina
set "WHY26="
if exist "%ROOT%\satna\mikina.txt" if not exist "%ROOT%\trida\lavice\mikina.txt" set "WHY26=mikina.txt je porad v satne"
if exist "%ROOT%\satna\mikina.txt" if exist "%ROOT%\trida\lavice\mikina.txt" set "WHY26=mikina.txt je v lavici, ale v satne zustala taky"
if not exist "%ROOT%\satna\mikina.txt" if not exist "%ROOT%\trida\lavice\mikina.txt" set "WHY26=mikina.txt neni v trida\lavice ani v satne"
if not exist "%ROOT%\satna\mikina.txt" if exist "%ROOT%\trida\lavice\mikina.txt" (
  findstr /i /c:"Mikina" "%ROOT%\trida\lavice\mikina.txt" >nul
  if errorlevel 1 (
    set "WHY26=soubor v lavici neni puvodni mikina"
  ) else (
    set "WHY26="
  )
)
exit /b 0

:eval_omluvenka
set "WHY28="
if exist "%ROOT%\chodba\ztracena-taska\omluvenka.txt" if not exist "%ROOT%\sborovna\omluvenka.txt" set "WHY28=omluvenka.txt je porad ve ztracene tasce"
if exist "%ROOT%\chodba\ztracena-taska\omluvenka.txt" if exist "%ROOT%\sborovna\omluvenka.txt" set "WHY28=omluvenka.txt je ve sborovne, ale ve tasce zustala taky"
if not exist "%ROOT%\chodba\ztracena-taska\omluvenka.txt" if not exist "%ROOT%\sborovna\omluvenka.txt" set "WHY28=omluvenka.txt neni ve sborovne ani ve ztracene tasce"
if not exist "%ROOT%\chodba\ztracena-taska\omluvenka.txt" if exist "%ROOT%\sborovna\omluvenka.txt" (
  findstr /i /c:"OMLUVENKA" "%ROOT%\sborovna\omluvenka.txt" >nul
  if errorlevel 1 (
    set "WHY28=soubor ve sborovne neni puvodni omluvenka"
  ) else (
    set "WHY28="
  )
)
exit /b 0

:note_hidden
set "HIDE=%ROOT%\sborovna\tajny-test.txt"
if not exist "%HIDE%" exit /b 0
attrib "%HIDE%" | findstr /r /c:"^[^:]*H" >nul
if errorlevel 1 (
  echo [POZOR] tajny-test.txt uz neni skryty. Ukol 20 ho jen cte, atribut menit nema.
) else (
  echo [OK]    tajny-test.txt je porad skryty
)
exit /b 0

:need
if exist "%~1" exit /b 0
echo [CHYBA] chybi %~2
set /a EXTRA+=1
exit /b 0

:needdir
if exist "%~1\" exit /b 0
echo [CHYBA] chybi slozka %~2
set /a EXTRA+=1
exit /b 0

:pass
echo [OK]    %~1
set /a PASS+=1
exit /b 0

:fail
echo [CHYBA] %~1
set /a FAIL+=1
exit /b 0
