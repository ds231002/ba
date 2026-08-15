#import "./globals.typ": *

// YML importer from: https://github.com/typst-community/glossarium/blob/8f42432617da1701b18af64c2f487dff3509dc60/examples/import-terms-from-yaml-file/main.typ
#let read-glossary-entries(file) = {
  let entries = yaml(file)

  assert(
    type(entries) == dictionary,
    message: "The glossary at `" + file + "` is not a dictionary",
  )

  for (k, v) in entries.pairs() {
    assert(
      type(v) == dictionary,
      message: "The glossary entry `" + k + "` in `" + file + "` is not a dictionary",
    )

    for key in v.keys() {
      assert(
        key in ("short", "long", "description", "group"),
        message: "Found unexpected key `" + key + "` in glossary entry `" + k + "` in `" + file + "`",
      )
    }

    assert(
      type(v.short) == str,
      message: "The short form of glossary entry `" + k + "` in `" + file + "` is not a string",
    )

    if "long" in v {
      assert(
        type(v.long) == str,
        message: "The long form of glossary entry `" + k + "` in `" + file + "` is not a string",
      )
    }

    if "description" in v {
      assert(
        type(v.description) == str,
        message: "The description of glossary entry `" + k + "` in `" + file + "` is not a string",
      )
    }

    if "group" in v {
      assert(
        type(v.group) == str,
        message: "The optional group of glossary entry `" + k + "` in `" + file + "` is not a string",
      )
    }
  }

  return entries.pairs().map(((key, entry)) => (
    key: key,
    short: eval(entry.at("short", default: ""), mode: "markup"),
    long: eval(entry.at("long", default: ""), mode: "markup"),
    description: eval(entry.at("description", default: ""), mode: "markup"),
    group: entry.at("group", default: ""),
  ))
}

#let read-glossary(files) = {
  let entries = ()

  if type(files) != array {
    files = (files,)
  }

  for file in files {
    let new = read-glossary-entries(file)

    for entry in new {
      let duplicate = entries.find(e => e.key == entry.key)
      if duplicate != none {
        panic("Found duplicate key `" + entry.key + "` in files `" + entry.file + "` and `" + duplicate.file + "`")
      }
    }

    entries += new
  }

  return entries
}
#let glossary_entries = read-glossary("user_data/0_0_glossary.yml")




// Template -------------------------------------------------------------------#
#let emptypagestyle = (
    background: none,
    footer: none,
    header: none,
)
#let defaultpagestyle = (
    background: none,
    footer: {
        set text(
            size: 0.8em,
            spacing: 1.7em,
        )
        line(length: 100%, stroke: (thickness: 0.5pt))
        context {
            let currentpagenumber = counter(page).get().first()
            if calc.rem(currentpagenumber, 2) == 1 {
                h(1fr)
            }
            counter(page).display(
                "1/1",
                both: true,
            )
        }
    },
    footer-descent: 0.5em,
    header: {
        context {
          if calc.odd(here().page()) {
            align(right, emph(hydra(1, display: (_, it) => it.body)))
          } else {
            align(left, emph(hydra(1, display: (_, it) => it.body)))
          }
          line(length: 100%, stroke: (thickness: 0.5pt))
          v(1em)
        }
    },
    header-ascent: 10%,
)

