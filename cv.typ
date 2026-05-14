// Anıl Sezgin — CV
// Data loaded from data.json — single source of truth
// Compiled with: typst compile cv.typ Anil_Sezgin_CV.pdf

#let data = json("data.json")

#set page(margin: (x: 1.2cm, top: 1.2cm, bottom: 1cm))
#set text(font: "Segoe UI", size: 8.5pt, fill: rgb("#444444"))
#set par(justify: true, leading: 0.5em)

// Colors
#let accent = rgb("#1a5c2a")
#let light-gray = rgb("#888888")

// Helpers
#let section(title) = {
  v(6pt)
  text(10pt, weight: "bold", fill: accent, upper(title))
  v(-5pt)
  line(length: 100%, stroke: 1.2pt + accent)
  v(3pt)
}

#let entry(title, subtitle, date, location) = {
  grid(
    columns: (1fr, auto),
    row-gutter: 1pt,
    text(weight: "bold", size: 9pt, title),
    align(right, text(size: 8pt, fill: light-gray, date)),
    text(fill: accent, size: 8.5pt, weight: "medium", subtitle),
    align(right, text(size: 8pt, fill: light-gray, location)),
  )
}

#let tag(body) = {
  box(
    fill: rgb("#e8f0e8"),
    radius: 3pt,
    inset: (x: 5pt, y: 2.5pt),
    text(size: 7.5pt, weight: "medium", fill: accent, body)
  )
}

#let divider() = {
  v(1pt)
  line(length: 100%, stroke: 0.4pt + rgb("#dddddd"))
  v(1pt)
}

#let items(..args) = {
  list(
    indent: 6pt, body-indent: 4pt, spacing: 3pt,
    marker: text(fill: accent, size: 7pt, "›"),
    ..args,
  )
}

// ── HEADER ──
#align(center)[
  #text(22pt, weight: "bold", fill: rgb("#1a1a1a"))[#data.nameUpper]
  #v(-5pt)
  #text(10pt, fill: accent, weight: "medium")[#data.title]
  #v(1pt)
  #text(8pt, fill: light-gray)[
    #link("mailto:" + data.contact.email)[#data.contact.email.replace("@", "\@")] #if data.contact.phone != "" { [#h(4pt)·#h(4pt) #data.contact.phone] } #h(4pt)·#h(4pt) #link(data.contact.linkedin)[linkedin.com/in/#data.contact.linkedinHandle] #h(4pt)·#h(4pt) #data.contact.location
  ]
]
#v(4pt)
#line(length: 100%, stroke: 0.5pt + rgb("#cccccc"))
#v(2pt)

// ── LEFT + RIGHT COLUMNS ──
#let right-col-width = 35%
#let gutter = 12pt

// Place the right column
#place(right, dx: 0pt, dy: 0pt,
  block(width: right-col-width)[
    #section("Education")
    #for edu in data.education {
      entry(edu.degree, edu.school, edu.start + " — " + edu.end, "")
      v(4pt)
    }

    #section("Areas of Expertise")
    #for (i, skill) in data.skills.expertise.enumerate() {
      if i > 0 { h(2pt) }
      tag(skill)
    }

    #section("Programming")
    #for (i, lang) in data.skills.programming.enumerate() {
      if i > 0 { h(2pt) }
      tag(lang)
    }

    #section("Tools & Platforms")
    #for (i, tool) in data.skills.tools.enumerate() {
      if i > 0 { h(2pt) }
      tag(tool)
    }

    #section("Languages")
    #for (i, lang) in data.skills.languages.enumerate() {
      if i > 0 { h(2pt) }
      tag(lang.name + " — " + lang.level)
    }

    #section("Honors")
    #for honor in data.honors {
      entry(honor.title, honor.subtitle, honor.year, "")
    }

    #section("Projects")
    #items(
      ..data.projects.map(p => {
        let label = if "cvLabel" in p { p.cvLabel } else { p.name }
        [*#label*]
      })
    )
  ]
)

// Left column
#block(width: 100% - right-col-width - gutter)[
  #section("Summary")
  #data.summary

  #section("Experience")

  #for (i, exp) in data.experience.enumerate() {
    if i > 0 { divider() }
    let date = if exp.end == exp.start { exp.start } else { exp.start + " — " + exp.end }
    entry(exp.role, exp.company + " — " + exp.department, date, exp.location)
    items(..exp.items.map(item => [#item]))
  }
]
