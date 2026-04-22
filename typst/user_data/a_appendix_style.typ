= Appendix Style

This appendix offers style-related tips and tricks.

== General
<sec:generalstyle>

- The titles and structure of your (sub-)chapters should be self-explanatory.
    Avoid placing text you intend to reference between a top-level (e.g., 9. Attacks) and a first-level (e.g., 9.1 By Brute-Force) heading, as it can lead to ambiguity in references.
    The text between the top-level and the first-level should only introduce the sublevels' topics and their purpose.

- Occasionally, it may be necessary to provide readers with a brief guide at the start of a chapter, explaining its relation to the previous chapter and what to expect next (this information should go between the top-level and first-level headings).

- Strive for a balance between sentence length.
    Overly long or overly short sentences can hinder understanding.

- Keep in mind that readers' short-term memory can only hold a few items at a time.
    As readers encounter new content, they must cross-reference it with prior knowledge and gradually transform it into long-term understanding. 

- If you are aware of limitations or issues in your work, mention them.
    Addressing known challenges and imperfections demonstrates foresight and honesty.

- Use the plural "we" when referring to actions in the text, even if you are the sole author.

- Exercise caution when referring to "common knowledge".
    Ensure that readers, especially those in the future, can discern the specific state of knowledge prevalent at the time of writing.

- When using relative time references like "years ago" or "some time ago", consider the reader's perspective.
    Would a future reader understand what is meant by "recently"?

- Avoid making absolute claims about knowledge unless you are an internationally recognized expert in the field.
    Qualify your statements with phrases like "To the best of our knowledge", or "We believe this to be the first combination of x and y".

- Clearly attribute the origin of facts or results.
    Ensure readers know whether something is a well established fact, an idea or proposal, a quote from another source, or a discovery made during your work.

- Avoid speculative statements and future predictions, except in an outlook chapter where appropriate.
    Clear communication is key, and stating outcomes as facts or expectations can enhance clarity.

- Minimize the use of passive voice in your writing.
    Active voice often improves the clarity of complex explanations.

- When communicating requirements, goals, or expectations, be unambiguous.
    Avoid terms like "should", "could", or "will be" when clarity is paramount.

== Non-text Content
<sec:non-text-content>

- Ensure that any non-text figures or objects (tables, diagrams, screenshots, photos, etc.) include a descriptive caption and are referenced at least once in the text.

- Place captions for non-text content below the respective figure or object.
    Captions should provide sufficient information for readers to understand the content without the need to reference the main text.

- Tables should avoid excessive decorative lines.
    Use only the minimum horizontal lines (top, bottom, and for separating the table header) and add vertical lines only when they enhance understanding and readability.

- When including program code, use a monospaced font and an appropriate keyword highlighter for the specific programming language (e.g., use the minted package).
    Consider line length for readability and page breaks for code that spans multiple pages.

- Understand the advantages and disadvantages of lossy (e.g., @jpeg) and lossless (e.g., @png) graphic file formats.

- Recognize the benefits and drawbacks of vector (e.g., @pdf) and bitmap (e.g., @png) file formats.

- Whenever possible, use vector formats (e.g., @pdf, @ps, @eps) for diagrams and graphics instead of bitmap formats.
    Embedding a @png into a @pdf does not convert it into a vector graphic.

- Keep in mind that some readers may be color-blind, and not all printers support color.
    Ensure that your illustrations are reasonably understandable even without color.

- Be mindful of color choices, especially for readers with red-green color blindness or deficiencies.
    Select colors that are distinguishable by a wide audience.

== Citations

- Give preference to references from international, reputable, peer-reviewed conferences or scientific journals.

- Remember that acceptance and publication at an international conference do not make something an absolute truth. 

- Avoid citing Wikipedia as a reference source.
    For a thorough understanding of this, consult established experts in your field.

- Avoid citing student bachelor theses and master theses, as their review processes are typically less rigorous.

- Refrain from citing blog articles by internet personalities without significant credentials.

- Avoid citing white-papers from company websites, as such documents are often driven by profit motives.

- In your bibliography, clearly indicate the type of work you are citing.
    If it's not evident, include a brief note (e.g., "PhD thesis").

- In cases where electronic sources are cited, ensure that the author is a well-established researcher in their respective field.

- Some references may only be available electronically in the field of computer science.
    If necessary, consider using a footnote with the URL for citing resources like software project homepages.

- Never claim the work and ideas of others as your own.
    Always provide proper references to earlier works and their results.
    When quoting short text passages verbatim, even from your previous work, cite the original source.

- If you use a Large Language Model such as ChatGPT#footnote(link("https://chatgpt.com/")) to write a paragraph, cite it accordingly (and don't forget about the Declaration.
    Misdeclaring the use of an @llm can fail your attempt).
    For the sake of the example, let's pretend that the original source for this paragraph is~#cite(form: "author",<shannon_theory_of_communication>).#footnote[Generated by ChatGPT 3.5 with the prompt "Could you please give me an example on how to use footnotes?"]

