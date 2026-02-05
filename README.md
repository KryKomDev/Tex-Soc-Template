# Šablona pro práce SOČ pro LaTeX

Tento repozitář nabízí poměrně přehlednou a krásnou šablonu
pro práce SOČ pro LaTeX.

Všechno důležité je v [Main.tex](Main.tex). Měl(a) bys mít nainstalovaný
LaTeX a LaTeX Workshop pro VS Code. Taky bys měl mít nainstalovaný python a
balík pygments.

## Instalace 

Ve složce Scripts jsou instalační scripty pro jednotlivé operační
systémy. Jestli tam není tvůj OS, poraď si sám.

### Linux

```bash
bash ./Scripts/InstallTex-Linux.sh
```

Skript by měl fungovat pro většinu distribucí, ale pokud nefunguje
nainstaluj PowerShell, Docker a image pro Docker texlive/texlive.

### Windows

```bash
powershell ./Scripts/InstallTex-Windows.ps1
```

### MacOs

Gratulujeme k vlastnictví prémiového těžítka. Abychom na tento úžasný stroj dostali něco tak 
plebejského jako LaTeX, postupujte prosím s maximální opatrností podle tohoto návodu pro "pokročilé":

1. Ujistěte se, že sedíte v kavárně a všichni vidí vaše nakousnuté jablko.
2. Zkontrolujte, zda máte připojený dongle na USB, dongle na HDMI a dongle na dýchání.
3. Otevřete Launchpad (to je ta ikona s raketkou, co dělá *fjuuu*).
4. Do vyhledávacího pole napište "Terminal". Nebojte se, je to jen textové okno, nekousne vás to.
5. Klikněte na tu černou ikonku. Cítíte se jako hacker? Skvělé.
6. Nyní musíme systému říct, aby udělal něco užitečného. Zkopírujte následující příkaz. 
   Pozor! Na vaší magické klávesnici se to dělá pomocí `Command + C`, ne `Ctrl + C` jako u normálních počítačů.

```bash
bash ./Scripts/InstallTex-MacOs.sh
```

7. Vložte příkaz do terminálu pomocí `Command + V`.
8. Zhluboka se nadechněte a stiskněte klávesu `Return` (nebo Enter, pokud nejste "true Apple fan").
9. Pokud po vás systém bude chtít heslo, zadejte ho. Nebudou se ukazovat hvězdičky, to je "feature", ne chyba.
10. Vyčkejte, než se vše nainstaluje. Ideální čas objednat si další Pumpkin Spice Latte.