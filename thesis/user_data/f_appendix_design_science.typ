= Appendix Using the Design Science Methodology 

#let citeauthor(citekey, supplement:none) = [ #cite(citekey, form: "author")~#cite(citekey, form: "normal", supplement:supplement)]

Alright, let's be honest: writing a thesis can feel like staring up at a giant, slightly intimidating mountain. Where do you even start? How do you make sure you're on the right track? Will you ever see sunlight again?

This guideline is designed to be your trusty map and compass for that climb. Its purpose isn't to make your life *more* difficult by adding rules – quite the opposite! Think of it as a structured path designed to make the journey _easier_, clearer, and less prone to frantic, late-night "what-am-I-even-doing?!" moments. 

By following these guidelines, which are based on established scientific practice (specifically Design Science Research), you'll have a clear framework for your work. This helps ensure you cover all the necessary bases, structure your arguments logically, and conduct rigorous research.

*The ultimate goal?* To help you deliver a high-quality thesis you can be proud of, within the timeframe set by your curriculum, and with a process that's robust enough that *none of us – neither you nor your supervisors – end up having sleepless nights* worrying about the outcome. To prevent this, we have aligned this guideline with the known challenges faced by students and supervisors from other universities when developing and supervising their final theses #citeauthor(<creswell_research_2018>) #citeauthor(<jaakkola_practices_2022>). Your feedback on this process is, of course, valuable to us and always welcome.

Throughout this guideline, we will use the example of a project titled: _"PhishVis: Developing and Evaluating a Visual Tool for Understanding Common Phishing Attack Patterns."_

== Introduction
<intro>
*Purpose:* Sets the stage, introduces the problem and research scope, justifies the need for a solution (artefact), and outlines the thesis's contribution.

At the very beginning of your thesis, ensure clarity, precision, and an academic tone. Use established terminology accurately and spell out abbreviations when they first appear. Refer to #citeauthor(<creswell_research_2018>,supplement:[Chap. 4]) for general writing guidance.

    
=== Background & Motivation

Why is this topic important? What is the context?
- _Example:_ "Phishing attacks remain a major security threat, causing significant financial and data loss. Many users, particularly students, struggle to identify sophisticated attacks despite existing text-based warnings."

=== Problem Statement

Clearly define the specific practical problem or knowledge gap the designed artefact aims to address. See #citeauthor(<johannesson_introduction_2021>, supplement: "Chap. 5") for problem explication.

- _Example:_ "There is a lack of effective, engaging tools specifically designed to help non-expert users visualize and understand the underlying patterns and tactics used in common phishing attacks, leading to poor recognition rates."

=== Research Objectives / Artefact Goals

State 1-3 central objectives for the research, focusing on the intended capabilities and contribution of the artefact. 

Whether formulating RQs or objectives, ensure they are precise, focused, answerable within the scope of a thesis, and directly linked to the identified problem. Vague or overly broad questions/objectives make the research difficult to scope and evaluate. For general guidance on formulating research questions see #citeauthor(<creswell_research_2018>, supplement: "Chap. 7").

- Objectives must be clear, achievable, and directly related to solving the stated problem through an artefact. See #citeauthor(<creswell_research_2018>, supplement: "Chap. 7") for general guidance on formulating objectives). 

- _Example:_ "The primary objectives are: 1) To design and develop 'PhishVis,' a web-based tool visualizing common phishing tactics using interactive examples. 2) To evaluate PhishVis's effectiveness in improving users' understanding of phishing patterns and its usability."

#box(stroke: black, inset: 10pt, width: 100%)[*Check:* _Are the objectives clearly formulated? Are they focused on solving the problem via an artefact? Is the scope appropriate for a bachelor/master thesis?_]

=== Thesis Outline

Briefly describe the structure of the remaining chapters, typically following the DSR process and aligning with an IMRAD-like structure (Introduction, Methods, Results, and Discussion), see #citeauthor(<johannesson_introduction_2021>, supplement: "Chap. 10").

=== Summary of Expectations

    #box(fill: luma(230), stroke: black, inset: 10pt)[

- *Bachelor:* Focus on applying known DSR principles to design and evaluate a well-scoped artefact addressing a defined problem.