#let stpuas(
    title: "",
    subtitle: "",
    author: "",
    supervisor: "",
    thesistype: "",
    degree: "",
    studyprogram: "",
    assistance: "",
    studentid:  "",
    llm-no: true,
    llm-proofread: true,
    llm-used: true,
    acknowledgements: [],
    body
) = {
    // Custom Global Settings --------------------------------------------------------------------------------------------#
    //Set the document's basic properties.
    set document(author: author, title: title)
    set text(font: "Helvetica Neue LT Std")
    show math.equation: set text(weight: 400)

    show heading.where(depth: 1): body => {    
        {
          set page(..emptypagestyle)
          pagebreak(to:"odd", weak:true)
          set page(..defaultpagestyle)
        }
        block(v(6em) + text(size:22pt, body) + v(1em))
    }
    show heading: set block(above: 2em, below: 1em)
    show heading: text.with(weight:"extrabold")

    //Set cutom footer for Title Page as per USTP Guidelines
    set page(
        footer: [
            #set align(center)
            #set text(size: 0.56em)
            University of Applied Sciences St. Pölten, Campus-Platz~1, 3100~St. Pölten, T: +43 (2742) 313 228, F: +43 (2742) 313 228-339, E: csc\@ustp.at, I: www.ustp.at
        ],
        margin: (top: 8.5em)
    )

    //Customization for Table of Contents (Outline)
    show outline: set par(leading: 1.3em)
    //show outline: set text(size: 1.25em)

    //Only print Outline H1 Headings Bold and only if it is the table of contents (as opposed to list of figs etc.)
    show outline.entry.where(level: 1): it => {
        if it.element.func() == heading {
            strong(it)
        }
        else {
            it
        }
    }

    // Configure figures.
    set figure(
        numbering: "1",
        gap: 0.75em
    )

    //Customize citation coloring
    show cite: set text(rgb("#0000C1"))

    //Title Page --------------------------------------------------------------#
    //Header Image at the top
    set page(
        header: align(top+right, {
            v(1cm)
            image("logo_ustp_rgb_blau.svg", width: 8cm,)
        })
    )
    // Title
    v(8em)
    align(center)[
        #block(text(weight: 700, 2em, title))
    ]

  //Sub-Title Row
  align(center)[
    #block(text(size: 1.35em, subtitle))
  ]
  
  //Static Title Page Information
  v(2.5em)
  align(center)[
    #block(text(size: 1.5em, thesistype))
  ]
  v(2.5em)
  align(center)[
      #block(text(size: 1em,
          context {
              if text.lang == "en" {
                  "for attainment of the academic degree of"
              } else if text.lang == "de" {
                  "Angestrebter akademischer Grad"
              } else {
                "[ERROR] Unknown language: '"+lang+"'"
              }
          }
      ))
  ]
  v(0.5em)
  align(center)[
    #block(text(size: 1.5em, degree))
  ]
  v(2.5em)
  align(center)[
      #block(text(size: 1em,
          context {
              if text.lang == "en" {
                  "submitted by"
              } else if text.lang == "de" {
                  "eingereicht von"
              } else {
                  "[ERROR] Unknown language: '"+lang+"'"
              }
          }
      ))
  ]

  //Name of the student
  v(2.5em)
  align(center)[
    #block(text(size: 1.5em,)[
        #author\
        #studentid
    ])
  ]

  //Supervisor Info
  v(6.5em)
  align(left)[
      #text(size: 1em,
          context {
              if text.lang == "en" {
                  "in the\nUniversity Course "+studyprogram+" at University of Applied Sciences St. Pölten"
              } else if text.lang == "de" {
                  "im Rahmen des\nStudienganges "+studyprogram+" an der Hochschule für Angewandten Wissenschaften St. Pölten"
              } else {
                  "[ERROR] Unknown language: '"+lang+"'"
              }
          }
      )
      #v(2em)
      #text(size: 1em,
          context {
              if text.lang == "en" [
                  Supervision\
                  Advisor: #supervisor\
                  #if assistance != "" [
                      Assistance: #assistance\
                  ]
              ] else if text.lang == "de" [
                  Betreuung\
                  Betreuer/in: #supervisor\
                  #if assistance != "" [
                      Mitwirkung: #assistance\
                  ]
              ] else {
                  "[ERROR] Unknown language: '"+lang+"'"
              }
          }
      )
  ]


  //Ehrenwörtliche Erklärung -------------------------------------------------------------------------------------------#
//   set page(..emptypagestyle)
//   pagebreak(to:"odd")
//   set page(
//       footer: [
//           #set align(center)
//           #set text(size: 0.56em)
//           University of Applied Sciences St. Pölten, Campus-Platz 1, 3100 St. Pölten, T: +43 (2742) 313 228, F: +43 (2742) 313 228-339, E: csc\@ustp.at, I: www.ustp.at
//       ],
//       margin: (top: 8em),
//       header: align(top+right, {
//           v(1cm)
//           image("logo_ustp_rgb_blau.svg", width: 7cm,)
//       })
//   )
  
