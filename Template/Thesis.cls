% SOC TEMPLATE by KryKom
% Licencováno pro Tebe pod MIT Licencí

% nastavení dokumentu
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Template/Thesis}[2026/01/01 Document class for czech SOC theses]
\LoadClass[12pt, a4paper, oneside]{report}

% importy
\RequirePackage[utf8]{inputenc}
\RequirePackage[czech]{babel}
\RequirePackage{graphicx}
\RequirePackage{tabularx}
\RequirePackage{array}
\RequirePackage[bookmarksopen,colorlinks,plainpages=false,linkcolor=black,urlcolor=blue,citecolor=black,filecolor=black,menucolor=black,unicode=true,breaklinks]{hyperref}
\RequirePackage{csquotes}
\RequirePackage{caption}
\RequirePackage{xstring}

% nastavení mezer
\setlength{\intextsep}{5mm} 
\marginparsep=12pt
\linespread{1.15}
\unitlength=1mm

% hyperref \autoref názvy
\def\sectionautorefname{Kapitola}
\def\figureautorefname{Obrázek}
\def\tableautorefname{Tabulka}
\def\codeautorefname{Ukázka kódu}
\def\equationautorefname{Rovnice}
\def\chaptername{Kapitola}

\addto\extrasczech{%
  \renewcommand{\chapterautorefname}{Kapitola}%
}

% proměnné
\def\titlecz#1{\def\@titlecz{#1}}
\def\titleen#1{\def\@titleen{#1}}
\def\author#1{\def\@author{#1}}
\def\school#1{\def\@school{#1}}
\def\region#1{\def\@region{#1}}
\def\city#1{\def\@city{#1}}
\def\mentor#1{\def\@mentor{#1}}
\def\created#1{\def\@created{#1}}
\def\placefooter#1{\def\@placefooter{#1}}

\newcommand{\field}[1]{%
	\IfStrEqCase{#1}{
    	{1}{\def\@field{Matematika a~statistika (1)}}
    	{2}{\def\@field{Fyzika (2)}}
    	{3}{\def\@field{Chemie (3)}}
    	{4}{\def\@field{Biologie, geografie a~geologie (4)}}
    	{5}{\def\@field{Molekulární biologie (5)}}
    	{6}{\def\@field{Zdravotnictví (6)}}
    	{7}{\def\@field{Zemědělství, potravinářství, lesní a~vodní hospodářství (7)}}
    	{8}{\def\@field{Ochrana a~tvorba životního prostředí (8)}}
    	{9}{\def\@field{Strojírenství, hutnictví a~doprava (9)}}
    	{10}{\def\@field{Elektrotechnika, elektronika a~telekomunikace (10)}}
    	{11}{\def\@field{Stavebnictví, architektura a~design interiérů (11)}}
    	{12}{\def\@field{Tvorba učebních pomůcek, didaktická technologie (12)}}
    	{13}{\def\@field{Ekonomika a~řízení (13)}}
    	{14}{\def\@field{Pedagogika, psychologie, sociologie a~problematika volného času (14)}}
    	{15}{\def\@field{Teorie kultury, umění a~umělecké tvorby (15)}}
    	{16}{\def\@field{Historie (16)}}
    	{17}{\def\@field{Filozofie, politologie a~ostatní humanitní a~společenskovědní obory (17)}}
    	{18}{\def\@field{Informatika (18)}}
  	}
  	[Neznámé číslo oboru, upravte \\field{} příkaz!]
}

\titleen{}
\region{\@region}
\placefooter{\@city - \the\year}
\created{\the\year}

\renewcommand{\maketitle}{%
	\pagestyle{empty}

	\pagestyle{empty}
	\begin{center}
	    {\fontsize{18pt}{21.6pt} \textbf{STŘEDOŠKOLSKÁ ODBORNÁ ČINNOST}} \\
		\vspace{5mm}
		\fontsize{14pt}{16.8pt} \textbf{Obor: \@field} \\

		\vspace{60mm}

		{\fontsize{20pt}{24pt} \textbf{\@titlecz}} \\
		\vspace{10mm}
		{\fontsize{20pt}{24pt} \textbf{\@titleen}} \\
	\end{center}

	\vfill

	\begin{spacing}{1.5}
		{\fontsize{16pt}{19.2pt}\textbf{Autor:} \fontsize{16pt}{19.2pt}\selectfont\@author}\hfill\\
		{\fontsize{16pt}{19.2pt}\textbf{Škola:} \fontsize{16pt}{19.2pt}\selectfont\@school}\hfill\\
		{\fontsize{16pt}{19.2pt}\textbf{Kraj:} \fontsize{16pt}{19.2pt}\selectfont\@region}\hfill\\
		{\fontsize{16pt}{19.2pt}\textbf{Konzultant:} \fontsize{16pt}{19.2pt}\selectfont\@mentor}\hfill\\
		{\fontsize{16pt}{19.2pt}\textbf{Rok:} \fontsize{16pt}{19.2pt}\selectfont\@created}

	\end{spacing}

	\vspace{15mm}

	{\raggedright}

	\newpage
	\voffset = 0mm
	\pagestyle{plain}
}