- *Master:* Should indicate a deeper engagement with the problem's complexity, potentially involving more novel design choices, rigorous evaluation, and a clearer articulation of the theoretical contribution alongside the practical one.

]

== Theoretical Background & Literature Review
<background>
*Purpose:* To demonstrate understanding of the existing knowledge (theoretical foundations, related problems, existing solutions/artefacts), position the research within the field, and refine the justification for the new artefact.

- Define key concepts (e.g., phishing, visualization techniques, usability).
- Summarize relevant theories (e.g., learning theories, visual perception theories).

=== Structure the Review 

Use our university's library (https://www.fhstp.ac.at/en/campus/library/online-resources) to access the relevant databases in our field (e.g., IEEE Xplore, ACM Digital Library, SpringerLink, Wiley Online Library, ScienceDirect). Critically review existing research and artefacts pertinent to the problem and objectives. Structure this review by categorizing the literature into *at least 2-3 distinct streams* (e.g., different theoretical lenses, different types of existing solutions, adjacent problem areas). To truly understand the nuances and establish your work's position within each relevant area, aim for comprehensive engagement; *a good target is to identify and discuss around 10 relevant scholarly works (journal articles, reputable conference papers, key books) per stream.* This depth demonstrates thoroughness and provides a solid foundation for your arguments. 

=== Position Your Work

The goal is not just to summarize but to *position your own work* within this landscape. Show how your research relates to, builds upon, or diverges from these streams, based on your comprehensive review. This demonstrates your understanding of the field and the specific niche your work occupies.

=== Justify Relevance 

Clearly articulating this positioning is crucial for arguing _why_ your proposed artefact or approach is necessary and relevant against the background of what already exists. Remember, the task is rarely to reinvent the wheel, but to make a targeted contribution. This is not just an "academic exercise" - this skill of justifying why a new approach is needed based on existing knowledge is also highly valuable in future industrial careers when proposing new projects or solutions.

- Clearly identify the gap or limitations of existing solutions that your proposed artefact will address, drawing upon your structured review and positioning.

- _Example:_ "Existing anti-phishing training often relies on static examples or text lists (Stream 1: Traditional Training, based on X studies). While some visualization tools exist for network traffic (Stream 2: General Security Visualization, drawing from Y studies), none focus specifically on interactively demonstrating common phishing _tactics_ for educational purposes (Positioning & Gap). This gap highlights the need for PhishVis."

=== Quality of Used References/Sources

Prioritize peer-reviewed journal articles and conference papers from reputable venues. 