//   context {
//       if text.lang == "en" {
//           align(left)[
//               #heading(level: 1, outlined: false, numbering: none, [Declaration of Honour])
//               First name, Surname: #underline(author)\
//               Matriculation number: #underline(studentid)\
//               Type of Thesis: #underline(thesistype)\
//               Title of the thesis: #underline(title)

//               #v(1em)
//               I hereby affirm that
//               #v(0.5em)
//               #list(marker: ([•], [--]), body-indent: 1em,
//                   [I have written the work at hand on my own without help from others and I have used no other resources and tools than the ones acknowledged.],
//                   [I have complied with the Standards of good scientific practice in accordance with the University of Applied Sciences St. Pölten #underline(link("https://www.ustp.at/en/mediacenter/pdfs/others/satzungs_teil_5_gwp_2025_en.pdf", "Statute Part 05")) when writing this work.],
//                   [I have neither published nor submitted the work at hand to another higher education institution for assessment or in any other form as examination work.]
//               )

//               #v(1em)
//               Regarding the use of generative artificial intelligence tools such as chatbots, image generators, programming applications, paraphrasing and translation tools, I declare that
//               #v(0.5em)

//               #list(marker: text(font:"DejaVu Sans")[
//                   #if llm-no {
//                       sym.ballot.cross
//                   } else {
//                       sym.ballot
//                   }
//               ], body-indent: 1em,
//               [no generative artificial intelligence tools were used in the course of this work.])
//               #list(marker: text(font:"DejaVu Sans")[
//                   #if llm-proofread {
//                       sym.ballot.cross
//                   } else {
//                       sym.ballot
//                   }
//               ], body-indent: 1em,
//               [I have used generative artificial intelligence tools to proof-read this work.])
//               #list(marker: text(font:"DejaVu Sans")[
//                   #if llm-used{
//                       sym.ballot.cross
//                   } else {
//                       sym.ballot
//                   }
//               ], body-indent: 1em,
//               [I have used generative artificial intelligence tools to create parts of the content of this work. I certify that I have cited the original source of any generated content. The generative artificial intelligence tools that I used are acknowledged at the respective positions in the text.])    
              
//               #v(1em)
//               Having read and understood the #underline(link("https://www.ustp.at/en/mediacenter/pdfs/others/satzungs_teil_5_gwp_2025_en.pdf", "Statute 05")) --- Good Scientific Practice, I am aware of the consequences of a dishonest declaration.
//           ]
//       } else if text.lang == "de" {
//           align(left)[
//               #heading(level: 1, outlined: false, numbering: none, [Eidesstattliche Erklärung])
//               Vorname, Nachname: #underline(author)\
//               Matrikelnummer: #underline(studentid)\
//               Typ der Abschlussarbeit: #underline(thesistype)\
//               Titel der Abschlussarbeit: #underline(title)

//               #v(1em)
//               Ich erkläre an Eides statt, dass
//               #v(0.5em)
//               #list(marker: ([•], [--]), body-indent: 1em,
//                   [ich die vorliegende Arbeit selbständig und ohne fremde Hilfe verfasst, keine anderen als die angegebenen Quellen und Hilfsmittel benutzt habe.],
//                   [ich mich bei der Erstellung der Arbeit an die Standards guter wissenschaftlicher Praxis gemäß #underline(link("https://www.ustp.at/de/mediathek/pdfs/infoblaetter/gute_wissenschaftliche_praxis.pdf", [Satzungsteil 05])) der Hochschule für Angewandten Wissenschaften St. Pölten gehalten habe.],
//                   [ich die vorliegende Arbeit an keiner Hochschule zur Beurteilung oder in irgendeiner Form als Prüfungsarbeit vorgelegt oder veröffentlicht habe.]
//               )

//               #v(1em)
//               Über den Einsatz von Hilfsmitteln der generativen Künstlichen Intelligenz wie Chatbots, Bildgeneratoren, Programmieranwendungen, Paraphrasier- oder Übersetzungstools erkläre ich, dass
//               #v(0.5em)

