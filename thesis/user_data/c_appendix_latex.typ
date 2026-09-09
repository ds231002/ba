= Appendix LaTeX

- If a LaTeX template is available, utilize it.
    Your focus should be on the content rather than making extensive modifications.
    Adding packages and defining a few custom commands is typically sufficient.

- Especially when submitting a paper to an international conference, avoid modifying the style of the conference paper template.
    Uniform formatting ensures that authors concentrate on content rather than text layout aesthetics.

- Don't manually format every paragraph in LaTeX.
    If you encounter issues, first consult your supervisor before making extensive template modifications.

- The bibliography style is defined by your template, and entries are auto-generated from a .bib collection.
    Your work involves maintaining the bibliography entries.

- Use hyphens (-), en-dashes (--), and em-dashes (---) correctly.
    Hyphens connect compound words (e.g., pre-computer era), en-dashes indicate ranges (e.g., pages 5--10), and em-dashes are used in place of commas.

- Differentiate between English ("test") and German ("test") quotation marks.
    Utilize the \\enquote{enquotethistext} command for consistency.

- Understand the distinction between ```latex \emph{}``` and ```latex \textit{}```.

- Math-mode ($x$) is NOT a substitute for ```latex \textit{}``` (_x_).

- Place figures in positions {[tb]}.
    Avoid forcing {[h]} or {[h!]} positions.
    Adjust figure placement only after completing the text for final submission.

- For collaborative online writing, consider using LaTeX editors like Overleaf#footnote(link("https://www.overleaf.com/")).
    However, be aware of potential custom modifications.
    Verify that the local and online versions of your document match, especially before deadlines.


@lst:fhlogo provides an example of including pictures, graphics, or images.

#figure(
    ```latex
    \begin{figure}[ht]
        \centering
        \includegraphics[scale=0.2]{gfx/fh_logo}
        \caption{FH-Logo}\label{fig:fhlogo}
    \end{figure}
    ```,
    caption: [LaTeX code to include images.],
)<lst:fhlogo>


PGF, TikZ, and MetaPost are languages used for generating graphics.

Additional information about PGF/TikZ is available at:
- #link("https://en.wikibooks.org/wiki/LaTeX/PGF/TikZ")
- #link("http://www.texample.net/tikz/examples/")

