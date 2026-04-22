= Appendix Design Science Canvas for Expose

Use this template to iteratively develop and refine the core components of your Design Science Research project with your supervisor.

#grid(
  columns: (1fr, 3fr),
  gutter: 1em,
  align: left,
  [*Thesis Working Title:*], "____________________________________________________" ,
  [], "____________________________________________________" ,
  [], "____________________________________________________" ,
  [], "____________________________________________________" ,
  [*Student:*], "____________________________________________________",
  [*Supervisor(s):*], "____________________________________________________",
)

== Canvas
#set text(size: 10pt)

#figure(

table(
  columns: 3, 
  stroke: 0.5pt,  
    table.cell(colspan: 3)[*Practice*

    Describe the practice in which the problem exists, in particular its purpose, main activities and participants.],

    [*Problem*

  Describe the practical problem to be addressed. Formulate it in a precise and concise way. Explain why the problem is important and of general interest. Specify the stakeholders of the problem and how they are affected by it],

  table.cell(rowspan: 2)[*Research Process*

  Describe the research process of the project. State and justify the selection of research strategies and research methods. Possibly discuss which alternative research strategies and methods that were considered and why they were discarded. Clarify which of the main activities in design science (problem explication, requirements definition, design and development, and evaluation) that were included in the project. Describe how the research was carried out in the project. Discuss design rationale when applicable. Describe ethical issues encountered and how they were addressed.],

  [*Artefact*

  Specify the type of artefact. Describe the artefact, in particular, its structure, behaviour and functions. Describe how the artefact is to be used in the practice. Explain why and how the artefact can address the problem.],

  [*Requirements*

  Describe requirements on the artefact in a precise and concise way. Include functional as well as non-functional requirements. Justify the requirements by relating them to both the problem and the stakeholders.],

  [*Quality and Effects*

  Describe how well the artefact fulfils the requirements and to what extent it solves the practical problem. Describe the effects of using the artefact, including the side-effects. Discuss ethical and societal consequences of using the artefact.],

  table.cell(colspan: 3)[*Knowledge Base*

  Describe the knowledge base that was used as a foundation for the project. The knowledge base may include theories and models as well as existing artefacts. Explain how the knowledge base was utilized in the research process.],

  
))

== Tasks

An example Design Science Canvas with field descriptions is provided above. The following pages detail a 10-iteration process for refining your thesis project's canvas. Complete as many iterations as your supervisor requires to build a solid foundation for your thesis; you may not need all 10. 
Each iteration requires:

1. Your updated Design Science Canvas (revised per supervisor feedback).
2. A list of references cited in the canvas, with each source ranked using SCImago/ICORE as per the "Guideline for Structuring Thesis Research".
3. A feedback form completed by your supervisor with improvement suggestions.



#set text(size: 10pt)

#let n = 1
#while n < 11 {
  
 [
    #pagebreak()

#v(-1em)

#grid(
  columns: (80pt, 40pt, 100pt, 15pt, 50pt, 5pt),
  box(fill:luma(200), inset: 10pt)[*Student*],
  [#v(10pt)*Date:*],
  [#v(20pt) #line(length: 100%)],
  [],
  [#v(10pt)*Iteration:*],
  [#v(10pt) #n])


#set text(size: 10pt)

#figure(

table(
  columns: (1fr, 1fr, 1fr), 
  stroke: 0.5pt,       
    table.cell(colspan: 3)[*Practice*

    #v(10em)],

    [*Problem*

  ],

  table.cell(rowspan: 2)[*Research Process*
#v(30em)
  ],

  [*Artefact*
#v(18em)
  ],

  [*Requirements*

  ],

  [*Quality and Effects*
#v(18em)
  ],

  table.cell(colspan: 3)[*Knowledge Base*
#v(10em)
  ],

  
))

#set text(size: 10pt)

#pagebreak()
#v(-1em)
#grid(
  columns: (80pt, 40pt, 100pt, 15pt, 50pt, 5pt),
  box(fill:luma(200), inset: 10pt)[*Student*],
  [#v(10pt)*Date:*],
  [#v(20pt) #line(length: 100%)],
  [],
  [#v(10pt)*Iteration:*],
  [#v(10pt) #n])

#table(
  columns: (20pt, 380pt, 60pt), 
  stroke: none,
  align: center+horizon,
  table.header([*\#*],[*Citation*],[*Ranking*]),
    [*1*],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],

    [*2*],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],

    [*3*],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],

    [*4*],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],

    [*5*],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],

    [*6*],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],

    [*7*],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],

    [*8*],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],

    [*9*],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],

    [*10*],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],

    [*11*],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],

    [*12*],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],box(fill:luma(240), inset: 10pt, width:100%, height:40pt)[],
    

)

#pagebreak()

#v(-1em)

#grid(
  columns: (95pt, 40pt, 100pt, 15pt, 57pt, 5pt),
  box(fill:luma(200), inset: 10pt)[*Supervisor*],
  [#v(10pt)*Date:*],
  [#v(20pt) #line(length: 100%)],
  [],
  [#v(10pt)*Iteration:*],
  [#v(10pt) #n])


#box(width:100%, height:95%, stroke: black)[]





  ]
  n = n + 1
}