=== Requirements for Inclusion 

    - All sources *must* be checked for predatory publishing status (e.g., consult resources like Beall's list archives (https://beallslist.net). In the context of academic publishing, the term "predatory" refers to journals or conferences that exploit the pressure on researchers to publish, often prioritizing profit over scholarly integrity. Domain-specific academic books are acceptable. 

    - All cited publications must meet recognized quality standards, i.e., *at least quartile Q3 according to SCImago Journal Rank* (https://www.scimagojr.com) for journal articles and *at least level B according to ICORE Conference Rank * (International Community for Open Research and Education, https://portal.core.edu.au/conf-ranks/) for conference papers. If the publication you want to cite is not listed in the respective database, it is not an eligible source for inclusion in your thesis.

    - Deviations from these standards must be discussed with your supervisor.

    - *How to check for predatory status:*  Use tools like the Directory of Open Access Journals (DOAJ, https://doaj.org/search/journals) for whitelisting open access journals. Be critical when consulting archived versions of blacklists (like Beall's list) as they may not be up-to-date. Initiatives like "Think. Check. Submit." (https://thinkchecksubmit.org) provide helpful criteria for assessing journal/publisher legitimacy. Ultimately, critical judgment based on multiple indicators (website quality, peer review process description, editorial board transparency, indexing status) is required.

    - Include relevant books (standard works, theories, methods).

=== Preprints 

Clarify with your supervisor whether preprints can be used as references or not. 

 #box(stroke: black, inset: 10pt)[*Check:* _Are sources high-quality, non-predatory, ranked appropriately? Is preprint use justified? Is the literature review structured into distinct streams with sufficient depth (\~10 sources/stream guideline considered)? Does it effectively position the thesis work?_]

=== Recency

Balance foundational works and recent (last 5-10 years) peer-reviewed publications. Emphasize recent publications, include seminal works.

#box(stroke: black, inset: 10pt, width: 100%)[*Check:* _Is there a reasonable mix of source types?_, _Is literature up-to-date? Are foundational works included?_, _Are the number of citations appropriate for underpinning your statements?_ *Master Only:* _Is the review critical and concise? Is the structure clear and depth sufficient? Is the positioning convincing? Is the gap convincingly derived?_]

=== Summary of Expectations
    
  #box(fill: luma(230), stroke: black, inset: 10pt)[

  - Introduce minimum *2-3 new refs/page (Bachelor theses)* or *4-5 new refs/page (Master theses)* in theoretical sections (e.g., related work, methodology) based on the above criteria for inclusion of references.

  - *Bachelor:* Comprehensive understanding of core literature relevant to the problem and proposed artefact type. Structure into streams and basic positioning expected, aiming towards depth.

  - *Master:* More critical and extensive review, sophisticated understanding of nuances, debates, limitations. Clear structure into streams with demonstrated comprehensive engagement (aiming for \~10 sources/stream) and strong, critical positioning to justify the research gap and design approach are required.
  ]
  
== Methodology
<methodology>

  *Purpose:* To describe and justify the *mandatory Design Science Research (DSR)* process followed to create and evaluate the artefact. This ensures transparency and scientific rigor.

  === Research Approach 

  Briefly state the DSR paradigm, emphasizing its problem-solving, artefact-centric nature. See #citeauthor(<johannesson_introduction_2021>, supplement: "Chap. 1") and #citeauthor(<hevner_design_2004>).

  === DSR Process Model

  Explicitly state the DSR process model being followed. The following 6-phase model based on #citeauthor(<peffers_design_2007>) is recommended:

    ==== Phase 1: Problem Explication & Motivation

       - Define the specific problem and justify the value of a solution artefact. Link to Introduction's problem statement (@intro).

       - _Example:_ "Phase 1 involved analyzing phishing statistics, reviewing literature on user security awareness (@background), and confirming the problem's relevance through preliminary discussions with university IT security staff. This confirmed the need for an improved educational tool like PhishVis."

    ==== Phase 2: Define Objectives/Requirements for Solution
      <methodology_phase2>
       - Infer concrete objectives and measurable requirements (functional and non-functional) for the artefact based on the problem.
      
       - _Example:_ "Based on the problem, objectives (@intro) were refined into requirements: 

        - R1: Visualize at least 5 common phishing tactics (e.g., fake sender, urgent call to action). 

        - R2: Use interactive elements. 

        - R3: Provide brief explanations for each tactic. 

        - R4: Be usable by undergraduate students with minimal instruction (usability target: System Usability Scale (SUS) score > 70). 

        - R5: Be web-based."

    ==== Phase 3: Design & Development

       - Create the artefact (construct, model, method, instantiation). Detail the architecture, design choices, algorithms, technologies used. Justify design decisions based on literature/theory.

       - _Example:_ "PhishVis was designed as a single-page web application using React for the frontend and D3.js for visualizations. Design choices were informed by visual perception principles (ref...). The architecture involved a component for selecting attack types and another for displaying interactive visualizations based on a predefined dataset of anonymized phishing examples." (Include diagrams/mockups if helpful).
    
    ==== Phase 4: Demonstration

       - Show the artefact's use in solving a relevant aspect of the problem (e.g., via a walkthrough, case study, simulation, proof-of-concept implementation).

       - _Example:_ "The tool's functionality was demonstrated through a walkthrough scenario: A user selects 'Fake Sender Address' tactic; PhishVis displays an example email header, highlighting inconsistencies and allowing interaction to reveal explanatory text."

    ==== Phase 5: Evaluation
       - Observe and measure how well the artefact supports the solution and meets the requirements defined in Phase 2. Choose appropriate evaluation methods (see @methodology_phase2). 

       - *Requirement:* The specific evaluation method(s) chosen (e.g., experiment, survey, case study, usability test) *must be clearly described, justified, and cited* based on established methodological literature (e.g., #citeauthor(<creswell_research_2018>), #citeauthor(<johannesson_introduction_2021>), #citeauthor(<wohlin_experimentation_2024>) or specific sources for the chosen method). *Describe metrics used*. (See also #citeauthor(<johannesson_introduction_2021>, supplement: "Chap. 7 & 8") and #citeauthor(<ivarsson_method_2011>) for rigor/relevance). 

       - *Master Only:* When planning the evaluation, Master's students should also proactively consider potential *threats to the validity* of their findings (see detailed discussion in @discussion).

       - _Example:_ "Evaluation involved: 

        - a) Usability testing with 10 target users using think-aloud protocol and the System Usability Scale (SUS) questionnaire (R4), following procedures outlined in \[cite usability testing source like Nielsen\].

        - b) A quasi-experimental pre/post-test knowledge quiz on phishing tactics administered to an experimental group (using PhishVis) and a control group (using traditional text materials) (R1, R2, R3), designed according to the principles in #citeauthor(<wohlin_experimentation_2024>, supplement: "Chap. 9"). Potential threats to validity, such as selection bias and maturation, were considered during the design \[details in @discussion\]." Describe participant recruitment, procedure, data analysis plan.

   ==== Phase 6: Communication

       - Disseminate the problem, artefact, and findings to relevant audiences (researchers, practitioners). This thesis itself is a primary communication channel. Introduce the Design Science Canvas (see @dscanvas) here.

       - _Example:_ "The primary communication is this thesis document. The Design Science Canvas summarizes the project for concise communication."

  - Cite established DSR literature as #citeauthor(<hevner_design_2004>), #citeauthor(<johannesson_introduction_2021>), #citeauthor(<peffers_design_2007>) and, as noted above, *specific evaluation methods literature*, e.g., #citeauthor(<creswell_research_2018>) and #citeauthor(<wohlin_experimentation_2024>).

  - #box(stroke: black, inset: 10pt)[*Check:* _Is DSR clearly stated as the methodology? Are the phases detailed? Are the specific methods used within phases (esp. evaluation) justified and properly cited? Is the overall evaluation plan rigorous?_ 
  
  *Master Only:* _Are threats to validity considered in planning/discussion?_, _Is the methodological justification robust? Is the procedure detailed? Are specific methods well-justified and cited? Is the evaluation plan sound and rigorously described? Is there evidence of considering threats to validity?_]

