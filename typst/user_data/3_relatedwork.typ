#import "../globals.typ": *

#context if text.lang == "de" [
    = Stand der Forschung
    <sec:relatedwork>
] else [
    = Related Work
    <sec:relatedwork>
]

- 7-10 Seiten

== Tool-Use Ansätze
#cite(<paranjape2023artautomaticmultistepreasoning>) // ART
#cite(<NEURIPS2023_e3936777>) // gpt4tools
#cite(<alazraki-rei-2025-meta>) //meta reasoning

== Tool Auswahl
#cite(<huang2024metatoolbenchmarklargelanguage>) // metatool benchmark
#cite(<10889153>) // wtu-eval

- wie Autonomie untersucht wird
- welche Benchmarks existieren










// #ref(<sec:relatedwork>) contains the publications related to your work.

// This section demonstrates the extensive effort dedicated to researching whether prior attempts have addressed similar problems or scenarios.
// Here, we document the state of the art as it was known at the time of writing, thereby highlighting the distinctiveness of our work in the subsequent chapters.

// Our exploration covers various aspects:

// - *Distinguishing Factors*:
//     We elucidate how our work diverges from the existing body of published works.
//     What sets our scenario apart?
//     Are our goals or assumptions different?
//     Does our practical testing or prototype implementation offer a unique perspective?
//     Could advancements in computational power, compared to what was affordable a decade ago, enable the resolution of specific problems?
    
// - *Placement in Your Document*:
//     The placement of the Related Work chapter depends on the nature and complexity of your work.
//     It can be positioned near the beginning, possibly integrated with the background section, providing readers with essential context to understand your specific scenario.
//     Alternatively, it can be placed at the end, following your work and results but preceding the conclusion.
//     In this latter arrangement, readers gain a comprehensive understanding of your work before delving into the discussion of differences with existing works.
    
// - *Grouping and Categorization*:
//     When your literature search yields numerous related works, consider grouping them into subcategories.
//     It's important to remember that most of these references are likely to be entirely new to your readers, making categorization even more valuable.

// #ref(<tab:passes_paperreading>) depicts how to read computer science papers as part of a multi-stage process.

// #figure(
//     table(
//         columns: 2,
//         align: (right+horizon, left),
//         [*Pass*], [*Content to Read*],
//         table.cell(rowspan:4)[1], [Title, abstract, introduction],
//            [Section and subsection headers],
//            [Conclusion],
//            [References],
//         [2], [Content, omitting details (proofs, etc.)],
//         [3], [Detailed content (re-implementing the paper)],
//     ),
//     caption: [Reading Passes and their Corresponding Content for Research Papers.]
// )<tab:passes_paperreading>

// As a citation example, the famous halting problem~#cite(<turing_halting_prob>) introduced by #cite(form:"author", <turing_halting_prob>) is cited here.
// The corresponding BibTeX entry can be found in #ref(<lst:bibtex>).

// #figure(
//     ```bibtex
//     @article{turing_halting_prob,
//         author = {Turing, Alan Mathison},
//         title = {On Computable Numbers, with an Application to the Entscheidungsproblem},
//         year = {1937},
//         doi = {10.1112/plms/s2-42.1.230},
//         journal = {Proceedings of the London Mathematical Society},
//         volume = {s2-42},
//         number = {1},
//         publisher = {Oxford University Press},
//         issn = {1460-244X},
//         pages = {230--265},
//     }
//     ```,
//     caption: [BibTeX Entry for Turing's Halting Problem.]
// )<lst:bibtex>


