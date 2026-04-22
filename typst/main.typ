#import "./globals.typ": *
#import "ustp-thesis.typ": *

//-----------------------------------------------------------------------------#
//-------------------- Document Settings --------------------------------------#
//-----------------------------------------------------------------------------#
#set text(
    lang: "de",
    region: "US",
    //lang: "de",
    //region: "AT",
)
#show: stpuas.with(
    title:      "Orchestrierung von Large Language Models im Kontext von Energiegemeinschaften",
    subtitle:   "SUBTITLE",
    thesistype: "Bachelorarbeit",
    //thesistype: "Bachelor thesis",
    //thesistype: "Bachelorarbeit",
    //thesistype: "Master thesis",
    //thesistype: "Masterarbeit",
    degree:     "Bachelor of Science (BSc)",
    //degree:     "Bachelor of Science in Engineering (BSc)",
    //degree:     "Diplom-Ingenieur/in",
    //degree:     "Master of Science in Engineering (MSc)",
    studyprogram: "Data Science and Business Analytics",
    author:     "David Schwarz",
    studentid:  "52308568",
    assistance: "",
    supervisor: "FH-Prof. Dipl.-Wirt.-Inf. Dr. Torsten Priebe",
    llm-no: true,
    llm-proofread: true,
    llm-used: true,
    acknowledgements: [
        I'd like to thank my supervisor for ... .
        I'd also like to thank my parents, my partner, my cat, my dog.
        Finally I'd like to thank my university~#cite(<fhstp_website>).

        Leave empty if you do not need it.
    ],
)

//-----------------------------------------------------------------------------#
//--------------------------- Global Show Rules -------------------------------#
//-----------------------------------------------------------------------------#

#show figure: set block(breakable: true)

#show: codly-init.with()
//Customize inline monospacing of text (inline code listings)
//#show raw.where(block: false): box.with(
//    fill: luma(240),
//    inset: (x: 3pt, y: 0pt),
//    outset: (y: 3pt),
//    radius: 0.85pt,
//)
//#show raw.where(block: true): block.with(
//    fill: luma(240),
//    inset: 10pt,
//    radius: 1.5pt,
//)

//Customize Headings using a show rule:
//#show heading.where(level: 1): it => [
//    #pad(bottom: 2em, smallcaps(it.body))
//]
//#show heading.where(level: 2): it => [
//    #pad(top: 1em, bottom: 1.5em, it.body)
//]
//#show heading.where(level: 3): it => [
//    #pad(top: 0.75em, bottom: 1em, it.body)
//]

//Set Heading numbering:
#set heading(
    numbering: "1.1.",
)

//-------------------------------------------------------------------------------#

#include "user_data/1_introduction.typ"
#include "user_data/2_background.typ"

#include "user_data/3_relatedwork.typ"

#include "user_data/4_methodology.typ"

#include "user_data/5_approach.typ"

#include "user_data/6_results.typ"

#include "user_data/7_discussion.typ"

#include "user_data/8_conclusion.typ"

#include "user_data/9_futurework.typ"


//################################################################################
//------------------------------- Appendix --------------------------------------#
//################################################################################

#show: appendix

#pagebreak(to:"odd", weak: true)
// #include "user_data/a_appendix_style.typ"
// #include "user_data/b_appendix_languages.typ"
// #include "user_data/c_appendix_latex.typ"
// #include "user_data/c_appendix_typst.typ"
// #include "user_data/d_appendix_presentation.typ"
// #include "user_data/e_appendix_expose.typ"
// #include "user_data/f_appendix_design_science.typ"
// #include "user_data/g_appendix_design_science_expose.typ"