=== Summary of Expectations

    #box(fill: luma(230), stroke: black, inset: 10pt)[

      - *Bachelor:* Clear application of the DSR phases. Evaluation might use one standard method (e.g., usability testing, simple survey) correctly described and cited. Basic limitations should be mentioned in Discussion.

      - *Master:* More rigorous justification of design choices, potentially comparing alternatives. More robust evaluation, potentially using mixed methods (see @mixed_methods), with detailed description and justification based on methodological literature (including #citeauthor(<wohlin_experimentation_2024>) for experimental aspects). Deeper reflection on the process, including proactive consideration and discussion of threats to validity (see @discussion).

    ]

== Selecting and Describing Specific Research Methods

  While DSR provides the overall framework, specific phases, particularly *Evaluation (Phase 5)*, often require employing established research methods for data collection and analysis. It's crucial to understand the main approaches and choose appropriately for your artefact and objectives. These methods fall broadly into three categories (based primarily on #citeauthor(<creswell_research_2018>)):

=== Quantitative Methods

  - Test objective theories by examining relationships among variables. These variables can typically be measured, often on instruments, so that numbered data can be analyzed using statistical procedures. The goal is often generalizability or comparison.

  - *Characteristics:* Numerical data, statistical analysis, theory testing, often larger sample sizes.

  - *Examples Relevant to DSR Evaluation:*

    - *Experiments/Quasi-Experiments:* Testing the effect of the artefact (intervention) on an outcome compared to a control group or baseline. #citeauthor(<creswell_research_2018>, supplement: "Chap. 8") and #citeauthor(<wohlin_experimentation_2024>, supplement: "Chaps. 6 & 7, Part III") provide extensive details on planning, designing, and analyzing experiments in computer science. Useful for evaluating effectiveness (e.g., _Does PhishVis improve knowledge more than standard methods?_).

    - *Surveys:* Collecting numerical data on attitudes, perceptions, or behaviors using questionnaires with scaled items (e.g., Likert scales). See #citeauthor(<creswell_research_2018>, supplement: "Chap. 8") and #citeauthor(<wohlin_experimentation_2024>, supplement: "Chaps. 2 & 5"). Useful for measuring usability (e.g., _SUS scores for PhishVis_) or user satisfaction.
  - When using these methods, cite relevant chapters in #citeauthor(<creswell_research_2018>) or #citeauthor(<wohlin_experimentation_2024>) or other quantitative methodology textbooks.

