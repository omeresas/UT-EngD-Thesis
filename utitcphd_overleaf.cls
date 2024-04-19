%------------------------------------------------------
% This file is a LaTeX class file for typesetting the
% PhD theses within ITC.
% Do not change this file under any circumstances, but
% if you do, rename it!            RdB ITC, 2011/03/28
%------------------------------------------------------
% IDENTIFICATION
%------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}[1998/12/01]
\ProvidesClass{utitcphd_overleaf}[2021/12/07 UT/ITC PhD thesis class, version 0.995]
% Changes to 0.995: changes names from promotor to supervisor, etc.
% Changes to 0.98: includes LoF and LOT in Contents listing
% Changes to 0.98: removed usage of \fixpdflayout
% Changes to 0.97: added 'dutch' as babel option
% Changes to 0.93: ...
% Changes to 0.92: changed \normalfont in captions to \small
%------------------------------------------------------
% OPTIONS
%------------------------------------------------------
\DeclareOption{10pt}{\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{openright}{\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{showtrims}{\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption*{%
   \ClassWarning{utitcphd}{You have asked for option `\CurrentOption' but
        that option is unavailable, and I do not know what that is.}}
% Execute the DEFAULT options
\ExecuteOptions{10pt,openright}
\ProcessOptions\relax

%------------------------------------------------------
% DECLARATIONS
%------------------------------------------------------
%% Load the standard memoir class
\LoadClass[]{memoir}[2009/09/01]

%------------------------------------------------------
%% We have English as the standard language
\RequirePackage[dutch,USenglish,UKenglish]{babel}

%------------------------------------------------------
%% Do specialistic typesetting with Microtype, makes use
%% of font expansion for a better fit on the page.
\RequirePackage{soul}  % for letterspacing

\RequirePackage[%
	kerning=false,
	expansion=alltext-nott,
	protrusion=true,
	final=true]{microtype}
%------------------------------------------------------
%% Bibliography settings
% \RequirePackage{natbib}

%------------------------------------------------------
%% Mathematics settings
\RequirePackage{amsthm}
\RequirePackage[fleqn]{amsmath}
\RequirePackage{amssymb}
%% bold mathematical symbol
\def\mathbold#1{$\boldsymbol{#1}$}
%------------------------------------------------------
%% Now to graphics settings
\RequirePackage{graphicx}

% TiKZ!
\RequirePackage{tikz}
\usetikzlibrary{arrows}
\usetikzlibrary{automata}
\usetikzlibrary{decorations}

\usetikzlibrary{patterns}

\pgfdeclarelayer{background} % Grid, dots
\pgfsetlayers{background,main}

%% New Tikz arrow
\pgfarrowsdeclarecombine[\pgflinewidth]{combined1}{combined1}{latex}{latex}{o}{o}%
\pgfarrowsdeclarecombine[\pgflinewidth]{combined}{combined}{*}{*}{stealth}{stealth}

%------------------------------------------------------
%% Memoir settings
%
% Needed to make autoref work.
\theoremstyle{definition}
\newtheorem{definition}{Definition}[section]
\newtheorem{example}[definition]{Example}
\newtheorem{assumption}[definition]{Assumption}
\newtheorem{note}[definition]{Note}

\theoremstyle{plain}
\newtheorem{theorem}[definition]{Theorem}
\newtheorem{lemma}[definition]{Lemma}

\theoremstyle{remark}
\newtheorem{remark}[definition]{Remark}

% Document style
\newlength{\chapnumwidth}
\makechapterstyle{verslag}{
	\renewcommand{\printchaptername}{\hrule\vskip\onelineskip \raggedright}
	\renewcommand{\printchapternonum}{\printchaptername}
	\renewcommand{\chapnumfont}{\normalfont\Huge\itshape}
	\newlength{\numberheight}
	\setlength{\numberheight}{\baselineskip}
	\addtolength{\numberheight}{2\onelineskip}
	\renewcommand{\printchapternum}{\chapnumfont%
		%Puts TeX into H-mode, otherwise llap will think it'll have to start a new paragraph
		\noindent%
		%llap for the positioning, smash so the number won't take up vertical space and hence
		%push the lines apart
		\rlap{\smash{%
			% We want it to fit between the lines, and there is onelineskip of space
			% between the title and the hrule
			\raisebox{-\onelineskip}{
				% For now, we assume all titles have one line
				\hspace{\textwidth}\hspace{.5em}\resizebox{!}{\numberheight}{\textls*[-15]{\color{gray}{\thechapter}}}%
			}%
		}}%
	}
	\renewcommand{\afterchapternum}{}
	\renewcommand{\chaptitlefont}{\normalfont\Huge\sffamily\bfseries}
	\renewcommand{\printchaptertitle}[1]{\chaptitlefont ##1}
	\renewcommand{\afterchaptertitle}{%
		\vskip\onelineskip \hrule\vskip \afterchapskip%
	}
}

\chapterstyle{verslag}

\newlength{\halflineskip}
\setlength{\halflineskip}{.5\onelineskip}
\newcommand{\ruledsec}[1]{%
	\normalfont\LARGE\sffamily\bfseries\raggedright #1 \nopagebreak[4]\vskip\halflineskip \hrule%
}

\setsecheadstyle{\ruledsec}
\newcommand{\sethangsec}{\setsecnumformat{\smash{\llap{{\csname the##1\endcsname}\hspace{.25em}}}}}
\newcommand{\setnohangsec}{\setsecnumformat{{\csname the##1\endcsname}\hspace{.25em}}}

\setsechook{\sethangsec}
\setsubsechook{\sethangsec}
\setsubsubsechook{\sethangsec}

\setparahook{\setnohangsec}
\setsubparahook{\setnohangsec}

\setsubsecheadstyle{\normalfont\large\sffamily\bfseries\raggedright}
\setsubsubsecheadstyle{\normalfont\sffamily\bfseries\raggedright}
\maxsecnumdepth{subsubsection}
\setsecnumdepth{subsubsection}

% toc
\maxtocdepth{section}
\settocdepth{section}

% Subfigures
\newsubfloat{figure}
\let\subfigure\subbottom

% Captions and such
\captiondelim{\hspace{1em}}
\captionnamefont{\small\sffamily\bfseries} % was \normalfont
\captiontitlefont{\small\sffamily} % was \normalfont
% \captionstyle[\raggedright]{}
% \captionstyle[centering]{}

\subcaptionlabelfont{\small\sffamily\bfseries} % was \normalfont
\subcaptionfont{\small\sffamily} % was \normalfont
\subcaptionstyle{\raggedright}
\shortsubcaption
\@namedef{thesubfigure}{\alph{subfigure}}

% Lists:
\firmlists
\renewcommand*{\descriptionlabel}[1]{\hspace\labelsep\normalfont\sffamily\bfseries #1}

% Pagestyle
\copypagestyle{verslag}{Ruled}
\makeevenhead{verslag}{\sffamily\leftmark}{}{}
\makeoddhead{verslag}{}{}{\sffamily\itshape\rightmark}
\pagestyle{verslag}

% Add a change to pagestyle for plain chapter start with page number coming out all to the right
\makeoddfoot{plain}{}{}{\thepage}

%Footnotes
\footmarkstyle{\textsuperscript{#1}}

%\setstocksize{240mm}{170mm}
\stockaiv
\settrimmedsize{240mm}{170mm}{*}
\settrims{20mm}{21mm}
\setulmarginsandblock{18mm}{22mm}{*}% was: {21.25mm}{35.42mm}{*}
\setlrmarginsandblock{20mm}{25mm}{*}% was: {25mm}{30mm}{*}
\setheadfoot{\onelineskip}{2\onelineskip}
\setheaderspaces{*}{10pt}{*}
\checkandfixthelayout
\showtrimson

%------------------------------------------------------
%% Tables
%% (inverted column heads)
\RequirePackage{colortbl}
\newcolumntype{H}{>{\columncolor{black}\color{white}}c}

%% Multirow entries
\RequirePackage{multirow}

%------------------------------------------------------
%% A variety of little things
%% typesetting a URL
\RequirePackage{url}

%% landscape
\RequirePackage{pdflscape}

%% Margin text width
\setlength{\marginparwidth}{0.8in}
\let\oldmarginpar\marginpar
\renewcommand\marginpar[1]{\-\oldmarginpar[\raggedleft\emph{\footnotesize #1}]%
      {\raggedright\emph{\footnotesize #1}}}

% TODO's
\newlength{\todowidth}
\setlength{\todowidth}{\marginparwidth}
\addtolength{\todowidth}{-4.7em}
\newcommand{\todo}[1]{
      \textsuperscript{\color{red!60}{\textsc{todo}}}
      \marginpar{%
    \fboxrule\heavyrulewidth
    \fcolorbox{red!60}{red!40}{%
	\parbox{\todowidth}{\textsc{todo}: #1}
    }}}

%------------------------------------------------------
%%Experimental font setting
%------------------------------------------------------
\usepackage[no-math]{fontspec}
 % Testing Lucida
%\setmainfont[
%BoldFont=timesbd.ttf,
%ItalicFont=timesi.ttf,
%BoldItalicFont=timesbi.ttf
%]{times.ttf}
\setmainfont{LucidaBright}%
[ Extension = .ttf,
  Path = ./lucida/,
  BoldFont=LucidaBright-Demi,
  ItalicFont=LucidaBright-Oblique,
  BoldItalicFont=LucidaBright-DemiItalic,
  SmallCapsFont = LucidaBrightSmallcaps]
\setsansfont{LucidaSans}%
[ Extension = .ttf,
  Path = ./lucida/,
  BoldFont=LucidaSans-Bold2,
  ItalicFont=LucidaSans-Italic,
  BoldItalicFont=LucidaSans-BoldItalic2]
\setmonofont{LucidaSans-Typewriter}%
[ Extension = .ttf,
  Path = ./lucida/,
  BoldFont=LucidaSans-TypewriterBold,
  ItalicFont=LucidaSans-TypewriterOblique,
  BoldItalicFont=LucidaSans-TypewriterBoldOblique]

%----------------------------------------------------
% Fallback glyph setting
%----------------------------------------------------

\DeclareMicrotypeAlias{LucidaBright}{TU-basic}
\DeclareMicrotypeAlias{LucidaBright-Demi}{TU-basic}
\DeclareMicrotypeAlias{LucidaBright-Oblique}{TU-basic}
\DeclareMicrotypeAlias{LucidaBright-DemiItalic}{TU-basic}
\DeclareMicrotypeAlias{LucidaBrightSmallcaps}{TU-basic}

\DeclareMicrotypeAlias{LucidaSans}{TU-basic}
\DeclareMicrotypeAlias{LucidaSans-Bold2}{TU-basic}
\DeclareMicrotypeAlias{LucidaSans-Italic}{TU-basic}
\DeclareMicrotypeAlias{LucidaSans-BoldItalic2}{TU-basic}

\DeclareMicrotypeAlias{LucidaSans-Typewriter}{TU-basic}
\DeclareMicrotypeAlias{LucidaSans-TypewriterBold}{TU-basic}
\DeclareMicrotypeAlias{LucidaSans-TypewriterOblique}{TU-basic}
\DeclareMicrotypeAlias{LucidaSans-TypewriterBoldOblique}{TU-basic}

%------------------------------------------------------
%% An empty argument test:
\RequirePackage{ifmtarg}

%------------------------------------------------------
% Finally, hyperref
\RequirePackage[unicode=true,%
	colorlinks=false,%
	pdfcreator={XeLaTeX},%
	bookmarksopenlevel=0,%
	bookmarksopen=true,%
    plainpages=false,%
    pdfpagelabels]{hyperref}

%------------------------------------------------------
% Special front page matters for a PhD thesis
\newcommand{\frontpages}{\include{support\thesis_frontpages_overleaf}\openright}
\newcommand{\@ThesisTitle}{$\big\langle$\texttt{use \small{$\backslash$SetThesisTitle\{\}\ }}$\big\rangle$}
\newcommand{\SetThesisTitle}[1]{\renewcommand{\@ThesisTitle}{#1}}
\newcommand{\@Candidate}{$\big\langle$\texttt{use \small{$\backslash$SetCandidate\{\}\ }}$\big\rangle$}
\newcommand{\SetCandidate}[1]{\renewcommand{\@Candidate}{#1}}
\newif\ifcoverdesigner\coverdesignerfalse
\newcommand{\@CoverDesigner}{$\big\langle$\texttt{use \small{$\backslash$SetCoverDesigner\{\}\ }}$\big\rangle$}
\newcommand{\SetCoverDesigner}[1]{\@ifmtarg{#1}{\coverdesignerfalse}{\coverdesignertrue}\renewcommand{\@CoverDesigner}{#1}}
\newcommand{\@Chair}{$\big\langle$\texttt{use \small{$\backslash$SetChair\{\}\{\}\ }}$\big\rangle$}
\newcommand{\@UnivChair}{}
\newcommand{\SetChair}[2]{\renewcommand{\@Chair}{#1}\renewcommand{\@UnivChair}{#2}}
\newcommand{\@Promoter}{$\big\langle$\texttt{use \small{$\backslash$SetPromoter\{\}\{\}\ }}$\big\rangle$}
\newcommand{\@UnivPromoter}{}
\newcommand{\SetPromoter}[2]{\renewcommand{\@Promoter}{#1}\renewcommand{\@UnivPromoter}{#2}}
\newif\ifsecondpromoter\secondpromoterfalse
\newcommand{\@SecondPromoter}{}\newcommand{\@UnivSecondPromoter}{}
\newcommand{\SetSecondPromoter}[2]{\@ifmtarg{#1}{\secondpromoterfalse}{\secondpromotertrue}%
                                   \renewcommand{\@SecondPromoter}{#1}
                                   \renewcommand{\@UnivSecondPromoter}{#2}}
\newif\ifassistantpromoter\assistantpromoterfalse
\newcommand{\@AssistantPromoter}{}\newcommand{\@UnivAssistantPromoter}{}
\newcommand{\SetAssistantPromoter}[2]{\@ifmtarg{#1}{\assistantpromoterfalse}{\assistantpromotertrue}%
                                   \renewcommand{\@AssistantPromoter}{#1}
                                   \renewcommand{\@UnivAssistantPromoter}{#2}}
\newif\ifsecondassistantpromoter\secondassistantpromoterfalse
\newcommand{\@SecondAssistantPromoter}{}\newcommand{\@UnivSecondAssistantPromoter}{}
\newcommand{\SetSecondAssistantPromoter}[2]{\@ifmtarg{#1}{\secondassistantpromoterfalse}{\secondassistantpromotertrue}%                                    \renewcommand{\@SecondAssistantPromoter}{#1}
                                   \renewcommand{\@UnivSecondAssistantPromoter}{#2}}
\newif\iffirstmember\firstmemberfalse
\newcommand{\@FirstMember}{}\newcommand{\@UnivFirstMember}{}
\newcommand{\SetFirstMember}[2]{\@ifmtarg{#1}{\firstmemberfalse}{\firstmembertrue}%
                                   \renewcommand{\@FirstMember}{#1}
                                   \renewcommand{\@UnivFirstMember}{#2}}
\newif\ifsecondmember\secondmemberfalse
\newcommand{\@SecondMember}{}\newcommand{\@UnivSecondMember}{}
\newcommand{\SetSecondMember}[2]{\@ifmtarg{#1}{\secondmemberfalse}{\secondmembertrue}%
                                   \renewcommand{\@SecondMember}{#1}
                                   \renewcommand{\@UnivSecondMember}{#2}}
\newif\ifthirdmember\thirdmemberfalse
\newcommand{\@ThirdMember}{}\newcommand{\@UnivThirdMember}{}
\newcommand{\SetThirdMember}[2]{\@ifmtarg{#1}{\thirdmemberfalse}{\thirdmembertrue}%
                                   \renewcommand{\@ThirdMember}{#1}
                                   \renewcommand{\@UnivThirdMember}{#2}}
\newif\iffourthmember\fourthmemberfalse
\newcommand{\@FourthMember}{}\newcommand{\@UnivFourthMember}{}
\newcommand{\SetFourthMember}[2]{\@ifmtarg{#1}{\fourthmemberfalse}{\fourthmembertrue}%
                                   \renewcommand{\@FourthMember}{#1}
                                   \renewcommand{\@UnivFourthMember}{#2}}
\newif\iffifthmember\fifthmemberfalse
\newcommand{\@FifthMember}{}\newcommand{\@UnivFifthMember}{}
\newcommand{\SetFifthMember}[2]{\@ifmtarg{#1}{\fifthmemberfalse}{\fifthmembertrue}%
                                   \renewcommand{\@FifthMember}{#1}
                                   \renewcommand{\@UnivFifthMember}{#2}}
% \newif\ifSenseDegree\SenseDegreeFalse
% \newcommand{\SenseDegree}{\SenseDegreeTrue}
\newif\ifSenseDegree\SenseDegreefalse
\newcommand{\SenseDegree}{\SenseDegreetrue}

\newcommand{\@DefenceDate}{$\big\langle$\texttt{use \small{$\backslash$SetDefenceDate\{\}\ }}$\big\rangle$}
\newcommand{\SetDefenceDate}[1]{\renewcommand{\@DefenceDate}{#1}}
\newcommand{\@DefenceTime}{$\big\langle$\texttt{use \small{$\backslash$SetDefenceTime\{\}\ }}$\big\rangle$}
\newcommand{\SetDefenceTime}[1]{\renewcommand{\@DefenceTime}{#1}}
\newcommand{\@UTRector}{prof. dr. ir. T. Veldkamp}
\newcommand{\SetUTRector}[1]{\@ifmtarg{#1}{}{\renewcommand{\@UTRector}{#1}}}
\newcommand{\@BirthDate}{$\big\langle$\texttt{use \small{$\backslash$SetBirthDate\{\}\ }}$\big\rangle$}
\newcommand{\SetBirthDate}[1]{\renewcommand{\@BirthDate}{#1}}
\newcommand{\@PlaceofBirth}{$\big\langle$\texttt{use \small{$\backslash$SetBirthPlace\{\}\ }}$\big\rangle$}
\newcommand{\SetBirthPlace}[1]{\renewcommand{\@PlaceofBirth}{#1}}
\newif\iffunnystuff\funnystufffalse
\newcommand{\@FunnyStuff}{}
\newcommand{\SetFunnyStuff}[1]{\@ifmtarg{#1}{\funnystufffalse}{\funnystufftrue}\renewcommand{\@FunnyStuff}{#1}}
\newcommand{\@DissertationNumber}{}
\newcommand{\SetDissertationNumber}[1]{\renewcommand{\@DissertationNumber}{#1}}
\newcommand{\@ISBN}{}
\newcommand{\SetISBN}[1]{\renewcommand{\@ISBN}{#1}}
\newif\ifissn\issnfalse
\newcommand{\@ISSN}{}
\newcommand{\SetISSN}[1]{\@ifmtarg{#1}{\issnfalse}{\issntrue}%
                         \renewcommand{\@ISSN}{#1}}
\newif\ifdoi\issnfalse
\newcommand{\@DOI}{}
\newcommand{\SetDOI}[1]{\@ifmtarg{#1}{\doifalse}{\doitrue}%
                         \renewcommand{\@DOI}{#1}}
                         \newif\ifdoi\issnfalse
\newif\ifprintshop\printshopfalse
\newcommand{\@PrintShop}{}
\newcommand{\SetPrintShop}[1]{\@ifmtarg{#1}{\printshopfalse}{\printshoptrue}%
                         \renewcommand{\@PrintShop}{#1}}
%------------------------------------------------------

%------------------------------------------------------
%% High-brow trickery to start listof environments appropriately with a \clearforchapter
%% Code stolen and adjusted from memoir.cls:
\def\listoffigures{%
    \clearforchapter
    \ensureonecol
    \par
    \begingroup
      \@nameuse{@lofmaketitle}
      % \if##1 Commented out to ensure that LoF gets included in Contents
        \ifmem@em@starred@listof\else
          \phantomsection
          \addcontentsline{toc}{chapter}{\listfigurename}
        \fi
      % \fi  Thus also outcommented
      \parskip\cftparskip
      \@nameuse{cftlofbeforelisthook}%
      \@starttoc{lof}%
      \@nameuse{cftlofafterlisthook}%
    \endgroup
    \restorefromonecol}
\def\listoftables{%
    \clearforchapter
    \ensureonecol
    \par
    \begingroup
      \@nameuse{@lotmaketitle}
      % \if##1  Commented out per see above
        \ifmem@em@starred@listof\else
          \phantomsection
          \addcontentsline{toc}{chapter}{\listtablename}
        \fi
      % \fi  % Thus also outcommented
      \parskip\cftparskip
      \@nameuse{cftlotbeforelisthook}%
      \@starttoc{lot}%
      \@nameuse{cftlotafterlisthook}%
    \endgroup
    \restorefromonecol}
%%
\newcommand*{\listsymbolname}{List of Symbols}
\newlistof{listofsymbols}{los}{\listsymbolname}
\newlistentry[chapter]{symbol}{los}{0}
\cftsetindents{table}{0em}{2.3em}
\def\listofsymbols{%
    \clearforchapter
    \ensureonecol
    \par
    \begingroup
      \@nameuse{@losmaketitle}
      \if##1
        \ifmem@em@starred@listof\else
          \phantomsection
          \addcontentsline{toc}{chapter}{\listsymbolname}
        \fi
      \fi
      \parskip\cftparskip
      \@nameuse{cftlosbeforelisthook}%
      \@starttoc{lot}%
      \@nameuse{cftlosafterlisthook}%
    \endgroup
    \restorefromonecol}

\def\listofdissertations{%
\chapter*{ITC dissertations}
A complete list of ITC dissertations is online on the ITC website:\\[4pt]
\href{http://www.itc.nl/research/phd/phd_graduates.aspx}{www.itc.nl/research/phd/phd\_graduates.aspx}.
\par
\vspace*{4mm}
\par
\noindent This dissertation has number \@DissertationNumber.}

\endinput
