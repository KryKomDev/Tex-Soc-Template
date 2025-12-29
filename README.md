# Šablona pro práce SOČ pro LaTeX

Tento repozitář nabízí poměrně přehlednou a krásnou šablonu
pro práce SOČ pro LaTeX.

Všechno důležité je v [Main.tex](Main.tex). Měl(a) bys mít nainstalovaný
LaTeX a LaTeX Workshop pro VS Code. Taky bys měl mít nainstalovaný python a
balík pygments.

## Instalace LaTeXu

### Na Ubuntu

```bash
sudo apt update
sudo apt install texlive-full
```

```bash
sudo apt install python3
pip install pygments
```

A pokud python otravuje s virtuálním prostředím:

```bash
sudo apt install pipx
pipx install pygments
```

### Na Arch

Tobě radit nemusim...

### Na Fedoře (a Arch)

```bash
pamac install texlive-full
pip install pygments
```

### Na Windows

Stáhni si WSL a postupuj jako na Ubuntu. Ve VS Code se pak připoj na WSL (to si najdi, zvládneš to).

### Na Mac

#### Fáze 0: Příprava mentální a digitální

Než začneme, musíte vědět dvě věci:

1. **Místo na disku:** Budeme instalovat **MacTeX**, což je kompletní distribuce TeX Live. Ta má po rozbalení **přes 4 GB**. Ujistěte se, že máte místo.
2. **Čas:** Stahování závisí na vašem internetu, ale servery TeXu nejsou vždy nejrychlejší.

---

#### Fáze 1: Otevření příkazového řádku (Terminálu)

Většinu práce uděláme přes Terminál. Je to nejčistší a nejbezpečnější způsob, jak spravovat instalace na macOS.

1. Stiskněte `Command (⌘) + Mezerník` pro otevření Spotlightu.
2. Napište slovo `Terminal`.
3. Potvrďte Enterem. Otevře se okno s černým (nebo bílým) pozadím a blikajícím kurzorem.

---

#### Fáze 2: Instalace správce balíčků Homebrew

Pokud ještě nemáte **Homebrew**, je to první nutný krok. Homebrew je "App Store pro pokročilé uživatele", který nám umožní nainstalovat vše ostatní čistě.

1. Do Terminálu zkopírujte a vložte tento příkaz (celý řádek):
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Stiskněte **Enter**.
3. Systém vás pravděpodobně vyzve k zadání **hesla k vašemu Macu**.
> **Poznámka:** Když píšete heslo do terminálu, **kurzor se nehýbe ani se neukazují hvězdičky**. Prostě ho napište "naslepo" a stiskněte Enter.

4. Počkejte, až skript doběhne.
5. **Důležité:** Na konci instalace vám Homebrew možná řekne "Next steps". Pokud uvidíte příkazy začínající na `echo 'eval...`, zkopírujte je a spusťte, aby se Homebrew přidal do vaší systémové cesty (PATH).

---

#### Fáze 3: Instalace MacTeX (Full TeX Live)

Nyní stáhneme samotný LaTeX. Na macOS se "full" verze jmenuje **MacTeX**. Obsahuje všechny balíčky, fonty a utility, které kdy budete potřebovat.

Existují dva způsoby. Vyberte si **jeden**:

##### Způsob A: Přes Homebrew (Doporučeno)

Tento způsob je lepší pro budoucí aktualizace.

1. V Terminálu zadejte:
```bash
brew install --cask mactex
```

2. Jděte si uvařit kávu. Homebrew začne stahovat cca 4-5 GB dat.
3. Po stažení automaticky spustí instalátor. Bude to vyžadovat vaše heslo (zadáte ho do vyskakovacího okna nebo do terminálu, podle situace).

##### Způsob B: Klasický instalátor (Pokud selže A)