=== Qualitative Methods

  - Explore and understand the meaning individuals or groups ascribe to a social or human problem. The process involves emerging questions and procedures, data typically collected in the participant's setting, inductive data analysis, and interpretations by the researcher, e.g., thematic analysis (e.g., #citeauthor(<naeem_step-by-step_2023>), or grounded theory #citeauthor(<chun_tie_grounded_2019>).

  - *Characteristics:* Non-numerical data (text, images, observations), thematic analysis, theory building/exploration, often smaller sample sizes, focus on depth and context.

  - *Examples Relevant to DSR Evaluation:*

    - *Case Studies:* In-depth exploration of the artefact's use in a specific, bounded context (e.g., a particular team using the artefact). See #citeauthor(<creswell_research_2018>, supplement: "Chap. 10"), #citeauthor(<johannesson_introduction_2021>, supplement: "Chap. 14") and #citeauthor(<wohlin_experimentation_2024>, supplement: "Chap. 5"). Useful for understanding _how_ and _why_ an artefact works (or doesn't) in practice.

    - *Interviews:* Gathering detailed perspectives from users about their experience with the artefact. See #citeauthor(<creswell_research_2018>, supplement: "Chaps. 9 & 10") and #citeauthor(<johannesson_introduction_2021>, supplement: "Chap. 6"). Useful for understanding usability issues, user needs, or contextual factors.

    - *Observations:* Watching users interact with the artefact in a natural or lab setting (e.g., think-aloud protocols during usability testing). See #citeauthor(<creswell_research_2018>, supplement: "Chap. 10") and #citeauthor(<johannesson_introduction_2021>, supplement: "Chap. 6"). Useful for identifying usability problems or understanding workflow integration.

  - When using these methods, cite relevant chapters from #citeauthor(<creswell_research_2018>), #citeauthor(<johannesson_introduction_2021>), #citeauthor(<wohlin_experimentation_2024>), or other qualitative methodology textbooks.

=== Mixed Methods
    <mixed_methods>
  - Combine both quantitative and qualitative forms of data collection and analysis. It involves integrating the two forms of data to provide a more complete understanding than either approach alone.

  - *Characteristics:* Collection and analysis of both numerical and textual/observational data; integration of findings. Can be complex to design and execute well.

  - *Examples:* Combining survey data (quantitative usability scores) with interview data (qualitative insights into usability problems) for a richer evaluation of an artefact like PhishVis. See #citeauthor(<creswell_research_2018>, supplement: "Chap. 6").

  - When using this approach, cite relevant chapters in #citeauthor(<creswell_research_2018>) or specific mixed methods literature.

=== Summary of Expectations

 #box(fill: luma(230), stroke: black, inset: 10pt)[
 You must clearly identify which specific method(s) you are using within your DSR project (especially for evaluation), explain _why_ it is appropriate for your objectives, describe the procedure according to that method's standards, and *cite the relevant methodological literature* (e.g., #citeauthor(<creswell_research_2018>), #citeauthor(<johannesson_introduction_2021>), #citeauthor(<wohlin_experimentation_2024>) or any other specific textbook that deals with applying mixed-methods research.]

== The Design Science Canvas
    <dscanvas>
    The Design Science Canvas provides a concise, structured overview of the entire DSR project on a single page, facilitating communication and reflection #citeauthor(<johannesson_introduction_2021>, supplement: "Chap. 4"). *It is also the perfect starting point for later succinctly presenting your thesis during the Bachelor/Master examination.* Filling it out is a mandatory part of the communication phase. 

    #set text(size: 10pt)
    #figure(

    table(
      columns: 3, // First column sized to content, second takes remaining space
      stroke: 0.5pt,        // Add thin lines for cells
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

      
    ),caption: [Design Science Canvas, from #citeauthor(<johannesson_introduction_2021>)
    ])

        #set text(size: 12pt)

     === Summary of Expectations

     #box(fill: luma(230), stroke: black, inset: 10pt)[

        You must develop a Design Science Canvas for your thesis project, potentially including it in the appendix or as a figure in the communication/conclusion section. As your thesis progresses and specific points become more defined, it will incrementally be refined.

        ]

