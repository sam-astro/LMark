%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LaTeX Templates Journal Article
% LaTeX Class
% Version 2.0 (February 7, 2023)
%
% This class originates from:
% https://www.LaTeXTemplates.com
%
% Author:
% Vel (vel@latextemplates.com)
%
% License:
% CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Modified by:
% Pakorn Wangsuekul (joe@ai.iit.tsukuba.ac.jp)
%
% Version 2.1 (July 9, 2023)
% Version 2.2 by Hiroaki Yano (July 11, 2023) 
% Version 2.3 (July 13, 2023)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------------------------------------------------------------
%	CLASS CONFIGURATION
%----------------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{LTJournalArticle}[2023/02/07 LaTeX Templates Journal Article Class v2.0]

\usepackage{etoolbox} % Required for conditional logic and easily changing commands

\newtoggle{unnumberedsections} % Create toggle for a class option
\settoggle{unnumberedsections}{false} % Default value for the class option
\DeclareOption{unnumberedsections}{\settoggle{unnumberedsections}{true}} % Set the class option toggle if the class option was used in the template

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}} % Pass through any extra options specified to the base class
\ProcessOptions\relax % Process class options

\LoadClass[twocolumn]{article} % Load the base class

%----------------------------------------------------------------------------------------
%	REQUIRED PACKAGES AND MISC CONFIGURATIONS
%----------------------------------------------------------------------------------------

\usepackage{graphicx} % Required for including images
\usepackage{float} % Enable [H] option for positioning figures
\graphicspath{{Figures/}{./}} % Specifies where to look for included images (trailing slash required)

\usepackage[bottom, hang]{footmisc} % Force footnotes to the bottom of the page and to the left margin
\setlength{\footnotemargin}{6pt} % Horizontal space between the footnote marker and text

%----------------------------------------------------------------------------------------
%	MARGINS
%----------------------------------------------------------------------------------------

\usepackage[
	top=2.5cm, % Top margin
	bottom=2.5cm, % Bottom margin
	left=2.5cm, % Left margin
	right=2.5cm, % Right margin
	footskip=1.11cm, % Space from the bottom margin to the baseline of the footer
	headsep=0.5cm, % Space from the top margin to the baseline of the header
	columnsep=0.75cm, % Space between text columns (in twocolumn mode)
	%showframe % Uncomment to show frames around the margins for debugging purposes
]{geometry}

%----------------------------------------------------------------------------------------
%	FONTS
%----------------------------------------------------------------------------------------

\usepackage{newtxtext,newtxmath} % Times New Roman font

\usepackage{microtype} % Slightly tweak font spacing for aesthetics

% Remove the mathpazo package
%\usepackage[sc]{mathpazo} % Use the Palatino font

\linespread{1.13} % Increase line spacing slightly

%----------------------------------------------------------------------------------------
%	HEADERS AND FOOTERS
%----------------------------------------------------------------------------------------

\usepackage{fancyhdr} % Required for customizing headers and footers
\pagestyle{fancy} % Enable custom headers and footers

\renewcommand{\headrulewidth}{0.5pt} % Top horizontal rule thickness

\fancyhf{} % Clear default headers/footers

\fancyhead[L]{\small{\headerleft}} % Left page header
\fancyhead[R]{\small{\headerright}} % Right page header

\fancyfoot[C]{\small{– \thepage\ –}} % Centered "– page number –" footer


%----------------------------------------------------------------------------------------
%	SECTIONS
%----------------------------------------------------------------------------------------

\usepackage{titlesec} % Required for modifying sections

\iftoggle{unnumberedsections}{ % Conditional logic for the unnumbered sections class options
	\setcounter{secnumdepth}{0} % Don't number sections at any level
}{
	\setcounter{secnumdepth}{2} % Number sections down to subsections
}

\titleformat
	{\section} % Section type being modified
	[block] % Section layout type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
	{\fontsize{10pt}{12pt}\selectfont\bfseries} % Text formatting of the whole section, i.e. label and title
	{\thesection} % Section label (e.g. number) and its formatting
	{0.5em} % Horizontal space between the section label and title
	{\raggedright} % Code before the section title (added \raggedright for left alignment)
	[\vspace{-7pt}] % Code after the section title

%------------------------------------------------

\titleformat
	{\subsection} % Section type being modified
	[block] % Section layout type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
	{\fontsize{10pt}{12pt}\selectfont} % Text formatting of the whole section, i.e. label and title
	{\thesubsection} % Section label (e.g. number) and its formatting
	{0.5em} % Horizontal space between the section label and title
	{\raggedright} % Code before the section title
	[\vspace{-7pt}] % Code after the section title

%------------------------------------------------

