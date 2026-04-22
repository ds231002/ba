= Appendix typst

- Don't manually format every paragraph in typst.
    If you encounter issues, first consult your supervisor before making extensive template modifications.

- The bibliography style is defined by your template, and entries are auto-generated from a .bib collection.
    Your work involves maintaining the bibliography entries.

- Use hyphens (-), en-dashes (--), and em-dashes (---) correctly.
    Hyphens connect compound words (e.g., pre-computer era), en-dashes indicate ranges (e.g., pages 5--10), and em-dashes are used in place of commas.

- Math-mode ($x$) is NOT a substitute for ```typ _italic_``` (_x_).

- Place figures in positions {[tb]}.
    Avoid forcing {[h]} or {[h!]} positions.
    Adjust figure placement only after completing the text for final submission.

- For collaborative online writing, consider using typst editors#footnote(link("https://typst.app/")).
    However, be aware of potential custom modifications.
    Verify that the local and online versions of your document match, especially before deadlines.


@fig:fhlogo provides an example of including pictures, graphics, or images.

#figure(
    image("../logo_ustp_rgb_blau.svg"),
    caption: [Example of how to include images.],
)<fig:fhlogo>


CetZ, and fletcher can be used for generating graphics from text.

For additional information see:
- #link("https://cetz-package.github.io/")
- #link("https://github.com/Jollywatt/typst-fletcher")