== Artefact Description & Evaluation Results
<results>

  *Purpose:* To objectively present the designed artefact and the results of its evaluation.

  === Artefact Description

   Provide a detailed description of the final artefact (PhishVis). Use screenshots, diagrams, architecture descriptions. Explain its features and functionality in relation to the requirements (see @methodology_phase2).

    - _Example:_ "This section details the PhishVis tool. Figure X shows the main user interface... Figure Y illustrates the interactive visualization for the 'Fake Sender Address' tactic..."

  === Evaluation Results 

  Present the findings from the evaluation methods described in Phase 5 of the Methodology (@methodology). Use tables, graphs, and statistical summaries where appropriate. Report results objectively without interpretation.

    - _Example:_ "Usability testing yielded an average SUS score of 78.5 (SD=5.2), meeting R4. Qualitative feedback highlighted appreciation for interactivity but suggested clearer navigation... The pre/post-test showed a statistically significant improvement (p < 0.01) in knowledge scores for the PhishVis group compared to the control group (Table Z)."

  === Respond to Research Questions

  Elaborate the responses to your research questions, see @intro, based on the evaluation results. Make sure that the thought processes that led to your answers and interpretation of the evaluation results are logically comprehensible and verifiable also for others.

    - #box(stroke: black, inset: 10pt)[*Check:* _Is the artefact described clearly and in detail? Are evaluation results presented objectively and linked to the evaluation plan/metrics? Are tables/figures used effectively? Are all research questions comprehensively answered? Is the connection between the evaluation results and your responses to the research questions clear and transparent?_]

== Discussion
<discussion>

  *Purpose:* To interpret the evaluation results, relate them back to the literature and objectives, discuss implications, and acknowledge limitations.

  === Interpretation of Findings 

  What do the evaluation results mean regarding the artefact's success in meeting its objectives?

    - _Example:_ "The evaluation suggests PhishVis is a usable tool (SUS > 70) and effectively improves understanding of phishing tactics compared to traditional methods, thus meeting the primary objectives."

  === Link to Objectives & Requirements 

  Explicitly discuss how the findings relate to the objectives and requirements set out in Phase 2 of the Methodology (@methodology).

    - _Example:_ "The significant knowledge improvement addresses objective 1 and requirements R1-R3. The SUS score meets R4..."

  === Link to Existing Literature

   How do the findings compare/contrast with existing literature/artefacts reviewed earlier (@background)? Does the artefact offer advantages?

    - _Example:_ "Unlike text-based approaches discussed in Sec. 3, the visual, interactive nature of PhishVis appears more effective for learning, supporting theories of visual learning..."

  === Implications 

  What are the theoretical (e.g., for understanding visual security education) and practical (e.g., for university security training) implications?

    - _Example:_ "Practically, PhishVis offers a potentially valuable tool for universities. Theoretically, the results support the use of interactive visualization for security education..."

  === Limitations & Threats to Validity

    - Acknowledge the limitations of your study (e.g., scope, specific context, data limitations) #citeauthor(<creswell_research_2018>,supplement:"Chaps. 8 - 10"). Discuss and reflect upon your identified limitations with your supervisor to clarify their criticality and to what extent they shall be elaborated in your final thesis.

    - *Master Only:* Provide a more structured and critical discussion of limitations, often framed in scientific publications as *threats to validity*. This involves reflecting honestly on "what could have potentially gone wrong with my research?" or "which biases could have influenced my research?". Discuss how these factors might influence the interpretation of the results, based on the following structure:

      - *Construct Validity:* Did your evaluation measures (e.g., survey questions, observation categories) accurately capture the concepts you intended to measure (e.g., usability, effectiveness)? _Example: Did the knowledge quiz truly measure understanding of phishing tactics, or just recall of examples seen?_

      - *Internal Validity:* Can you be sure the artefact _caused_ the observed outcomes, or could other factors be involved? _Example: Did the PhishVis group improve simply due to more time spent on the task or because of the tool itself? Was there bias in how groups were selected?_

      - *External Validity (Generalizability):* To what extent can your findings be generalized to other people, settings, or times? _Example: Would PhishVis work as well for older adults or in a corporate setting? Was the evaluation context (e.g., lab study) artificial?_

      - *Conclusion Validity (if applicable):* Are your statistical conclusions sound? Was the sample size adequate? Were appropriate statistical tests used? #citeauthor(<wohlin_experimentation_2024>, supplement: "Chap. 10")

    - Structure this discussion logically. You can draw on general concepts of validity discussed in #citeauthor(<creswell_research_2018>, supplement: "Chaps. 8 - 10") or evaluation quality criteria in #citeauthor(<johannesson_introduction_2021>, supplement: "Chap. 8"). For more detailed informations on validity threats, sources like #citeauthor(<wohlin_experimentation_2024>, supplement: "Chap. 8") provide structured lists of threats and discuss validity prioritization.

    - This section demonstrates critical thinking. It's normal for research to have limitations; acknowledging them is a sign of scientific maturity. *Discussing potential threats and limitations with your supervisor throughout the process is highly encouraged.*

    - _Example:_ "Several threats to validity should be considered. Regarding construct validity, the knowledge quiz focused on recognition, which might not fully capture deeper understanding... External validity is limited as the participants were solely undergraduate students from one faculty, potentially limiting generalizability to other demographics... Internal validity in the quasi-experiment could be affected by potential pre-existing differences between the groups (a selection threat, see #citeauthor(<wohlin_experimentation_2024>, supplement: "Sec. 8.8") ..."

    - #box(stroke: black, inset: 10pt)[*Check:* _Is interpretation insightful? Is connection to literature critical?_ 

  *(Master Only:)* _Are implications well-articulated? Is the discussion of limitations/threats thorough, structured, and critical? Is the demarcation from your work to existing works clear?_]


