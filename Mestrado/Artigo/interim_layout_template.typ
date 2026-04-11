#set page(
  paper: "us-letter",
  margin: (top: 0.75in, bottom: 1in, left: 0.75in, right: 0.75in),
)

#set par(justify: true, leading: 0.58em)
#set text(font: "Libertinus Serif", size: 9pt)

#set heading(numbering: "1")
#set figure.caption(position: bottom)
#set math.equation(numbering: "(1)")

#let conference = [WOODSTOCK’18, June 2018, El Paso, Texas USA]
#let doi = "10.1145/1234567890"
#let isbn = "978-1-4503-0000-0/18/06"
#let price = "$15.00"

#let authors = (
  (
    name: "Leonardo De Andrade Santos",
    dept: "Department Name",
    inst: "Institution/University Name",
    city: "City State Country",
    email: "email@email.com",
  ),
  (
    name: "FirstName Surname",
    dept: "Department Name",
    inst: "Institution/University Name",
    city: "City State Country",
    email: "email@email.com",
  ),
)

#let author-block(author) = [
  #align(center)[
    #text(weight: "bold")[#author.name] \
    #author.dept \
    #author.inst \
    #author.city \
    #link("mailto:" + author.email)[#author.email]
  ]
]

#let two-col(body) = columns(2, gutter: 0.25in, body)

#align(center)[
  #text(size: 20pt, weight: "bold")[*Insert Your Title Here*]
  #v(0.4em)
  #text(size: 11pt)[Insert Subtitle Here]
]

#v(1.2em)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 1em,
  ..authors.map(a => author-block(a)),
)

#v(1.2em)

#two-col[

#text(weight: "bold")[ABSTRACT]

In this sample-structured document, neither the cross-linking of 
float elements and bibliography nor metadata/copyright 
information is available. The sample document is provided in 
“Draft” mode and to view it in the final layout format, applying
the required template is essential with some standard steps.

These steps, which should require generation of the final output 
from the styled paper, are mentioned here in this paragraph. First, 
users have to run “Reference Numbering” from the “Reference 
Elements” menu; this is the first step to start the bibliography 
marking (it should be clicked while keeping the cursor at the 
beginning of the reference list). After the marking is complete, the 
reference element runs all the options under the “Cross Linking” 
menu.

For accuracy check of the structured paper, user can run the 
option Manuscript Validation. It informs the user of the wrong 
or missing values in the paper. The user must correct the paper as 
per validation messages and rerun Manuscript Validation.

Now, to generate the required layout of the paper, the user should 
select one of the template styles under the Define Template Style 
option (choose the required layout design, i.e. choose between 
Journals and Proceedings).

#v(0.8em)

#text(weight: "bold")[CCS CONCEPTS]

• Insert CCS text here  
• Insert CCS text here  
• Insert CCS text here  

#v(0.8em)

#text(weight: "bold")[KEYWORDS]

Insert keyword text, Insert keyword text, Insert keyword text, 
Insert keyword text

#v(0.8em)

#text(weight: "bold")[ACM REFERENCE FORMAT]

FirstName Surname, FirstName Surname and FirstName Surname. 2018. 
Insert Your Title Here: Insert Subtitle Here. In Proceedings of ACM 
Woodstock conference (WOODSTOCK’18). ACM, New York, NY, USA, 2
pages. https://doi.org/10.1145/1234567890

= Insert Heading Level 1

The updated template, user manuals, samples, and required fonts,
all are available at the URL 
https://www.acm.org/publications/proceedings-template. It 
contains said information for all three versions of MS Word 
(Windows and 2 versions of Mac). There are also separate links to
the user guide, which can be referred to by the user.

$ (-b \pm {b^2 - 4"ac"}) / (2a) $

Continuation part of Paragraph Text The user must style this 
paragraph in ParaContinue style, which follows immediately
after the DisplayFormula (numbered equation). The 
DisplayFormula style is applied only in case of a numbered 
equation. A numbered equation always has a number to its right.

$ (-b \pm {b^2 - "4ac"}) / (2a) $

The DisplayFormulaUnnum style is applied only in case of 
an unnumbered equation. An unnumbered display equation never 
contains an equation number to its right, and this unique property 
distinguishes it from a numbered equation.

#figure(
  rect(width: 100%, height: 2.2cm, stroke: 0.5pt + gray),
  caption: [Figure Caption and Image above the caption [In draft mode, Image will not appear on the screen]],
)

*Theorem/Proof/Lemma.* Insert text here for the enunciation 
or Math statement. Insert text here for the enunciation or Math 
statement. Insert text here for the enunciation or Math statement.

#quote(block: true)[
....Insert text here for the Quotation or Extract, Insert 
text here for the Quotation or Extract, Insert text here 
for the Quotation or Extract, Insert text here for the 
Quotation or Extract.
]

== Heading Level 2

In the below paragraph, it is explained how alt-txt value is placed 
in MS Word 2010.

=== Heading Level 3

Insert paragraph text here.

==== Heading Level 4

Insert paragraph text here.

= ACKNOWLEDGMENTS

Insert paragraph text here.

= REFERENCES

[1] Patricia S. Abril and Robert Plant, 2007. The patent holder's dilemma.

]

#place(bottom + left)[
  #text(size: 8pt)[#conference]
]

#place(bottom + center)[
  #text(size: 8pt)[© 2018 Copyright held by the owner/author(s).]
]

#place(bottom + right)[
  #text(size: 8pt)[#isbn \\ #price]
]