\titleformat
	{\subsubsection} % Section type being modified
	[runin] % Section layout type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
	{\fontsize{10pt}{12pt}\selectfont\bfseries} % Text formatting of the whole section, i.e. label and title
	{} % Section label (e.g. number) and its formatting
	{5pt} % Horizontal space between the section label and title
	{} % Code before the section title
	[] % Code after the section title

\titlespacing{\section}{0pt}{\dimexpr\baselineskip-5pt}{\dimexpr\baselineskip-5pt}
\titlespacing{\subsection}{0pt}{\dimexpr\baselineskip-5pt}{\dimexpr\baselineskip-5pt}
\titlespacing{\subsubsection}{0pt}{\dimexpr\baselineskip-5pt}{\dimexpr\baselineskip-5pt}

%----------------------------------------------------------------------------------------
%	TITLE SECTION CUSTOMIZATION
%----------------------------------------------------------------------------------------

\usepackage{titling} % Required for customizing the title section

\setlength{\droptitle}{-3\baselineskip} % Move the title up

\pretitle{\begin{flushleft}\fontsize{16pt}{16pt}\selectfont\bfseries} % Article title pre-formatting
\posttitle{\end{flushleft}} % Article title post-formatting

\preauthor{\begin{flushleft}\vspace{7pt}\fontsize{12pt}{12pt}\selectfont} % Author name pre-formatting
\postauthor{\vspace{-7pt}\end{flushleft}} % Author name post-formatting

\predate{\begin{flushleft}\fontsize{9pt}{10pt}\selectfont} % Date and affiliation pre-formatting
\postdate{\vspace{-1pt}\end{flushleft}} % Date and affiliation post-formatting

\patchcmd{\maketitle}{{plain}}{{fancy}}{}{} % Use the "fancy" page style for the first page
\AtBeginDocument{\thispagestyle{fancy}} % Apply the "fancy" page style to the first page

%----------------------------------------------------------------------------------------
%	ABSTRACT CUSTOMIZATION
%----------------------------------------------------------------------------------------

% Remove "Abstract" title from the abstract environment.
\AtBeginEnvironment{abstract}{\renewcommand{\abstractname}{}}

\usepackage{abstract} % Allows abstract customization

\renewcommand{\abstractnamefont}{\normalfont\bfseries\vspace{0.5\baselineskip}} % Set the "Abstract" text to bold (not shown by default)
\renewcommand{\abstracttextfont}{\fontsize{10pt}{\baselineskip}\selectfont\vspace{-2\baselineskip}} % Set the abstract size 10pt and adjust vertical spacing

\setlength{\absleftindent}{0pt} % Set the left indent of the abstract to 0pt
\setlength{\absrightindent}{0pt} % Set the right indent of the abstract to 0pt

%----------------------------------------------------------------------------------------
%	BIBLIOGRAPHY
%----------------------------------------------------------------------------------------

\usepackage[
	backend=biber, % Use the biber backend for compiling the bibliography
	citestyle=numeric, % In-text citation style
	bibstyle=numeric, % Bibliography style
	sorting=none, % Order references in the order in which they are used in the document
]{biblatex}

%----------------------------------------------------------------------------------------
%	TABLES
%----------------------------------------------------------------------------------------

\usepackage{booktabs} % Required for better horizontal rules in tables

\usepackage{array} % Required for manipulating table columns

\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}} % Define a new right-aligned paragraph column type
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}} % Define a new left-aligned (no justification) paragraph column type
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}} % Define a new centered paragraph column type

%----------------------------------------------------------------------------------------
%	CAPTIONS
%----------------------------------------------------------------------------------------

\usepackage{caption} % Required for customizing captions

\captionsetup{skip=6pt} % Vertical whitespace between figures/tables and the caption (default is 10pt)
\captionsetup{labelfont={bf,small}, textfont={it,small}} % Define caption font style

%----------------------------------------------------------------------------------------
%	LISTS
%----------------------------------------------------------------------------------------

\usepackage{enumitem} % Required for list customization

\setlist{noitemsep} % Customize spacing around and inside lists

%----------------------------------------------------------------------------------------
%	LINKS
%----------------------------------------------------------------------------------------

\usepackage{hyperref} % Required for links

\hypersetup{
	colorlinks=true, % Whether to color the text of links
	urlcolor=black, % Color for \url and \href links
	linkcolor=black, % Color for \nameref links
	citecolor=black, % Color of reference citations
}

%----------------------------------------------------------------------------------------
%	CUSTOM COMMANDS
%----------------------------------------------------------------------------------------

\newcommand{\headerleft}[1]{\renewcommand{\headerleft}{#1}}
\newcommand{\headerright}[1]{\renewcommand{\headerright}{#1}}

\newcommand{\footertext}[1]{\renewcommand{\footertext}{#1}}