=== Summary of Expectations

 #box(fill: luma(230), stroke: black, inset: 10pt)[

    - *Bachelor:* Focus on clear interpretation, linking to objectives, basic comparison with literature, identifying key limitations based on scope and context.

    - *Master:* Deeper interpretation, critical engagement with literature, nuanced discussion of implications (theoretical and practical), and a *structured, critical analysis of limitations framed as threats to validity* (referencing sources like #citeauthor(<creswell_research_2018>) and #citeauthor(<wohlin_experimentation_2024>). Clear articulation of the contribution despite limitations.

    ]

== Conclusion

- *Purpose:* To summarize the thesis, reiterate the contribution, and provide a final perspective.

  === Summary of Work & Contribution

   Briefly reiterate the problem, the designed artefact (_in our example: PhishVis_), key evaluation findings, and the main contribution (_e.g., a novel, evaluated tool for phishing education_).

  === Restate Achievement of Objectives / Answers to RQs

  Explicitly revisit each research objective and research question posed in the introduction. Summarize concisely how the evaluation results (@results) and subsequent discussion (@discussion) demonstrate that the objectives were met and provide the answers to the research questions. Ensure a clear link between findings and initial goals.
  
  === Future Research

  Suggest potential avenues for future work (e.g., _extending PhishVis with more tactics, evaluating with different populations, integrating real-time data_).

  #box(stroke: black, inset: 10pt)[*Check:* _Does the conclusion effectively summarize your research? Does it clearly state the contribution and how objectives were met? Are future research suggestions relevant?_]

    === Summary of Expectations

     #box(fill: luma(230), stroke: black, inset: 10pt)[

    A successful thesis following this DSR blueprint will demonstrate a comprehensive understanding and application of the research process. This includes:

        - A clearly articulated and motivated *problem*.

        - A thorough grounding in the relevant *literature*.

        - A well-justified *methodology*, detailing the DSR process and specific evaluation methods.

        - A detailed description of the designed *artefact*.

        - Rigorous *evaluation* demonstrating the artefact's utility and addressing the initial objectives.

        - Insightful *discussion* interpreting the results, linking them to theory, and critically reflecting on limitations.

        - Ultimately, the thesis should demonstrate the ability to conduct independent scientific work.
      

        ]