//               #list(marker: text(font:"DejaVu Sans")[
//                   #if llm-no {
//                       sym.ballot.cross
//                   } else {
//                       sym.ballot
//                   }
//               ], body-indent: 1em,
//               [im Zuge dieser Arbeit kein Hilfsmittel der generativen Künstlichen Intelligenz zum Einsatz gekommen ist.])
//               #list(marker: text(font:"DejaVu Sans")[
//                   #if llm-proofread {
//                       sym.ballot.cross
//                   } else {
//                       sym.ballot
//                   }
//               ], body-indent: 1em,
//               [ich Hilfsmittel der generativen Künstlichen Intelligenz verwendet habe, um die Arbeit Korrektur zu lesen.])
//               #list(marker: text(font:"DejaVu Sans")[
//                   #if llm-used{
//                       sym.ballot.cross
//                   } else {
//                       sym.ballot
//                   }
//               ], body-indent: 1em,
//               [ich Hilfsmittel der generativen Künstlichen Intelligenz verwendet habe, um Teile des Inhalts der Arbeit zu erstellen. Ich versichere, dass ich jeden generierten Inhalt mit der Originalquelle zitiert habe. Das genutzte Hilfsmittel der generativen Künstlichen Intelligenz ist an entsprechenden Stellen ausgewiesen.])    
              