% Prohlášení

\newcommand{\ainotused}{%
	Dále prohlašuji, že při tvorbě této práce jsem nepoužil/a nástroje AI.
}

\newcommand{\aiused}[2]{%
	Dále prohlašuji, že při tvorbě této práce jsem použil/a nástroj generativního
	modelu AI #1 za účelem #2. Po použití tohoto nástroje jsem provedl/a 
	kontrolu obsahu a přebírám za něj plnou zodpovědnost.
}

\newcommand{\makecopyrightstatement}[2]{%
	\pagestyle{empty}

	~
	\vfill

	\section*{Prohlášení}
	Prohlašuji, že jsem svou práci SOČ vypracoval/a samostatně a použil/a 
	jsem pouze prameny a literaturu uvedené v seznamu bibliografických záznamů.

	Beru na vědomí, že nejpozději odevzdáním slovesné vědecké práce do 
	veřejné soutěže Středoškolská odborná činnost, stejně jako odevzdáním 
	jejích příloh a dalších připojených děl, např. audiovizuálních, 
	fotografických, výtvarných, architektonických apod. (dále jen 
	„soutěžní dílo“), dochází ke zveřejnění díla podle § 4 odst. 1 
	zákona č. 121/2000 Sb., autorského zákona, ve znění pozdějších 
	předpisů (dále jen „autorský zákon“). Totéž platí pro pozdější 
	odevzdání doplněného, změněného, upraveného nebo opraveného díla.

	Beru na vědomí, že zveřejněním díla, jehož součástí je vynález, 
	se tento vynález stává součástí stavu techniky podle § 5 odst. 1, 
	2 zákona č. 527/1990 Sb., o vynálezech, průmyslových vzorech a 
	zlepšovacích návrzích, ve znění pozdějších předpisů (dále jen 
	„patentový zákon“), což zakládá překážku pro udělení patentu 
	podle § 3 odst. 1 patentového zákona.
	
	Beru na vědomí, že vyhlašovatel soutěže je podle § 61 odst. 
	1 autorského zákona per analogiam oprávněn užít soutěžní dílo 
	pro účely zajištění průběhu soutěže, zejména k zajištění 
	transparentnosti soutěže a veřejnosti obhajob soutěžních 
	prací. V odůvodněném rozsahu je tedy vyhlašovatel po dobu 
	účasti autora v soutěži oprávněn zejména:

	\begin{itemize}
		
		\item zhotovovat rozmnoženiny díla, je-li to nezbytné k seznámení 
		účastníků soutěže, porotců nebo veřejnosti se soutěžní prací;

		\item zapůjčit originál nebo rozmnoženinu díla účastníkům soutěže,
		porotcům nebo veřejnosti. Přitom dbá na bezpečné nakládání s dílem;

		\item vystavovat originál nebo rozmnoženinu díla v průběhu 
		soutěžních přehlídek a doprovodných akcí; 

		\item sdělovat dílo veřejnosti v nehmotné podobě, a to 
		především počítačovou nebo obdobnou sítí.

	\end{itemize}

	#2

	\vspace{10mm}

	\noindent \parbox{\textwidth}{
		\noindent {#1} dne: \rule{4cm}{1pt}
		\hfill\parbox{5cm}{
    		\centering
    		\vspace{9mm}
    		\rule{5cm}{1pt}\\
        	\@author
		}
	}

	\newpage
	\pagestyle{plain}
}

\newcommand{\makethanks}[1]{
	\pagestyle{empty}
	~
	\vfill
	\section*{Poděkování}
	{#1}

	\newpage
	\pagestyle{plain}
}

\makeatletter
\renewcommand{\fps@table}{h!}
\makeatother