1. Otevřete prohlížeč a jděte na [tug.org/mactex](https://www.tug.org/mactex/).
2. Klikněte na odkaz **MacTeX.pkg**.
3. Stáhněte soubor (opět cca 4 GB+).
4. Dvakrát klikněte na stažený soubor a proklikejte se instalátorem ("Další", "Souhlasím", "Instalovat").

---

#### Fáze 4: Aktualizace TeX Live Manageru

I když jste stáhli "nový" MacTeX, balíčky v něm mohou být pár týdnů staré. LaTeX má vlastní správce balíčků zvaný `tlmgr`.

1. Vraťte se do Terminálu.
2. Zadejte tento příkaz pro aktualizaci samotného správce a všech balíčků:
```bash
sudo tlmgr update --self --all
```

3. Zadejte heslo k Macu.
4. Toto může chvíli trvat, pokud vyšlo hodně aktualizací.

---

#### Fáze 5: Instalace Pythonu a Pygments

Tohle je krok, který většina lidí zkazí. Balíček `minted` (který pravděpodobně chcete používat pro hezký kód) využívá externí program `pygmentize`. Ten je součástí Python knihovny **Pygments**.

1. **Nainstalujte aktuální Python** (macOS má sice Python předinstalovaný, ale je lepší mít vlastní, nezávislou verzi přes Homebrew):
```bash
brew install python
```

2. **Ověřte instalaci Pythonu a nástroje pip** (pip je instalátor pro Python):
```bash
python3 --version
pip3 --version
```

3. **Nainstalujte Pygments:**
```bash
pip3 install Pygments
```

*(Poznámka: Velké 'P' na začátku názvu balíčku v příkazu pip.)*
4. **Ověřte, že systém "vidí" Pygments:**
Zadejte příkaz:
```bash
which pygmentize
```

Měl by vrátit cestu, například `/opt/homebrew/bin/pygmentize` nebo `/usr/local/bin/pygmentize`. Pokud terminál napíše "not found", restartujte terminál a zkuste to znovu.

---

#### Fáze 6: Zkouška ohněm (Verifikace)

Nainstalovat to je jedna věc, rozchodit to je druhá. Vytvoříme testovací soubor, který ověří, zda funguje LaTeX i Pygments dohromady.

1. Vytvořte si na ploše soubor s názvem `test.tex`.
2. Vložte do něj následující kód:

```latex
\documentclass{article}
\usepackage[utf8]{inputenc}
\usepackage{minted} % Toto vyžaduje Pygments

\begin{document}

\section*{Test instalace}
Pokud čtete tento text v PDF a níže vidíte barevný kód, gratuluji!
Máte nainstalovaný \LaTeX{} (MacTeX) a Pygments.

\begin{minted}{python}
def hello_world():
    print("Funguje to!")
\end{minted}

\end{document}
```

3. **Kompilace:**
Balíček `minted` vyžaduje speciální flag `-shell-escape`, který dovoluje LaTeXu volat externí programy (v našem případě Python/Pygments).
V terminálu přejděte na plochu:
```bash
cd ~/Desktop
```

Spusťte kompilaci:
```bash
pdflatex -shell-escape test.tex
```

4. **Výsledek:**
Pokud vše proběhlo bez chyb, na ploše se objeví `test.pdf`. Otevřete ho. Měli byste vidět nadpis a Python kód, který je **barevně zvýrazněný**.

---

#### Fáze 7: Doporučené editory (Volitelné)

Mít LaTeX v terminálu je fajn, ale psát v něm chcete v něčem pohodlném.

* **TeXShop:** Je nainstalován automaticky s MacTeXem (najdete ho v Aplikacích ve složce TeX). Je to stará škola, ale funkční.
* **Visual Studio Code (Doporučeno):**
1. Stáhněte VS Code.
2. Nainstalujte rozšíření **LaTeX Workshop**.
3. **Klíčové nastavení pro Pygments:** V nastavení VS Code (Settings JSON) musíte povolit `shell-escape`, jinak vám `minted` nebude fungovat. Hledejte nastavení `latex-workshop.latex.tools` a přidejte argument `"-shell-escape"`.