//               #v(1em)
//               Durch den #underline(link("https://www.ustp.at/de/mediathek/pdfs/infoblaetter/gute_wissenschaftliche_praxis.pdf", [Satzungsteil 05])) --- Gute Wissenschaftliche Praxis der Hochschule für Angewandten Wissenschaften St. Pölten bin ich mir über die Konsequenzen einer wahrheitswidrigen Erklärung bewusst.
//           ]
//       } else {
//           "[ERROR] Unknown language: '"+lang+"'"
//       }
//   }

    //Current Date and Place
    //v(6em)
    //align(left)[
    //    #text(size: 1em)[
    //        St. Pölten, #datetime.today().display()
    //        #v(1pt)
    //        #h(2.5em) #overline(offset:-1.2em, extent:2.5em)[(Place, Date)]
    //    ]
    //    #h(1fr)
    //    #overline(offset: -1.2em)[\(Signature Author\)]
    //]
  
    //Zusammenfassung (Deutsch) ------------------------------------------------
    set page(..emptypagestyle)
    pagebreak(to:"odd", weak:true)
    set page(..defaultpagestyle)
    align(left)[
        #heading(level: 1, outlined: false, numbering: none, [Kurzfassung])
        #include "user_data/0_1_abstract_de.typ"
    ]

    //Abstract -----------------------------------------------------------------
    // set page(..emptypagestyle)
    // pagebreak(to:"odd", weak:true)
    // set page(..defaultpagestyle)
    // align(left)[
    //     #heading(level: 1, outlined: false, numbering: none, [Abstract])
    //     #include "user_data/0_2_abstract_en.typ"
    // ]

    //Acknowledgements ---------------------------------------------------------------------------------------------------#
    // if acknowledgements != [] {
    //     set page(..emptypagestyle)
    //     pagebreak(to:"odd", weak:true)
    //     set page(..defaultpagestyle)
    //     align(left)[
    //         #heading(level: 1, outlined: false, numbering: none, 
    //             context {
    //                 if text.lang == "en" [
    //                     Acknowledgements
    //                 ] else if text.lang == "de" [
    //                     Danksagung
    //                 ] else {
    //                   "[ERROR] Unknown language: '"+lang+"'"
    //                 }
    //             }

    //     )
    //         #text[
    //             #acknowledgements
    //         ]
    //     ]
    // }
    //Table of Contents Page ---------------------------------------------------------------------------------------------#
    set page(..emptypagestyle)
    pagebreak(to:"odd", weak:true)
    set page(..defaultpagestyle)

    //Create Table of Contents
    outline(
        depth: 2,
    )

    set heading(numbering: "1.a)")
    //align(center, rotate(180deg, image("images/figuredivider.png", width: 15em)))

    // Reset the page counter
    //counter(page).update(n => 0)

    // Main body ---------------------------------------------------------------------------------------------------------#
 
    set par(justify: true)

    show: make-glossary
    register-glossary(glossary_entries)

    body

}
#let appendix(body) = {
    // Reset the heading counter. This makes the Appendix start with A
    counter(heading).update(0)
    // Change the heading numbering. This changes the numbering from 1,2,3 to A,B,C
    set heading(numbering: "A.1", supplement: [Appendix])

    show outline: set heading(bookmarked: true)
    // Appendix ---------------------------------------------------------------------------------------------------------#

    //----------------------------- Acronyms ----------------------------------------#
    [
        #set page(..emptypagestyle)
        #pagebreak(to:"odd", weak:true)
        #set page(..defaultpagestyle)
        #context {
            if text.lang == "en" {
                heading(level: 1, numbering: none, bookmarked:true, [Acronyms])
            } else if text.lang == "de" {
                heading(level: 1, numbering: none, bookmarked:true, [Akronyme])
            } else {
              "[ERROR] Unknown language: '"+lang+"'"
            }
        }
        <sec_acronyms>
        #print-glossary(
            glossary_entries
        )
    ]

    ////--------------------------- List of Figures -----------------------------------#
    [
        #set page(..emptypagestyle)
        #pagebreak(to:"odd", weak:true)
        #set page(..defaultpagestyle)
        #text(size: 0.8em)[
        #context {
            if text.lang == "en" {
                heading(level: 1, numbering: none, bookmarked:true, [List of Figures])
            } else if text.lang == "de" {
                heading(level: 1, numbering: none, bookmarked:true, [Abbildungsverzeichnis])
            } else {
              "[ERROR] Unknown language: '"+lang+"'"
            }
        }
        <sec_figures>
        #outline(
            title: none,
            target: figure.where(kind: image),
        )]
    ]
    
    //--------------------------- List of Tables ----------------------------------#
    [
        #set page(..emptypagestyle)
        #pagebreak(to:"odd", weak:true)
        #set page(..defaultpagestyle)
        #context {
            if text.lang == "en" {
                heading(level: 1, numbering: none, bookmarked:true, [List of Tables])
            } else if text.lang == "de" {
                heading(level: 1, numbering: none, bookmarked:true, [Tabellenverzeichnis])
            } else {
              "[ERROR] Unknown language: '"+lang+"'"
            }
        }
        <sec_tables>
        #text(size: 0.8em)[
        #outline(
            title: none,
            target: figure.where(kind: table),
        )]
    ]

    //--------------------------- List of Listings ----------------------------------#
    [
        #set page(..emptypagestyle)
        #pagebreak(to:"odd", weak:true)
        #set page(..defaultpagestyle)
        #context {
            if text.lang == "en" {
                heading(level: 1, numbering: none, bookmarked:true, [List of Listings])
            } else if text.lang == "de" {
                heading(level: 1, numbering: none, bookmarked:true, [Source Code Verzeichnis])
            } else {
              "[ERROR] Unknown language: '"+lang+"'"
            }
        }
        <sec_listings>
        #text(size: 0.8em)[
        #outline(
          title: none,
          target: figure.where(kind: raw),
        )]
    ]

    //-------------------------- List of References ---------------------------------#
    [
        #set page(..emptypagestyle)
        #pagebreak(to:"odd", weak:true)
        #set page(..defaultpagestyle)
        #context {
            if text.lang == "en" {
                heading(level: 1, numbering: none, bookmarked:true, [Bibliography])
            } else if text.lang == "de" {
                heading(level: 1, numbering: none, bookmarked:true, [Literaturverzeichnis])
            } else {
              "[ERROR] Unknown language: '"+lang+"'"
            }
        }
        <sec_bibli>
        #bibliography(
            title: none,
            style: "ieee",
            "user_data/0_X_literature.bib"
        )
    ]
    set page(..emptypagestyle)
    pagebreak(to:"odd", weak:true)
    set page(..defaultpagestyle)
    body
}
